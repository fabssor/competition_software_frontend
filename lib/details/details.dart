import 'package:competition_software_frontend/api/i_backend.dart';
import 'package:flutter/material.dart';
import 'package:competition_software_frontend/details/competitors/competitors.dart';
import 'package:competition_software_frontend/details/evaluation.dart';
import 'package:competition_software_frontend/details/runs.dart';
import 'package:competition_software_frontend/details/times.dart';
import 'package:competition_software_frontend/details/age_groups/age_groups.dart';

class Details extends StatelessWidget {
  final int _index;
  final IBackend _backend;

  const Details(this._index, this._backend, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (_index) {
      case 0:
        return Competitors(_backend);
      case 1:
        return AgeGroups(_backend);
      case 2:
        return const Runs();
      case 3:
        return const Times();
      case 4:
        return const Evaluation();
      default:
        return Competitors(_backend);
    }
  }
}
