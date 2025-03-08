import 'package:flutter/material.dart';
import 'dart:math';
import 'relations.dart'; // Importer la page RelationsPage
import 'calendar.dart'; // Importer la page CalendarPage
import 'meetings.dart'; // Importer la page MeetingsPage
import 'notification.dart'; // Importer la page NotificationsPage
import 'profil.dart'; // Importer la page ProfilePage
import 'activities.dart'; // Importer la page ActivitiesPage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<String> _selectedAdvice = [];

  @override
  void initState() {
    super.initState();
    _selectedAdvice = _getRandomAdvice();
  }

  // Fonction pour tirer au sort trois conseils parmi la liste
  static const List<String> conseils = [
    'Prenez le temps de vous détendre.',
    'Faites de l\'exercice régulièrement.',
    'Mangez sainement.',
    'Dormez suffisamment.',
    'Restez hydraté.',
    'Lisez un livre.',
    'Apprenez quelque chose de nouveau.',
    'Passez du temps avec vos proches.',
    'Pratiquez la méditation.',
    'Évitez le stress inutile.',
    'Fixez-vous des objectifs.',
    'Soyez reconnaissant.',
    'Aidez les autres.',
    'Prenez des pauses régulières.',
    'Écoutez de la musique apaisante.',
    'Passez du temps dans la nature.',
    'Gardez une attitude positive.',
    'Développez une routine quotidienne.',
    'Soyez organisé.',
    'Prenez soin de votre santé mentale.'
  ];

  List<String> _getRandomAdvice() {
    final random = Random();
    final adviceSet = <String>{};
    while (adviceSet.length < 3) {
      adviceSet.add(conseils[random.nextInt(conseils.length)]);
    }
    return adviceSet.toList();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RelationsPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ActivitiesPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MeetingsPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Modou',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            // Navigation vers la page NotificationsPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationPage()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigation vers la page ProfilePage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Prochain évènement',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigation vers la page CalendarPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarPage()),
                );
              },
              child: const Text('Voir le calendrier'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Suggestions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Conseils',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Affichage des conseils tirés au sort
            ..._selectedAdvice.map(_buildAdviceCard),
          ],
        ),
      ),
      // Footer avec le BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Proches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.extension),
            label: 'Activités',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Rencontre',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  // Fonction pour construire une carte de conseil
  Widget _buildAdviceCard(String text) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: double.infinity, // Largeur fixe pour les cartes
        padding: const EdgeInsets.all(10.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}