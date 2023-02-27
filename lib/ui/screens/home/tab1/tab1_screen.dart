import 'package:clinicapp/ui/screens/home/tab2/add_booking/add_booking_screen.dart';
import 'package:flutter/material.dart';

class PrepScreen extends StatelessWidget {
  const PrepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddBooking()));
          },
          label: Text("Create new prep"),
          icon: Icon(Icons.add)),
      body: Container(),
    );
  }
}
