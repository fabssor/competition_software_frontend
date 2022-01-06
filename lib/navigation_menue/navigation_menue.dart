import 'package:competition_software_frontend/api/i_backend.dart';
import 'package:flutter/material.dart';
import 'package:competition_software_frontend/navigation_menue/dropdown_menue.dart';
import 'package:file_picker/file_picker.dart';

int _index = 0;
enum navigationEntries { competitors, agegroups, runs, times, evaluation }

class NavigationMenue extends StatelessWidget {
  const NavigationMenue({
    Key? key,
    required this.backend,
    required this.onDestinationSelected,
  }) : super(key: key);
  final IBackend backend;
  final Function onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: _index,
      onDestinationSelected: (int index) {
        navigationEntries entry = navigationEntries.competitors;
        _index = index;
        switch (index) {
          case 0:
            entry = navigationEntries.competitors;
            break;
          case 1:
            entry = navigationEntries.agegroups;
            break;
          case 2:
            entry = navigationEntries.runs;
            break;
          case 3:
            entry = navigationEntries.times;
            break;
          case 4:
            entry = navigationEntries.evaluation;
            break;
          default:
        }
        onDestinationSelected(entry);
        // convert the index to the enum
      },
      leading: SizedBox(
        height: 100,
        width: 200,
        child: Stack(
          children: [
            PopupMenuButton<String>(
              onSelected: (String value) {
                onDropDownSelected(value, context);
              },
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
                    backend.createNewCompetition();
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
    );
  }
}
