import 'package:flutter/material.dart';
import 'package:competition_software_frontend/details/competitors/competitors.dart';
import 'package:competition_software_frontend/details/evaluation.dart';
import 'package:competition_software_frontend/details/runs.dart';
import 'package:competition_software_frontend/details/times.dart';
import 'package:competition_software_frontend/details/age_groups/age_groups.dart';
import 'package:competition_software_frontend/api/mock_backend.dart';

class Details extends StatelessWidget {
  final int _index;

  const Details(this._index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MockBackend m = MockBackend();
    switch (_index) {
      case 0:
        return Competitors(m);
      case 1:
        return AgeGroups(m);
      case 2:
        return const Runs();
      case 3:
        return const Times();
      case 4:
        return const Evaluation();
      default:
        return Competitors(m);
    }
  }
}
