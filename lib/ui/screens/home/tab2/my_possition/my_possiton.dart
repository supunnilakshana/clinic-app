import 'package:clinicapp/ui/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';

class MyPosition extends StatefulWidget {
  const MyPosition({super.key, required this.cinicName});
  final String cinicName;
  @override
  State<MyPosition> createState() => _MyPositionState();
}

class _MyPositionState extends State<MyPosition> {
  String frontpeople = "loading..";

  String posstion = "loading..";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryColordark),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                " STI Clinic",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.066,
                  color: Colors.blue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Lottie.asset("assets/animation/waiting.json",
                  width: size.width * 0.6),
            ),
            Text(
              "54 ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size.width * 0.096,
                color: kPrimaryColordark,
              ),
            ),
            Text(
              " People  infront of you",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size.width * 0.046,
                color: kPrimaryColordark,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Text(
                "Your Possition is 56",
                style: TextStyle(
                    fontSize: size.width * 0.041,
                    color: Colors.black.withOpacity(0.7)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
