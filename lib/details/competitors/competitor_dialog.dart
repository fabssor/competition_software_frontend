import 'package:competition_software_frontend/api/mock_backend.dart';
import 'package:flutter/material.dart';
import 'package:competition_software_frontend/api/competitor.dart';
import 'package:competition_software_frontend/api/i_backend.dart';

const _spaceBetweenColumnItems = 10.0;
Gender _gender = Gender.female;
DateTime _birthday = DateTime.now();
final _formKey = GlobalKey<FormState>();

Widget _buildTextFormField(
    {required String labelText,
    TextEditingController? controller,
    bool readOnly = false,
    Icon? suffixIcon,
    Future<void> Function()? onTap}) {
  return TextFormField(
    controller: controller,
    readOnly: readOnly,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      labelText: labelText,
      suffixIcon: suffixIcon,
      counterText: ' ',
    ),
    onTap: onTap,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Bitte geben Sie einen Text ein!";
      }
      return null;
    },
  );
}

Widget _buildGenderRadioButton(
  String labelText,
  Gender value,
  StateSetter setState,
) {
  return Expanded(
    child: RadioListTile<Gender>(
      title: Text(labelText),
      value: value,
      groupValue: _gender,
      onChanged: (Gender? v) {
        setState(() => _gender = v!);
      },
    ),
  );
}

Future<DateTime?> getDate(BuildContext context) async {
  var now = DateTime.now();
  var date = await showDatePicker(
    context: context,
    initialDate: DateTime(
      now.year - 10,
      now.month,
      now.day,
    ),
    firstDate: DateTime(
      now.year - 100,
      now.month,
      now.day,
    ),
    lastDate: DateTime(
      now.year,
      now.month,
      now.day,
    ),
  );
  return date;
}

Future<List<Competitor>?> competitorDialog(
  BuildContext context,
  String dialogTitle, [
  int? id,
  String? surename,
  String? forename,
  Gender? gender,
  DateTime? birthday,
]) async {
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController forenameController = TextEditingController();
  final TextEditingController surenameController = TextEditingController();
  surename == null
      ? surenameController.text = ""
      : surenameController.text = surename;
  forename == null
      ? forenameController.text = ""
      : forenameController.text = forename;
  if (birthday != null) {
    birthdayController.text = birthday.toString2();
    _birthday = birthday;
  }
  if (gender != null) {
    _gender = gender;
  }
  bool isEdit = ((surename != null) ||
      (forename != null) ||
      (birthday != null) ||
      (gender != null) ||
      (id != null));

  List<Competitor> competitors = <Competitor>[];

  await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(dialogTitle),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildTextFormField(
                    controller: surenameController,
                    labelText: "Nachname",
                  ),
                  const SizedBox(height: _spaceBetweenColumnItems),
                  _buildTextFormField(
                    controller: forenameController,
                    labelText: "Vorname",
                  ),
                  const SizedBox(height: _spaceBetweenColumnItems),
                  _buildTextFormField(
                    controller: birthdayController,
                    readOnly: true,
                    labelText: "Geburtsdatum",
                    suffixIcon: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final DateTime? dateTime = await getDate(context);
                      if (dateTime == null) {
                        return;
                      } else {
                        _birthday = dateTime;
                        birthdayController.text =
                            "${dateTime.day}.${dateTime.month}.${dateTime.year}";
                      }
                    },
                  ),
                  const SizedBox(height: _spaceBetweenColumnItems),
                  Row(
                    children: [
                      _buildGenderRadioButton(
                        "männlich",
                        Gender.male,
                        setState,
                      ),
                      _buildGenderRadioButton(
                        "weiblich",
                        Gender.female,
                        setState,
                      )
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  if (competitors.isEmpty) {
                    Navigator.of(context).pop(null);
                  } else {
                    // If there where some competitors already created do not
                    // dismiss them...
                    Navigator.of(context).pop(competitors);
                  }
                },
                child: const Text("Abbrechen"),
              ),
              if (isEdit)
                TextButton(
                  onPressed: () {
                    competitors.add(Competitor.withId(
                      id,
                      forenameController.text,
                      surenameController.text,
                      _gender,
                      _birthday,
                    ));
                    Navigator.of(context).pop(competitors);
                  },
                  child: const Text('Bestätigen'),
                )
              else ...[
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      competitors.add(Competitor(
                        forenameController.text,
                        surenameController.text,
                        _gender,
                        _birthday,
                      ));
                    }
                  },
                  child: const Text("Hinzufügen & Neu"),
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      competitors.add(Competitor(
                        forenameController.text,
                        surenameController.text,
                        _gender,
                        _birthday,
                      ));
                      Navigator.of(context).pop(competitors);
                    }
                  },
                  child: const Text("Hinzufügen"),
                )
              ]
            ],
          );
        });
      });
  return competitors;
}
