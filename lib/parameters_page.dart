import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
  String? _username;
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadUserSettings();
  }

  Future<void> _loadUserData() async {
    final userData = await readUserData();
    if (userData != null) {
      setState(() {
        _username = userData['username'];
        _email = userData['email'];
      });
    }
  }

  Future<void> _loadUserSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('selectedLanguage');
      _isLightTheme = prefs.getBool('isLightTheme') ?? false;
      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? false;
      _shareLocation = prefs.getBool('shareLocation') ?? false;
      _selectedReminderFrequency = prefs.getString('selectedReminderFrequency');
      _selectedNotificationTone = prefs.getString('selectedNotificationTone');
      _preferredNotificationTimes.addAll(prefs.getStringList('preferredNotificationTimes') ?? []);
      _preferredCommunicationMethods.addAll(prefs.getStringList('preferredCommunicationMethods') ?? []);
    });
  }

  Future<void> _saveUserSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', _selectedLanguage ?? '');
    await prefs.setBool('isLightTheme', _isLightTheme);
    await prefs.setBool('notificationsEnabled', _notificationsEnabled);
    await prefs.setBool('shareLocation', _shareLocation);
    await prefs.setString('selectedReminderFrequency', _selectedReminderFrequency ?? '');
    await prefs.setString('selectedNotificationTone', _selectedNotificationTone ?? '');
    await prefs.setStringList('preferredNotificationTimes', _preferredNotificationTimes);
    await prefs.setStringList('preferredCommunicationMethods', _preferredCommunicationMethods);
  }

  Future<Map<String, dynamic>?> readUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString('user_data');
    if (userDataString != null) {
      final userData = jsonDecode(userDataString);
      return userData;
    }
    return null;
  }

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
            if (_username != null && _email != null) ...[
              Text('Nom d\'utilisateur : $_username', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('E-mail : $_email', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
            ],
            _buildDropdown('Langue', _selectedLanguage, ['Français', 'English', 'Español'], (newValue) {
              setState(() {
                _selectedLanguage = newValue;
              });
              _saveUserSettings();
            }),
            _buildSwitch('Thème clair', _isLightTheme, (value) {
              setState(() {
                _isLightTheme = value;
              });
              _saveUserSettings();
            }),
            _buildSwitch('Notifications', _notificationsEnabled, (value) {
              setState(() {
                _notificationsEnabled = value;
              });
              _saveUserSettings();
            }),
            _buildSwitch('Partager ma localisation', _shareLocation, (value) {
              setState(() {
                _shareLocation = value;
              });
              _saveUserSettings();
            }),
            _buildDropdown('Fréquence des rappels', _selectedReminderFrequency, ['Tous les jours', '2-3 fois par semaine', 'Une fois par semaine'], (newValue) {
              setState(() {
                _selectedReminderFrequency = newValue;
              });
              _saveUserSettings();
            }),
            _buildDropdown('Ton des notifications', _selectedNotificationTone, ['Ding', 'Beep', 'Sonnerie'], (newValue) {
              setState(() {
                _selectedNotificationTone = newValue;
              });
              _saveUserSettings();
            }),
            _buildCheckboxGroup('Horaires préférés pour les notifications', ['Matin', 'Après-midi', 'Soir'], _preferredNotificationTimes),
            _buildCheckboxGroup('Mode de communication préféré', ['Messages', 'Appels', 'En personne'], _preferredCommunicationMethods),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                ),
                onPressed: () {
                  _saveUserSettings();
                },
                child: const Text(
                  'Valider',
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
        value: items.contains(value) ? value : null,  // Vérifie que value est bien dans items
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
              _saveUserSettings();
            },
          );
        }).toList(),
      ],
    );
  }
}
