import 'package:flutter/material.dart';

class PrepScreen extends StatelessWidget {
  const PrepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {},
          label: Text("Create new prep"),
          icon: Icon(Icons.add)),
      body: Container(),
    );
  }
}
