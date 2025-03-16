import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:modou/home.dart'; // Vérifie si AboutMePage est bien dans ce fichier

class ParametersPage extends StatefulWidget {
  const ParametersPage({super.key});

  @override
  State<ParametersPage> createState() => _ParametersPageState();
}

class _ParametersPageState extends State<ParametersPage> {
  String? _selectedLanguage;
  bool _isLightTheme = false;
  bool _notificationsEnabled = false;
  bool _shareLocation = false;
  String? _selectedReminderFrequency;
  String? _selectedNotificationTone;
  List<String> _preferredNotificationTimes = [];
  List<String> _preferredCommunicationMethods = [];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language') ?? 'Français';
      _isLightTheme = prefs.getBool('theme') ?? false;
      _notificationsEnabled = prefs.getBool('notifications') ?? true;
      _shareLocation = prefs.getBool('shareLocation') ?? true;
      _selectedReminderFrequency = prefs.getString('frequency') ?? 'Tous les jours';
      _selectedNotificationTone = prefs.getString('notificationTone') ?? 'Ding';
      _preferredNotificationTimes = prefs.getStringList('notificationTimes') ?? [];
      _preferredCommunicationMethods = prefs.getStringList('communicationMethods') ?? [];
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs
      ..setString('language', _selectedLanguage ?? 'Français')
      ..setBool('theme', _isLightTheme)
      ..setBool('notifications', _notificationsEnabled)
      ..setBool('shareLocation', _shareLocation)
      ..setString('frequency', _selectedReminderFrequency ?? 'Tous les jours')
      ..setString('notificationTone', _selectedNotificationTone ?? 'Ding')
      ..setStringList('notificationTimes', _preferredNotificationTimes)
      ..setStringList('communicationMethods', _preferredCommunicationMethods);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2ED),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Modou',
              style: TextStyle(fontFamily: 'Pacifico', fontSize: 38),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutMePage()));
              },
              child: const Text(
                'Passer',
                style: TextStyle(fontSize: 16, decoration: TextDecoration.underline, color: Colors.brown),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Paramètres',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildDropdown('Langue', _selectedLanguage, ['Français', 'English', 'Español'], (newValue) {
            setState(() {
              _selectedLanguage = newValue;
              _savePreferences();
            });
          }),
          _buildSwitch('Thème clair', _isLightTheme, (value) {
            setState(() {
              _isLightTheme = value;
              _savePreferences();
            });
          }),
          _buildSwitch('Notifications', _notificationsEnabled, (value) {
            setState(() {
              _notificationsEnabled = value;
              _savePreferences();
            });
          }),
          _buildSwitch('Partager ma localisation', _shareLocation, (value) {
            setState(() {
              _shareLocation = value;
              _savePreferences();
            });
          }),
          _buildDropdown('Fréquence des rappels', _selectedReminderFrequency, [
            'Tous les jours',
            '2-3 fois par semaine',
            'Une fois par semaine'
          ], (newValue) {
            setState(() {
              _selectedReminderFrequency = newValue;
              _savePreferences();
            });
          }),
          _buildDropdown('Ton des notifications', _selectedNotificationTone, [
            'Humoristique',
            'Familier',
            'Neutre'
          ], (newValue) {
            setState(() {
              _selectedNotificationTone = newValue;
              _savePreferences();
            });
          }),
          _buildCheckboxGroup('Horaires préférés pour les notifications', ['Matin', 'Après-midi', 'Soir'],
              _preferredNotificationTimes, (updatedList) {
            setState(() {
              _preferredNotificationTimes = updatedList;
              _savePreferences();
            });
          }),
          _buildCheckboxGroup('Mode de communication préféré', ['Messages', 'Appels', 'En personne'],
              _preferredCommunicationMethods, (updatedList) {
            setState(() {
              _preferredCommunicationMethods = updatedList;
              _savePreferences();
            });
          }),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutMePage()));
              },
              child: const Text(
                'Enregistrer',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String title, String? value, List<String> items, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: items.contains(value) ? value : items.first,
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
      activeColor: Colors.brown,
      onChanged: onChanged,
    );
  }

  Widget _buildCheckboxGroup(String title, List<String> options, List<String> selectedOptions,
      ValueChanged<List<String>> onCheckboxChanged) {
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
                _savePreferences();
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
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  String? _selectedValue1;
  String? _selectedValue2;
  String? _selectedValue3;
  String? _selectedValue4;
  String? _selectedValue5;

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
    _filteredInterests = List.from(_allInterests);
    _searchController.addListener(_filterInterests);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _searchController.dispose();
    super.dispose();
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
      backgroundColor: const Color(0xFFF6F2ED),
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
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pushNamed(context, '/home'),
                child: const Text(
                  'Passer',
                  style: TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    color: Colors.brown,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildDropdown('Mes valeurs principales', _selectedValue1, ['Empathie', 'Authenticité', 'Fidélité', 'Partage', 'Bienveillance'], (newValue) => setState(() => _selectedValue1 = newValue)),
            _buildDropdown('Mon super pouvoir social', _selectedValue2, ['Toujours prendre des nouvelles', 'Créer des discussions animées', 'Apaiser les conflits', 'Faire rire tout le monde', 'Rassembler mes proches'], (newValue) => setState(() => _selectedValue2 = newValue)),
            _buildDropdown('Mon idée de journée parfaite', _selectedValue3, ['Un après-midi avec mes amis', 'Un appel profond avec un proche', 'Un dîner convivial', 'Une balade et des échanges sincères', 'Une journée à aider quelqu’un'], (newValue) => setState(() => _selectedValue3 = newValue)),
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
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: _filteredInterests.map((interest) {
                return FilterChip(
                  label: Text('${interest['emoji']} ${interest['name']}'),
                  selected: _selectedInterests.contains(interest['name']),
                  onSelected: (bool selected) {
                    setState(() {
                      selected ? _selectedInterests.add(interest['name']!) : _selectedInterests.remove(interest['name']!);
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                ),
                onPressed: () => Navigator.pushNamed(context, '/home'),
                child: const Text(
                  'Enregistrer',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
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
        items: items.map((String item) => DropdownMenuItem<String>(value: item, child: Text(item))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
