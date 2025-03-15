import 'package:flutter/material.dart';
import 'home.dart';
import 'relations.dart';
import 'calendar.dart';
import 'meetings.dart';
import 'notification.dart';
import 'activities.dart';
import 'parameters.dart'; // Import de la page paramètres

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  int _selectedIndex = 0;

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
      backgroundColor: Color(0xFFF6F2ED), 
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationPage()),
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/Avatar.png'), // Remplace par ton image
            ),
            const SizedBox(height: 10),

            // Nom et Bio
            const Text(
              'Modou', // Nom du profil
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Passionné de technologie et de rencontres',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Bouton Paramètres
            ElevatedButton.icon(
              icon: const Icon(Icons.settings, color: Colors.white,),
              label: const Text("Paramètres"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown, // Couleur du bouton
                foregroundColor: Colors.white, // Couleur du texte
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ParametersPage()),
                );
              },
            ),
          ],
        ),
      ),
    ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Proches',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.extension),
              label: 'Activités',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.groups),
              label: 'Rencontre',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF795548),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
