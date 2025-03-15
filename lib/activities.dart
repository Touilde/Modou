import 'package:flutter/material.dart';
import 'home.dart';
import 'relations.dart';
import 'calendar.dart';
import 'meetings.dart';
import 'notification.dart';
import 'profil.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  int _selectedIndex = 2;
  String? _selectedActivity;

  final List<String> _activities = [
    '🍕 Atelier pizza maison',
    '🖌️ Atelier peinture ou dessin',
    '🎲 Soirée jeux de société',
    '🧗 Escalade en salle',
    '🍃 Promenade dans un parc',
    '🎭 Spectacle ou théâtre local',
    '🏓 Ping-pong ou billard',
    '📚 Lecture à voix haute',
    '🎤 Karaoké',
    '🥾 Randonnée facile',
  ];

  final List<String> _jeux = [
    '🎲 Dice party',
    '🃏 Crapette',
    '♟️ Échecs',
    '🅰️ Scrabble',
    '♠️ Poker',
  ];

  final List<String> _loisirs = [
    '🖥️ Film synchronisée',
    '🎙️ Discussions thématiques',
    '🎭 Théâtre',
    '📚 Lecture',
    '🎵 Musique',
  ];

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Activités',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 160, // Ajustez la hauteur selon vos besoins pour le défilement vertical
                child: ListView.builder(
                  scrollDirection: Axis.vertical,  // Défilement vertical
                  itemCount: _activities.length,
                  itemBuilder: (context, index) {
                    final activity = _activities[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Text(
                        activity,
                        style: TextStyle(fontSize: 18), // Ajuste la taille ici
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Aide à choisir la logique ici
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF795548),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Aide à choisir'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PlanifierPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF795548),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Planifier un RDV'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'En ligne',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Clique sur l'activité pour copier un lien à partager à ton/tes proches.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 5),
              const Text(
                'Jeux',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 120, // Ajustez la hauteur
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _jeux.length,
                  itemBuilder: (context, index) {
                    final jeu = _jeux[index];
                    return _buildActivityItem(
                      jeu,
                      onTap: () {
                        //Logique pour copier le lien
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
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Loisirs',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 120, // Ajustez la hauteur
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _loisirs.length,
                  itemBuilder: (context, index) {
                    final loisir = _loisirs[index];
                    return _buildActivityItem(
                      loisir,
                      onTap: () {
                        //Logique pour copier le lien
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
                      },
                    );
                  },
                ),
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
        onTap: (index) {
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
                MaterialPageRoute(
                    builder: (context) => const RelationsPage()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ActivitiesPage()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MeetingsPage()),
              );
              break;
          }
        },
      ),
      backgroundColor: const Color(0xFFF6F2ED));
  }

  Widget _buildActivityItem(String activity, {VoidCallback? onTap}) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        title: Text(activity),
        onTap: onTap,
      ),
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
}
