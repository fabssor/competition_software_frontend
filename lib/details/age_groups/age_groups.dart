import 'package:flutter/material.dart';

class AgeGroups extends StatelessWidget {
  const AgeGroups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Card(
              child: Text("Test"),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        child: const Icon(Icons.group_add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
