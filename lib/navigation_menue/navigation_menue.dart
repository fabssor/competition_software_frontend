import 'package:competition_software_frontend/api/i_backend.dart';
import 'package:competition_software_frontend/common/disable.dart';
import 'package:flutter/material.dart';
import 'package:competition_software_frontend/navigation_menue/dropdown_menue.dart';

int _index = 0;
enum navigationEntries { competitors, agegroups, runs, times, evaluation }

// since we want to partly disable the navigation rail
// we need to spilt the navigation rail. The leadin part will have its own widget
// we then combine them again with stack. Then we can cleanly disable only one
// part of the UI
class LeadingButtons extends StatelessWidget {
  const LeadingButtons({
    Key? key,
    required this.backend,
    required this.onNewCompetition,
  }) : super(key: key);

  final IBackend backend;
  final Function onNewCompetition;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: 100,
        width: 250,
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: 20,
              child: Align(
                alignment: Alignment.center,
                child: FloatingActionButton.extended(
                  icon: const Icon(Icons.add),
                  label: const Text("Neuer Wettkampf"),
                  onPressed: () {
                    onNewCompetition();
                  },
                ),
              ),
            ),
            Positioned(
              child: PopupMenuButton<String>(
                icon: const Icon(Icons.more_horiz),
                onSelected: (String value) {
                  onDropDownSelected(value, context);
                },
                itemBuilder: (BuildContext context) {
                  return dropDownMenueChoices;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationMenue extends StatelessWidget {
  const NavigationMenue({
    Key? key,
    required this.backend,
    required this.onDestinationSelected,
    required this.disableNavigation,
    required this.onNewCompetition,
  }) : super(key: key);
  final IBackend backend;
  final Function onDestinationSelected;
  final Function onNewCompetition;
  final bool disableNavigation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Disable(
          disable: disableNavigation,
          child: NavigationRail(
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
            leading: const SizedBox(
              height: 90,
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
        ),
        LeadingButtons(
          backend: backend,
          onNewCompetition: onNewCompetition,
        ),
      ],
    );
  }
}
