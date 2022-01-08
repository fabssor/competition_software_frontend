import 'package:competition_software_frontend/api/i_backend.dart';
import 'package:competition_software_frontend/common/disable.dart';
import 'package:competition_software_frontend/navigation_menue/navigation_menue.dart';
import 'package:flutter/material.dart';
import 'details/details.dart';

navigationEntries view = navigationEntries.competitors;

class Home extends StatefulWidget {
  const Home({Key? key, required this.backend}) : super(key: key);

  final IBackend backend;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Widget>[
          NavigationMenue(
            backend: widget.backend,
            disableNavigation: !_isOpen,
            onDestinationSelected: (val) {
              setState(() {
                view = val;
              });
            },
            onNewCompetition: () async {
              await widget.backend.createNewCompetition();
              setState(() {
                _isOpen = widget.backend.isOpen();
              });
            },
            onOpenCompetition: () async {
              await widget.backend.openCompetition();
              setState(() {
                _isOpen = widget.backend.isOpen();
              });
            },
            onSaveCompetition: () async {
              await widget.backend.saveCompetition();
            },
            onCloseCompetition: () {
              widget.backend.closeCompetition();
              setState(() {
                _isOpen = widget.backend.isOpen();
              });
            },
            onSaveCompetitionAs: () async {
              await widget.backend.saveCompetition(createNew: true);
            },
            onSettings: () {},
          ),
          const VerticalDivider(
            thickness: 1,
            width: 1,
          ),
          // This is the main content.
          Expanded(
            child: Disable(
              disable: !_isOpen,
              child: Details(view, widget.backend),
            ),
          ),
        ],
      ),
    );
  }
}
