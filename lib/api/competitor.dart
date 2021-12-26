import 'package:intl/intl.dart';

enum Gender { male, female }

extension ParseToString on Gender {
  String toString2() {
    return toString().split('.').last;
  }
}

class Competitor {
  int? id;
  final String _forename;
  final String _surename;
  final Gender _gender;
  final DateTime _birthday;

  String get forename => _forename;
  String get surename => _surename;
  Gender get gender => _gender;
  DateTime get birthday => _birthday;

  Competitor(
    String forename,
    String surename,
    Gender gender,
    DateTime birthday,
  )   : id = null,
        _forename = forename,
        _surename = surename,
        _gender = gender,
        _birthday = birthday;

  Competitor.withId(
    this.id,
    String forename,
    String surename,
    Gender gender,
    DateTime birthday,
  )   : _forename = forename,
        _surename = surename,
        _gender = gender,
        _birthday = birthday;

  @override
  String toString() {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return "ID: $id, Forename: $forename, Surename: $surename, Gender: ${gender.toString2()}, Birthday: ${formatter.format(birthday)}";
  }
}
