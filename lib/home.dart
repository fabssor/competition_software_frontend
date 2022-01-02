import 'package:competition_software_frontend/api/i_backend.dart';
import 'package:competition_software_frontend/dropdown_menue.dart';
import 'package:flutter/material.dart';
import 'details/details.dart';
import 'package:file_picker/file_picker.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required IBackend backend})
      : _backend = backend,
        super(key: key);

  final IBackend _backend;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            leading: SizedBox(
              height: 100,
              width: 200,
              child: Stack(
                children: [
                  PopupMenuButton<String>(
                    onSelected: onDropDownSelected,
                    itemBuilder: (BuildContext context) {
                      return dropDownMenueChoices;
                    },
                  ),
                  Positioned.fill(
                    top: 50,
                    child: Align(
                      alignment: Alignment.center,
                      child: FloatingActionButton.extended(
                        icon: const Icon(Icons.add),
                        label: const Text("Neuer Wettkampf"),
                        onPressed: () async {
                          widget._backend.createNewCompetition();
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            extended: true,
            labelType: NavigationRailLabelType.none,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.people_outline),
                selectedIcon: Icon(Icons.people),
                label: Text('Teilnehmer'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.groups_outlined),
                selectedIcon: Icon(Icons.groups),
                label: Text('Altersklassen'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.flag_outlined),
                selectedIcon: Icon(Icons.flag),
                label: Text('Läufe'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.timer_outlined),
                selectedIcon: Icon(Icons.timer),
                label: Text('Zeiten'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bookmark_outline),
                selectedIcon: Icon(Icons.bookmark),
                label: Text('Auswertung'),
              ),
            ],
          ),
          const VerticalDivider(
            thickness: 1,
            width: 1,
          ),
          // This is the main content.
          Expanded(
            child: Details(_selectedIndex, widget._backend),
          ),
        ],
      ),
    );
  }
}
