import 'package:competition_software_frontend/api/i_backend.dart';
import 'package:competition_software_frontend/navigation_menue/navigation_menue.dart';
import 'package:flutter/material.dart';
import 'package:competition_software_frontend/details/competitors/competitors.dart';
import 'package:competition_software_frontend/details/evaluation.dart';
import 'package:competition_software_frontend/details/runs.dart';
import 'package:competition_software_frontend/details/times.dart';
import 'package:competition_software_frontend/details/age_groups/age_groups.dart';

class Details extends StatelessWidget {
  final IBackend _backend;
  final navigationEntries _view;

  const Details(this._view, this._backend, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (_view) {
      case navigationEntries.competitors:
        return Competitors(_backend);
      case navigationEntries.agegroups:
        return AgeGroups(_backend);
      case navigationEntries.runs:
        return const Runs();
      case navigationEntries.times:
        return const Times();
      case navigationEntries.evaluation:
        return const Evaluation();
      default:
        return Competitors(_backend);
    }
  }
}
