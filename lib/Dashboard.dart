import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:shimmer/shimmer.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> paymentHistory = [
    {"date": "15/03/2025", "amount": "50 000 FCFA", "status": "Payé"},
    {"date": "10/03/2025", "amount": "25 000 FCFA", "status": "En attente"},
    {"date": "05/03/2025", "amount": "100 000 FCFA", "status": "En attente"},
  ];

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
    _calculatePaymentDetails();

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

    // Simulation de chargement
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _calculatePaymentDetails() {
    _totalPaid = 0;
    _totalDue = 0;

    for (var payment in paymentHistory) {
      var amount = int.parse(
        payment["amount"].replaceAll(" FCFA", "").replaceAll(" ", ""),
      );
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
                  paymentHistory[index]["status"] = "Payé";
                  _calculatePaymentDetails();
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Carte principale avec animation
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.2),
              end: Offset.zero,
            ).animate(_animation),
            child: FadeTransition(
              opacity: _animation,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF4338CA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6366F1).withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Éléments décoratifs
                    Positioned(
                      right: -50,
                      top: -50,
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(75),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -30,
                      bottom: -30,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),

                    // Contenu de la carte
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Résumé des paiements",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Cartes de résumé
                          SizedBox(
                            height: 110,
                            child: PageView(
                              controller: _pageController,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: _buildGlassCard(
                                    "Montant payé",
                                    _totalPaid,
                                    Icons.paid,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0,
                                  ),
                                  child: _buildGlassCard(
                                    "Montant total",
                                    _totalDue,
                                    Icons.account_balance_wallet,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: _buildGlassCard(
                                    "Reste à payer",
                                    _remainingAmount,
                                    Icons.payment,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Indicateurs de page
                    Positioned(
                      bottom: 5,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(
                                _pageController.hasClients &&
                                        (_pageController.page?.round() ?? 0) ==
                                            index
                                    ? 1
                                    : 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),

          // Section Historique
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.2),
              end: Offset.zero,
            ).animate(_animation),
            child: FadeTransition(
              opacity: _animation,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Historique des paiements",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey[800],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "${paymentHistory.length} transactions",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6366F1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildPaymentHistoryList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassCard(String title, int amount, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 28),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            "${_formatCurrency.format(amount)} FCFA",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentChart() {
    // Transformer les données d'historique pour le graphique
    List<double> values = [];
    for (var payment in paymentHistory) {
      values.add(
        double.parse(
          payment["amount"].replaceAll(" FCFA", "").replaceAll(" ", ""),
        ),
      );
    }

    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        sections: List.generate(paymentHistory.length, (i) {
          final payment = paymentHistory[i];
          final value = double.parse(
            payment["amount"].replaceAll(" FCFA", "").replaceAll(" ", ""),
          );
          final isPaid = payment["status"] == "Payé";

          // Couleurs différentes selon le statut de paiement
          final color =
              isPaid ? const Color(0xFF6366F1) : const Color(0xFFF87171);

          return PieChartSectionData(
            color: color,
            value: value,
            title: '${value.toInt()} FCFA',
            radius: 70,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            badgeWidget: _Badge(
              payment["date"],
              isPaid ? const Color(0xFF6366F1) : const Color(0xFFF87171),
              isPaid ? Icons.check_circle : Icons.pending,
            ),
            badgePositionPercentageOffset: 1.2,
          );
        }),
        borderData: FlBorderData(show: false),
      ),
    );
  }

  Widget _buildPaymentHistoryList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: paymentHistory.length,
        separatorBuilder:
            (context, index) =>
                Divider(color: Colors.grey.withOpacity(0.2), height: 1),
        itemBuilder: (context, index) {
          final payment = paymentHistory[index];
          final isPaid = payment["status"] == "Payé";

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color:
                    isPaid
                        ? const Color(0xFF6366F1).withOpacity(0.1)
                        : const Color(0xFFF87171).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  isPaid ? Icons.check_circle : Icons.pending,
                  color:
                      isPaid
                          ? const Color(0xFF6366F1)
                          : const Color(0xFFF87171),
                  size: 24,
                ),
              ),
            ),
            title: Text(
              payment["amount"],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              "Date: ${payment["date"]}",
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            trailing:
                isPaid
                    ? const Chip(
                      label: Text(
                        "Payé",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Color(0xFF6366F1),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                    )
                    : ElevatedButton(
                      onPressed: () => _confirmPayment(payment, index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Payer",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
          );
        },
      ),
    );
  }
}

// Badge personnalisé pour le graphique
class _Badge extends StatelessWidget {
  final String date;
  final Color color;
  final IconData icon;

  const _Badge(this.date, this.color, this.icon);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 4),
          Text(
            date,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
