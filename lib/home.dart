import 'package:competition_software_frontend/api/i_backend.dart';
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
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Widget>[
          NavigationMenue(
            backend: widget.backend,
            onDestinationSelected: (val) {
              setState(() {
                print("Rebuild");
                view = val;
              });
            },
          ),
          const VerticalDivider(
            thickness: 1,
            width: 1,
          ),
          // This is the main content.
          Expanded(
            child: Details(view, widget.backend),
          ),
        ],
      ),
    );
  }
}
