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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                ),
                onPressed: () {},
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
            },
          );
        }).toList(),
      ],
    );
  }
}