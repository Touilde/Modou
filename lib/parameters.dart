import 'package:flutter/material.dart';

class ParametersPage extends StatefulWidget {
  const ParametersPage({super.key});

  @override
  _ParametersPageState createState() => _ParametersPageState();
}

class _ParametersPageState extends State<ParametersPage> {
  String? _selectedLanguage;
  bool _isLightTheme = false;
  bool _notificationsEnabled = false;
  bool _shareLocation = false;
  String? _selectedReminderFrequency;
  String? _selectedNotificationTone;
  final List<String> _preferredNotificationTimes = [];
  final List<String> _preferredCommunicationMethods = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5ECE2),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Modou',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Paramètres',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildDropdown('Langue', _selectedLanguage, ['Français', 'English', 'Español'], (newValue) {
              setState(() {
                _selectedLanguage = newValue;
              });
            }),
            _buildSwitch('Thème clair', _isLightTheme, (value) {
              setState(() {
                _isLightTheme = value;
              });
            }),
            _buildSwitch('Notifications', _notificationsEnabled, (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            }),
            _buildSwitch('Partager ma localisation', _shareLocation, (value) {
              setState(() {
                _shareLocation = value;
              });
            }),
            _buildDropdown('Fréquence des rappels', _selectedReminderFrequency, ['Tous les jours', '2-3 fois par semaine', 'Une fois par semaine'], (newValue) {
              setState(() {
                _selectedReminderFrequency = newValue;
              });
            }),
            _buildDropdown('Ton des notifications', _selectedNotificationTone, ['Ding', 'Beep', 'Sonnerie'], (newValue) {
              setState(() {
                _selectedNotificationTone = newValue;
              });
            }),
            _buildCheckboxGroup('Horaires préférés pour les notifications', ['Matin', 'Après-midi', 'Soir'], _preferredNotificationTimes),
            _buildCheckboxGroup('Mode de communication préféré', ['Messages', 'Appels', 'En personne'], _preferredCommunicationMethods),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutMePage()),
                      );
                    },
                    child: const Text(
                      'Valider',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutMePage()),
                      );
                    },
                    child: const Text(
                      'Passer',
                      style: TextStyle(fontSize: 16, decoration: TextDecoration.underline),
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

  Widget _buildDropdown(String title, String? value, List<String> items, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: title,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSwitch(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      value: value,
      activeColor: const Color.fromARGB(255, 59, 177, 0),
      onChanged: onChanged,
    );
  }

  Widget _buildCheckboxGroup(String title, List<String> options, List<String> selectedOptions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...options.map((option) {
          return CheckboxListTile(
            title: Text(option),
            value: selectedOptions.contains(option),
            activeColor: Colors.brown,
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  selectedOptions.add(option);
                } else {
                  selectedOptions.remove(option);
                }
              });
            },
          );
        }).toList(),
      ],
    );
  }
}

class AboutMePage extends StatefulWidget {
  const AboutMePage({super.key});

  @override
  _AboutMePageState createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  String? _selectedValue1, _selectedValue2, _selectedValue3, _selectedValue4, _selectedValue5;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final List<String> _selectedInterests = [];
  final List<Map<String, String>> _allInterests = [
    {'name': 'Voyages', 'emoji': '✈️'},
    {'name': 'Musique', 'emoji': '🎵'},
    {'name': 'Cuisine', 'emoji': '🍳'},
    {'name': 'Lecture', 'emoji': '📚'},
    {'name': 'Jeux vidéos', 'emoji': '🎮'},
    {'name': 'Course à pied', 'emoji': '🏃'},
    {'name': 'Photographie', 'emoji': '📸'},
    {'name': 'Peinture', 'emoji': '🎨'},
    {'name': 'Randonnée', 'emoji': '🥾'},
    {'name': 'F1', 'emoji': '🏎️'},
    {'name': 'Astronomie', 'emoji': '🌌'},
    {'name': 'Théâtre', 'emoji': '🎭'},
    {'name': 'Bricolage', 'emoji': '🛠️'},
    {'name': 'Plongée', 'emoji': '🤿'},
    {'name': 'Échecs', 'emoji': '♟️'},
    {'name': 'Drones', 'emoji': '🚁'},
    {'name': 'Crypto', 'emoji': '💎'},
    {'name': 'Anime', 'emoji': '🦸'},
    {'name': 'Puzzles', 'emoji': '🧩'},
    {'name': 'Surf', 'emoji': '🏄'},
    {'name': 'Gymnastique', 'emoji': '🤸'},
    {'name': 'Tatouage', 'emoji': '💉'},
    {'name': 'Méditation', 'emoji': '🧘'},
    {'name': 'Podcasts', 'emoji': '🎧'},
    {'name': 'Origami', 'emoji': '🦢'},
    {'name': 'Mycologie', 'emoji': '🍄'},
    {'name': 'Jardinage', 'emoji': '🌿'},
    {'name': 'Programmation', 'emoji': '💻'},
    {'name': 'Spéléologie', 'emoji': '🪨'},
    {'name': 'Roller', 'emoji': '🛼'},
    {'name': 'Astronautique', 'emoji': '🚀'},
    {'name': 'Cerf-volant', 'emoji': '🪁'},
    {'name': 'Cosplay', 'emoji': '👘'},
    {'name': 'Couture', 'emoji': '🧵'},
    {'name': 'Parapente', 'emoji': '🪂'},
    {'name': 'Paintball', 'emoji': '🔫'},
    {'name': 'Paléontologie', 'emoji': '🦖'},
    {'name': 'Arts martiaux', 'emoji': '🥋'},
    {'name': 'Bowling', 'emoji': '🎳'},
    {'name': 'Airsoft', 'emoji': '💥'},
    {'name': 'Natation', 'emoji': '🏊'},
    {'name': 'Slackline', 'emoji': '🪢'},
    {'name': 'Aquascaping', 'emoji': '🐠'},
    {'name': 'Blockchain', 'emoji': '🪙'},
    {'name': 'Volcanologie', 'emoji': '🌋'},
    {'name': 'Canoë-kayak', 'emoji': '🚣'},
    {'name': 'Danse', 'emoji': '💃'},
    {'name': 'Rétrogaming', 'emoji': '🕹️'},
    {'name': 'Mini-golf', 'emoji': '🏌️'},
    {'name': 'Numismatique', 'emoji': '🪙'},
    {'name': 'Arcade', 'emoji': '🎰'},
    {'name': 'Polaroid', 'emoji': '📷'},
    {'name': 'Roller derby', 'emoji': '🛼'},
    {'name': 'Lego', 'emoji': '🧱'},
  ];
  List<Map<String, String>> _filteredInterests = [];

  @override
  void initState() {
    super.initState();
    _filteredInterests = _allInterests;
    _searchController.addListener(_filterInterests);
  }

  void _filterInterests() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredInterests = _allInterests.where((interest) {
        return interest['name']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5ECE2),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Modou',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'À propos de moi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildDropdown('Mes valeurs principales', _selectedValue1, ['Item 1', 'Item 2', 'Item 3'], (newValue) {
              setState(() {
                _selectedValue1 = newValue;
              });
            }),
            _buildDropdown('Mon super pouvoir social', _selectedValue2, ['Item 1', 'Item 2', 'Item 3'], (newValue) {
              setState(() {
                _selectedValue2 = newValue;
              });
            }),
            _buildDropdown('Mon idée de journée parfaite', _selectedValue3, ['Item 1', 'Item 2', 'Item 3'], (newValue) {
              setState(() {
                _selectedValue3 = newValue;
              });
            }),
            _buildDropdown('Ce que je recherche chez les autres', _selectedValue4, ['Item 1', 'Item 2', 'Item 3'], (newValue) {
              setState(() {
                _selectedValue4 = newValue;
              });
            }),
            _buildDropdown('Mon humeur sociale', _selectedValue5, ['Item 1', 'Item 2', 'Item 3'], (newValue) {
              setState(() {
                _selectedValue5 = newValue;
              });
            }),
            const SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Décris toi en quelques mots',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Centres d\'intérêts',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Rechercher',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 100, // Hauteur fixe pour le conteneur défilable
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: _filteredInterests.map((interest) {
                    return FilterChip(
                      label: Text('${interest['emoji']} ${interest['name']}'),
                      selected: _selectedInterests.contains(interest['name']),
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            _selectedInterests.add(interest['name']!);
                          } else {
                            _selectedInterests.remove(interest['name']!);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                    ),
                    onPressed: () {
                      // Logique pour valider et enregistrer les informations
                    },
                    child: const Text(
                      'Valider',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // Logique pour passer cette étape
                    },
                    child: const Text(
                      'Passer',
                      style: TextStyle(fontSize: 16, decoration: TextDecoration.underline),
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

  Widget _buildDropdown(String title, String? value, List<String> items, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: title,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}