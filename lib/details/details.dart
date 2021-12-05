import 'package:flutter/material.dart';
import 'competitors.dart';
import 'evaluation.dart';
import 'runs.dart';
import 'times.dart';

class Details extends StatelessWidget {
  final int _index;

  const Details(this._index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (_index) {
      case 0:
        return Competitors();
      case 1:
        return Runs();
      case 2:
        return Times();
      case 3:
        return Evaluation();
      default:
        return Competitors();
    }
  }
}
