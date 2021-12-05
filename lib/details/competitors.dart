import 'package:flutter/material.dart';

enum gender { male, female }

class Competitors extends StatefulWidget {
  const Competitors({Key? key}) : super(key: key);

  @override
  State<Competitors> createState() => _CompetitorsState();
}

class _CompetitorsState extends State<Competitors> {
  final TextEditingController _controller = TextEditingController();

  gender? _gender = gender.female;

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
          suffixIcon: suffixIcon),
      onTap: onTap,
    );
  }

  Widget _buildGenderRadioButton({required Text title, required gender value}) {
    return Expanded(
      child: RadioListTile<gender>(
        title: title,
        value: value,
        groupValue: _gender,
        onChanged: (gender? value) => setState(() => _gender = value),
      ),
    );
  }

  Future<void> addCompetitorDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text("Teilnehmer hinzufügen"),
              content: Column(
                children: <Widget>[
                  _buildTextFormField(
                    labelText: "Nachname",
                  ),
                  _buildTextFormField(
                    labelText: "Vorname",
                  ),
                  _buildTextFormField(
                    controller: _controller,
                    readOnly: true,
                    labelText: "Geburtsdatum",
                    suffixIcon: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final DateTime? dateTime = await getDate(context);
                      if (dateTime == null) {
                        return;
                      } else {
                        _controller.text =
                            "${dateTime.day}.${dateTime.month}.${dateTime.year}";
                      }
                    },
                  ),
                  Row(
                    children: [
                      _buildGenderRadioButton(
                        title: const Text("männlich"),
                        value: gender.male,
                      ),
                      _buildGenderRadioButton(
                        title: const Text("weiblich"),
                        value: gender.female,
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Abbrechen"),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("Hinzufügen & Neu"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Hinzufügen"),
                ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: DataTable(
            columns: [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Vorname')),
              DataColumn(label: Text('Geschlecht')),
              DataColumn(label: Text('Geburtsdatum')),
              DataColumn(label: Text(''))
            ],
            rows: [
              DataRow(
                cells: [
                  DataCell(Text('1')),
                  DataCell(Text('Sorkalla')),
                  DataCell(Text('Fabian')),
                  DataCell(Text('männlich')),
                  DataCell(Text('04.01.1995')),
                  DataCell(Wrap(
                    spacing: 0, // space between two icons
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ],
                  )),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('2')),
                  DataCell(Text('Sorkalla')),
                  DataCell(Text('Fabian')),
                  DataCell(Text('männlich')),
                  DataCell(Text('04.01.1995')),
                  DataCell(Wrap(
                    spacing: 0, // space between two icons
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ],
                  )),
                ],
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await addCompetitorDialog(context);
          },
          child: const Icon(Icons.person_add),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
