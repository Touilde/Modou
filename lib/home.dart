import 'package:flutter/material.dart';
import 'dart:math';
import 'relations.dart';
import 'calendar.dart';
import 'meetings.dart';
import 'notification.dart';
import 'profil.dart';
import 'activities.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          MaterialPageRoute(builder: (context) => const ActivitiesPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MeetingsPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double margin = 16.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.notifications, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationPage()),
            );
          },
        ),
        title: const Text(
          'Modou',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 28,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilPage()),
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF6F2ED),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Prochain évènement',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF90afa6),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.calendar_today, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          '14 mars 2025 à 16h',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Café avec Mathilde ☕',
                          style: TextStyle(color: Colors.white),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF795548),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text('Modifier'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Suggestions',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Card with dynamic width based on screen size
            SuggestionCard(
              text:
                  "Ça fait longtemps que vous n'avez pas parlé à Paul. Pourquoi ne pas lui proposer un verre 🍹 ?",
              screenWidth: screenWidth,
              margin: margin,
            ),
            SuggestionCard(
              text:
                  "C'est le demi-anniversaire de Laëtitia, envoye lui un message pour lui souhaiter ! 🎉",
              screenWidth: screenWidth,
              margin: margin,
            ),
            SuggestionCard(
              text:
                  "C'est dimanche, pourquoi pas une balade? Pauline aime les escapades nature. 🌳",
              screenWidth: screenWidth,
              margin: margin,
            ),
            const SizedBox(height: 20),
            const Text(
              'Conseils',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Card with dynamic width based on screen size
            AdviceCard(
              text:
                  "Les messages vocaux sont souvent perçus comme plus chaleureux que les SMS. 🔔",
              screenWidth: screenWidth,
              margin: margin,
            ),
            AdviceCard(
              text:
                  "Réservez un moment chaque semaine pour passer un appel à un proche. 📞",
              screenWidth: screenWidth,
              margin: margin,
            ),
            AdviceCard(
              text:
                  "N'hésitez pas à poser une question simple, ça brise la glace (sans trop de pression). 🧊",
              screenWidth: screenWidth,
              margin: margin,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white, // Fond du footer en blanc
        ),
        child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
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

class SuggestionCard extends StatelessWidget {
  const SuggestionCard({super.key, required this.text, required this.screenWidth, required this.margin});

  final String text;
  final double screenWidth;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth - 2 * margin, // Largeur = largeur de l'écran - deux marges
      margin: EdgeInsets.symmetric(vertical: 5), // Marge verticale entre les cartes
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(text),
        ),
      ),
    );
  }
}

class AdviceCard extends StatelessWidget {
  const AdviceCard({super.key, required this.text, required this.screenWidth, required this.margin});

  final String text;
  final double screenWidth;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth - 2 * margin, // Largeur = largeur de l'écran - deux marges
      margin: EdgeInsets.symmetric(vertical: 5), // Marge verticale entre les cartes
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(text),
        ),
      ),
    );
  }
}
