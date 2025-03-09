import 'dart:io';
import 'package:flutter/material.dart';
import 'home.dart';
import 'calendar.dart';
import 'meetings.dart';
import 'notification.dart';
import 'profil.dart';
import 'activities.dart';


class RelationsPage extends StatefulWidget {
  const RelationsPage({Key? key}) : super(key: key);

  @override
  _RelationsPageState createState() => _RelationsPageState();
}

class _RelationsPageState extends State<RelationsPage> {
  int _selectedIndex = 1;
  String _searchText = '';

  // Sample data for proches (replace with your actual data source)
  final List<Proche> _proches = [
    Proche(
        name: 'Papa',
        relationship: 'Père',
        distance: '10 km',
        favoriteActivities: ['Jardinage', 'Lecture'],
        interactionMode: 'Appels téléphoniques',
        imageName: 'Papa.png'),
    Proche(
        name: 'Tonton Fred',
        relationship: 'Oncle',
        distance: '50 km',
        favoriteActivities: ['Football', 'BBQ'],
        interactionMode: 'Visites',
        imageName: 'Tonton_Fred.png'),
    Proche(
        name: 'Sylvie',
        relationship: 'Amie',
        distance: '5 km',
        favoriteActivities: ['Cinéma', 'Shopping'],
        interactionMode: 'SMS',
        imageName: 'Sylvie.png'),
    Proche(
        name: 'Paul',
        relationship: 'Collègue',
        distance: '2 km',
        favoriteActivities: ['Café', 'Tennis'],
        interactionMode: 'Face à face',
        imageName: 'Paul.png'),
    Proche(
        name: 'Nana',
        relationship: 'Cousine',
        distance: '25 km',
        favoriteActivities: ['Voyage', 'Randonnée'],
        interactionMode: 'WhatsApp',
        imageName: 'Nana.png'),
    Proche(
        name: 'Patchie',
        relationship: 'Voisin',
        distance: '1 km',
        favoriteActivities: ['Jeux de société', 'Promenade'],
        interactionMode: 'Discussions',
        imageName: 'Patchie.png'),
    Proche(
        name: 'Mamie',
        relationship: 'Grand-mère',
        distance: '20 km',
        favoriteActivities: ['Tricot', 'Pâtisserie'],
        interactionMode: 'Appels téléphoniques',
        imageName: 'Mamie.png'),
    Proche(
        name: 'Pépoune',
        relationship: 'Ami d\'enfance',
        distance: '100 km',
        favoriteActivities: ['Jeux vidéo', 'Musique'],
        interactionMode: 'Messagerie en ligne',
        imageName: 'Pepoune.png'),
  ];

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
        backgroundColor: const Color(0xFFF6F2ED), // Beige app bar
      ),
      backgroundColor: const Color(0xFFF6F2ED), // Beige background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Proches',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFF6F2ED),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un proche',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (text) {
                setState(() {
                  _searchText = text;
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _proches.length,
                itemBuilder: (context, index) {
                  final proche = _proches[index];
                  if (_searchText.isNotEmpty &&
                      !proche.name.toLowerCase().contains(_searchText.toLowerCase())) {
                    return const SizedBox.shrink();
                  }

                  return Card(
                    color: const Color(0xFF70A193),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: _buildProcheAvatar(proche),
                      title: Text(proche.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.more_vert, color: Color(0xFFF6F2ED)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProcheDetailsPage(
                                index: index,
                                proche: proche,
                                onProcheUpdated: (updatedProche) {
                                  // Update the Proche when modified
                                  setState(() {
                                    _proches[index] = updatedProche;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action to add a new proche
          print("Add new proche");
        },
        child: const Icon(Icons.add),
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

 Widget _buildProcheAvatar(Proche proche) {

    final imagePath = 'images/${proche.imageName}'; // Use imageName

    return CircleAvatar(
      backgroundImage: AssetImage(imagePath),
      onBackgroundImageError: (exception, stackTrace) {
        print('Image not found: $imagePath');
      },
    );
  }
}

// Data model for a Proche
class Proche {
  String name;
  String relationship;
  String distance;
  List<String> favoriteActivities;
  String interactionMode;
  String imageName;


  Proche({
    required this.name,
    required this.relationship,
    required this.distance,
    required this.favoriteActivities,
    required this.interactionMode,
    required this.imageName,
  });
}

class ProcheDetailsPage extends StatefulWidget {
  final int index;
  final Proche proche;
  final Function(Proche) onProcheUpdated;

  const ProcheDetailsPage({
    Key? key,
    required this.index,
    required this.proche,
    required this.onProcheUpdated,
  }) : super(key: key);

  @override
  _ProcheDetailsPageState createState() => _ProcheDetailsPageState();
}

class _ProcheDetailsPageState extends State<ProcheDetailsPage> {
  late TextEditingController _nameController;
  late TextEditingController _relationshipController;
  late TextEditingController _distanceController;
  late TextEditingController _favoriteActivitiesController;
  late TextEditingController _interactionModeController;
   late TextEditingController _imageNameController;

  // final ImagePicker _picker = ImagePicker(); // Instance of ImagePicker

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.proche.name);
    _relationshipController = TextEditingController(text: widget.proche.relationship);
    _distanceController = TextEditingController(text: widget.proche.distance);
    _favoriteActivitiesController =
        TextEditingController(text: widget.proche.favoriteActivities.join(', '));
    _interactionModeController = TextEditingController(text: widget.proche.interactionMode);
     _imageNameController = TextEditingController(text: widget.proche.imageName);

  }

  @override
  void dispose() {
    _nameController.dispose();
    _relationshipController.dispose();
    _distanceController.dispose();
    _favoriteActivitiesController.dispose();
    _interactionModeController.dispose();
     _imageNameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2ED), // Beige background
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F2ED), // Beige background
        title: Text('Détails de ${widget.proche.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Save changes
              final updatedProche = Proche(
                name: _nameController.text,
                relationship: _relationshipController.text,
                distance: _distanceController.text,
                favoriteActivities:
                    _favoriteActivitiesController.text.split(',').map((e) => e.trim()).toList(),
                interactionMode: _interactionModeController.text,
                imageName:  _imageNameController.text

              );
              widget.onProcheUpdated(updatedProche);
              Navigator.pop(context); // Go back to the list
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
             _buildProcheAvatar(widget.proche),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nom'),
            ),
            TextFormField(
              controller: _relationshipController,
              decoration: const InputDecoration(labelText: 'Lien avec vous'),
            ),
            TextFormField(
              controller: _distanceController,
              decoration: const InputDecoration(labelText: 'Distance'),
            ),
            TextFormField(
              controller: _favoriteActivitiesController,
              decoration:
                  const InputDecoration(labelText: 'Activités préférées (séparées par des virgules)'),
            ),
            TextFormField(
              controller: _interactionModeController,
              decoration: const InputDecoration(labelText: 'Mode d\'interaction préféré'),
            ),
            TextFormField(
              controller: _imageNameController,
              decoration: const InputDecoration(labelText: 'Nom de fichier image'),
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildProcheAvatar(Proche proche) {

    final imagePath = 'images/${proche.imageName}'; // Use imageName

    return Center( // Center the whole thing
    child: ClipOval(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 4, // A quarter of the screen width
        height: MediaQuery.of(context).size.width / 4, // Maintain a circle
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const Icon(Icons.person, size: 50,);
          },
        ),
      ),
    ),
  );
  }
}