import 'package:flutter/material.dart';
import 'dart:math';
import 'home.dart'; // Importer la page HomePage
import 'relations.dart'; // Importer la page RelationsPage
import 'calendar.dart'; // Importer la page CalendarPage
import 'meetings.dart'; // Importer la page MeetingsPage
import 'notification.dart'; // Importer la page NotificationsPage
import 'profil.dart'; // Importer la page ProfilePage

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  int _selectedIndex = 2;
  List<String> _selectedActivities = [];

  @override
  void initState() {
    super.initState();
    _selectedActivities = _getRandomActivities();
  }

  // Fonction pour tirer au sort cinq activités parmi la liste
  List<String> _getRandomActivities() {
    final random = Random();
    final activitySet = <String>{};
    while (activitySet.length < 5) {
      final activities = [
        '🍕 Atelier pizza maison',
        '🖌️ Atelier peinture',
        '🎬 Cinéma',
        '🎭 Théâtre',
        '📚 Lecture',
        '🥾 Randonnée',
        '🍳 Cuisine',
        '🎨 Peinture',
        '🎵 Musique',
        '💃 Danse',
        '📸 Photographie',
        '🌱 Jardinage',
        '🔨 Bricolage',
        '🎮 Jeux vidéo',
        '🎤 Karaoké',
        '🧘‍♀️ Méditation'
      ];

      activitySet.add(activities[random.nextInt(activities.length)]);
    }
    return activitySet.toList();
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

  void _showCopyPopup() {
    final snackBar = SnackBar(
      content: Row(
        children: const [
          Icon(Icons.copy, color: Colors.white),
          SizedBox(width: 10),
          Text('Lien copié'),
        ],
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black.withOpacity(0.7),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _navigateToPlanifierPage(String activity) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlanifierPage(
          initialActivity: activity,
        ),
      ),
    );
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
              MaterialPageRoute(builder: (context) => const NotificationPage()),
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
                MaterialPageRoute(builder: (context) => const ProfilPage()),
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
              'Activités',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Voici quelques activités tirées au hasard :',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            ..._selectedActivities.map((activity) => GestureDetector(
              onTap: () => _navigateToPlanifierPage(activity.replaceAll(RegExp(r'^[^\w\s]+'), '')),
              child: Text('$activity', style: const TextStyle(fontSize: 16)),
            )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logique pour "Aide à choisir"
              },
              child: const Text('Aide à choisir'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigation vers la page PlanifierPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PlanifierPage()),
                );
              },
              child: const Text('Planifier une activité'),
            ),
            const SizedBox(height: 20),
            const Text(
              'En ligne',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Clique sur l\'activité pour copier un lien à partager à ton/tes proches',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Jeux',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildActivityItem('♟️ Échecs'),
            _buildActivityItem('🎲 Dice Party'),
            _buildActivityItem('🅰️ Scrabble'),
            _buildActivityItem('🖌️ Pictionary'),
            _buildActivityItem('♠️ Poker'),
            const SizedBox(height: 20),
            const Text(
              'Loisirs',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildActivityItem('🎬 Cinéma'),
            _buildActivityItem('💬 Discussions thématiques'),
            _buildActivityItem('🎭 Théâtre'),
            _buildActivityItem('📚 Lecture'),
          ],
        ),
      ),
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

  Widget _buildActivityItem(String title) {
    return ListTile(
      leading: const Icon(Icons.link),
      title: Text(title),
      onTap: () {
        // Logique pour copier le lien de l'activité
        _showCopyPopup();
      },
    );
  }
}

class PlanifierPage extends StatefulWidget {
  final String? initialActivity;

  const PlanifierPage({super.key, this.initialActivity});

  @override
  _PlanifierPageState createState() => _PlanifierPageState();
}

class _PlanifierPageState extends State<PlanifierPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  List<DateTime> _selectedDates = [];
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    if (widget.initialActivity != null) {
      _activityController.text = widget.initialActivity!;
    }
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

  void _addAvailability() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    ).then((selectedDate) {
      if (selectedDate != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((selectedTime) {
          if (selectedTime != null) {
            setState(() {
              _selectedDates.add(DateTime(
                selectedDate.year,
                selectedDate.month,
                selectedDate.day,
                selectedTime.hour,
                selectedTime.minute,
              ));
            });
          }
        });
      }
    });
  }

  void _proposeActivity() {
    // Logique pour proposer l'activité à un proche
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ActivitiesPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Planifier',
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
              MaterialPageRoute(builder: (context) => const NotificationPage()),
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
                MaterialPageRoute(builder: (context) => const ProfilPage()),
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
              'Planifier',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nom du/des proche(s)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _activityController,
              decoration: InputDecoration(
                labelText: 'Nom de l\'activité',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Lieu de l\'activité',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _durationController,
              decoration: InputDecoration(
                labelText: 'Durée de l\'activité',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Disponibilités',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addAvailability,
              child: const Text('Ajouter une disponibilité'),
            ),
            const SizedBox(height: 10),
            ..._selectedDates.map((date) => Text(
              '${date.day}/${date.month}/${date.year} à ${date.hour}:${date.minute}',
              style: const TextStyle(fontSize: 16),
            )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _proposeActivity,
              child: const Text('Proposer l\'activité à un proche'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}