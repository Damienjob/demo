import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'api_service.dart';
import 'payment_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> paymentHistory = [];
  List<PaymentData> originalPayments = []; // Pour stocker les paiements originaux avec leurs ID
  bool _isLoadingPayments = true;
  String _errorMessage = '';

  int _totalPaid = 0;
  int _totalDue = 0;
  int _remainingAmount = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isLoading = true;
  final _pageController = PageController();
  final _formatCurrency = NumberFormat.currency(
    locale: 'fr_FR',
    symbol: '',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();

    // Animation pour les éléments
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();

    // Charger les données de paiement de l'API
    _fetchPaymentData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // Méthode pour récupérer les données de paiement depuis l'API
  Future<void> _fetchPaymentData() async {
    setState(() {
      _isLoadingPayments = true;
      _errorMessage = '';
    });

    try {
      // Appeler le service API pour récupérer les paiements
      final payments = await ApiService.getClientPayments();
      
      if (mounted) {
        setState(() {
          // Sauvegarder les paiements originaux
          originalPayments = payments;
          
          // Convertir les objets PaymentData en Map pour l'affichage
          paymentHistory = payments.map((payment) => payment.toMap()).toList();
          paymentHistory.sort((a, b) {
            try {
              // Format réel: "yyyy-MM-dd"
              final dateFormat = DateFormat("yyyy-MM-dd");
              final dateA = dateFormat.parse(a["date"] ?? "2000-01-01");
              final dateB = dateFormat.parse(b["date"] ?? "2000-01-01");
              // Tri ascendant (plus ancien d'abord)
              return dateA.compareTo(dateB);
            } catch (e) {
              print('Erreur lors du tri des dates: $e');
              return 0; // En cas d'erreur, conserver l'ordre actuel
            }
          });
          
          _isLoadingPayments = false;

          // Calculer les détails de paiement
          _calculatePaymentDetails();

          // Désactiver l'animation de chargement après un délai
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          });
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoadingPayments = false;
          _isLoading = false;

          // Si pas de données, initialiser avec une liste vide
          if (paymentHistory.isEmpty) {
            paymentHistory = [];
          }

          _calculatePaymentDetails();
        });

        // Afficher l'erreur à l'utilisateur
        _showErrorNotification(context, 'Erreur de chargement des données: $e');
      }
    }
  }

  void _calculatePaymentDetails() {
    _totalPaid = 0;
    _totalDue = 0;

    for (var payment in paymentHistory) {
      var amountStr = payment["amount"]
          .toString()
          .replaceAll(" FCFA", "")
          .replaceAll(" ", "");
      // Gérer le cas où amount n'est pas un nombre valide
      var amount = 0;
      try {
        amount = int.parse(amountStr);
      } catch (e) {
        print('Erreur de parsing du montant: $amountStr');
        // Essayons avec la conversion double si int échoue
        try {
          amount = double.parse(amountStr).toInt();
        } catch (e) {
          print('Erreur de parsing du montant en double: $amountStr');
        }
      }

      if (payment["status"] == "Payé") {
        _totalPaid += amount;
      }
      _totalDue += amount;
    }

    _remainingAmount = _totalDue - _totalPaid;
  }

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          title: const Text(
            'Déconnexion',
            style: TextStyle(
              color: Color(0xFF6366F1),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Voulez-vous vraiment vous déconnecter ?',
            style: TextStyle(color: Color(0xFF6366F1)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Annuler',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
              onPressed: () async {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                if (context.mounted) {
                  _showSuccessNotification(context, "Déconnexion effectuée !");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
              },
              child: const Text(
                'Déconnexion',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 10),
            Text(message),
          ],
        ),
        backgroundColor: const Color(0xFF6366F1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(child: Text(message, maxLines: 2)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _confirmPayment(Map<String, dynamic> payment, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Confirmer le paiement',
            style: TextStyle(
              color: Color(0xFF6366F1),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Voulez-vous confirmer le paiement de ${payment["amount"]} ?',
            style: const TextStyle(color: Color(0xFF6366F1)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                setState(() {
                  // Mise à jour de l'affichage
                  paymentHistory[index]["status"] = "Payé";
                  _calculatePaymentDetails();
                  
                  // Idéalement, ici on ferait une requête API pour mettre à jour le statut
                  // côté serveur, mais pour cette version, on se contente de mettre à jour l'UI
                });
                Navigator.of(context).pop();
                _showSuccessNotification(
                  context,
                  "Paiement effectué avec succès !",
                );
              },
              child: const Text(
                'Confirmer',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Méthode pour rafraîchir les données
  Future<void> _refreshData() async {
    await _fetchPaymentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6366F1),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo "C" avec animation
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 800),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "C",
                        style: TextStyle(
                          color: Color(0xFF6366F1),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            // Titre "Tableau de bord" avec animation
            FadeTransition(
              opacity: _animation,
              child: const Text(
                "Tableau de bord",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            // Icône Déconnexion
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                _handleLogout(context);
              },
            ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Container(height: 20),
        ),
      ),
      body: _isLoading ? _buildShimmerLoading() : _buildMainContent(),
      // Ajout du widget RefreshIndicator pour permettre le rafraîchissement par glissement
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshData,
        backgroundColor: const Color(0xFF6366F1),
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 40,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return RefreshIndicator(
      onRefresh: _refreshData,
      color: const Color(0xFF6366F1),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPaymentSummary(),
            const SizedBox(height: 25),
            _buildPaymentProgress(),
            const SizedBox(height: 25),
            _buildPaymentHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSummary() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (1 - _animation.value) * 50),
          child: Opacity(
            opacity: _animation.value,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6366F1).withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Résumé des paiements',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${paymentHistory.length} échéances',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildPaymentInfoItem(
                        'Total à payer',
                        '${_formatCurrency.format(_totalDue)} FCFA',
                        Icons.account_balance,
                      ),
                      _buildPaymentInfoItem(
                        'Déjà payé',
                        '${_formatCurrency.format(_totalPaid)} FCFA',
                        Icons.check_circle,
                      ),
                      _buildPaymentInfoItem(
                        'Reste à payer',
                        '${_formatCurrency.format(_remainingAmount)} FCFA',
                        Icons.warning,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentInfoItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentProgress() {
    final progressValue = _totalDue == 0 ? 0.0 : _totalPaid / _totalDue;
    final progressPercentage = (progressValue * 100).toInt();

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (1 - _animation.value) * 50),
          child: Opacity(
            opacity: _animation.value,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Progression des paiements',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Container(
                              height: 12,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE2E8F0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 1500),
                              curve: Curves.easeInOut,
                              height: 12,
                              width: MediaQuery.of(context).size.width * 
                                  progressValue * 0.7, // Ajuster la largeur en fonction de l'écran
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '$progressPercentage%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  if (_totalDue > 0)
                    Text(
                      'Vous avez payé $_totalPaid FCFA sur $_totalDue FCFA',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentHistory() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (1 - _animation.value) * 50),
          child: Opacity(
            opacity: _animation.value,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Historique des paiements',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${paymentHistory.length} transactions',
                          style: const TextStyle(
                            color: Color(0xFF6366F1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _isLoadingPayments
                      ? _buildLoadingPaymentHistory()
                      : _buildPaymentHistoryList(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingPaymentHistory() {
    return Center(
      child: Column(
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
          ),
          const SizedBox(height: 20),
          Text(
            'Chargement des paiements...',
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentHistoryList() {
    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48,
            ),
            const SizedBox(height: 10),
            Text(
              'Erreur: $_errorMessage',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchPaymentData,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Réessayer',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }

    if (paymentHistory.isEmpty) {
      return Center(
        child: Column(
          children: [
            const Icon(
              Icons.history,
              color: Colors.grey,
              size: 48,
            ),
            const SizedBox(height: 10),
            Text(
              'Aucun paiement disponible',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: paymentHistory.length,
      itemBuilder: (context, index) {
        final payment = paymentHistory[index];
        final statusColor = payment["status"] == "Payé"
            ? Colors.green
            : payment["status"] == "En attente"
                ? Colors.orange
                : const Color(0xFF6366F1);

        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            // Calculer un délai d'animation basé sur l'index
            final delayedAnimation = Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Interval(
                  0.2 + (index * 0.1 > 0.5 ? 0.5 : index * 0.1),
                  1.0,
                  curve: Curves.easeOut,
                ),
              ),
            );

            return Transform.translate(
              offset: Offset(
                (1 - delayedAnimation.value) * 50,
                0,
              ),
              child: Opacity(
                opacity: delayedAnimation.value,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Icon(
                            payment["status"] == "Payé"
                                ? Icons.check_circle
                                : Icons.pending_actions,
                            color: const Color(0xFF6366F1),
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              payment["description"] ?? 'Paiement',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              payment["date"] ?? 'Date inconnue',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            payment["amount"] ?? '0 FCFA',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              payment["status"] ?? 'Inconnu',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: statusColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (payment["status"] == "En attente")
                        IconButton(
                          icon: const Icon(
                            Icons.credit_card,
                            color: Color(0xFF6366F1),
                          ),
                          onPressed: () => _confirmPayment(payment, index),
                          tooltip: 'Payer maintenant',
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}