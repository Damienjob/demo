import 'login.dart';
import 'package:flutter/material.dart';
// import 'main.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Variables d'état pour le dashboard
  int _selectedIndex = 0;
  final List<String> _titles = ['Dashboard', 'Statistiques', 'Messages', 'Profil'];
  
  // Vous pouvez ajouter d'autres variables d'état ici selon vos besoins
  bool _isLoading = false;
  
  @override
  void initState() {
    super.initState();
    // Initialisation des données, comme charger les informations utilisateur
    _loadDashboardData();
  }
  
  // Simuler le chargement des données du dashboard
  Future<void> _loadDashboardData() async {
    setState(() {
      _isLoading = true;
    });
    
    // Simuler un appel API ou chargement de données
    await Future.delayed(const Duration(milliseconds: 800));
    
    setState(() {
      _isLoading = false;
    });
  }
  
  // Méthode pour gérer les changements d'onglet
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadDashboardData,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Déconnexion
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bienvenue sur votre ${_titles[_selectedIndex].toLowerCase()}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: _buildMainContent(),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistiques',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
  
  // Construire le contenu principal en fonction de l'onglet sélectionné
  Widget _buildMainContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboardGrid();
      case 1:
        return _buildStatisticsContent();
      case 2:
        return _buildMessagesContent();
      case 3:
        return _buildProfileContent();
      default:
        return _buildDashboardGrid();
    }
  }
  
  // Grille du dashboard principal
  Widget _buildDashboardGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildDashboardItem(
          context,
          'Statistiques',
          Icons.bar_chart,
          Colors.blue.shade700,
          () {
            setState(() {
              _selectedIndex = 1;
            });
          },
        ),
        _buildDashboardItem(
          context,
          'Messages',
          Icons.message,
          Colors.green.shade700,
          () {
            setState(() {
              _selectedIndex = 2;
            });
          },
        ),
        _buildDashboardItem(
          context,
          'Paramètres',
          Icons.settings,
          Colors.orange.shade700,
          () {
            // Action pour les paramètres
          },
        ),
        _buildDashboardItem(
          context,
          'Profil',
          Icons.person,
          Colors.purple.shade700,
          () {
            setState(() {
              _selectedIndex = 3;
            });
          },
        ),
      ],
    );
  }
  
  // Contenu de l'onglet Statistiques
  Widget _buildStatisticsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Aperçu des statistiques',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView(
            children: [
              _buildStatCard('Utilisateurs actifs', '247', Colors.blue, Icons.people),
              _buildStatCard('Messages envoyés', '1,345', Colors.green, Icons.message),
              _buildStatCard('Taux de conversion', '5.2%', Colors.orange, Icons.trending_up),
              _buildStatCard('Revenus mensuels', '9,580€', Colors.purple, Icons.attach_money),
            ],
          ),
        ),
      ],
    );
  }
  
  // Widget pour une carte de statistique
  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Contenu de l'onglet Messages
  Widget _buildMessagesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Messages récents',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView(
            children: [
              _buildMessageItem('Sophie Martin', 'Bonjour, pouvez-vous m\'aider...', '09:45', true),
              _buildMessageItem('Thomas Dubois', 'Merci pour votre réponse rapide', '08:32', false),
              _buildMessageItem('Marion Petit', 'J\'ai une question concernant...', 'Hier', true),
              _buildMessageItem('Lucas Bernard', 'Le problème est résolu !', 'Hier', false),
              _buildMessageItem('Emma Rousseau', 'Quand pouvons-nous programmer...', '22/04', false),
            ],
          ),
        ),
      ],
    );
  }
  
  // Widget pour un élément de message
  Widget _buildMessageItem(String name, String message, String time, bool unread) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade100,
        child: Text(
          name[0],
          style: TextStyle(
            color: Colors.blue.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontWeight: unread ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: unread ? Colors.black87 : Colors.grey,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              color: unread ? Colors.blue : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          if (unread)
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
      onTap: () {
        // Action pour ouvrir un message
      },
    );
  }
  
  // Contenu de l'onglet Profil
  Widget _buildProfileContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.person,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Jean Dupont',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'jean.dupont@example.com',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          _buildProfileMenuItem('Informations personnelles', Icons.person_outline),
          _buildProfileMenuItem('Sécurité', Icons.security),
          _buildProfileMenuItem('Notifications', Icons.notifications_none),
          _buildProfileMenuItem('Préférences', Icons.settings),
          _buildProfileMenuItem('Aide & Support', Icons.help_outline),
          const SizedBox(height: 20),
          TextButton.icon(
            icon: const Icon(Icons.logout, color: Colors.red),
            label: const Text(
              'Déconnexion',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
  
  // Widget pour un élément du menu profil
  Widget _buildProfileMenuItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // Action pour l'option du profil
      },
    );
  }

  Widget _buildDashboardItem(
      BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [color, color.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}