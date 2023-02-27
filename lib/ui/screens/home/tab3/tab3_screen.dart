import 'package:clinicapp/config/constant/constant.dart';
import 'package:clinicapp/models/book_model.dart';
import 'package:clinicapp/ui/widgets/booking_card.dart';
import 'package:clinicapp/ui/widgets/errorpage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  late Future<BookModel> futureData;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<BookModel> data = snapshot.data as List<BookModel>;
              print(data);
              if (data.isEmpty) {
                ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var itemData = data[index];
                    return BookkingCard(
                      titel: cliicItems[itemData.c_id],
                      des: itemData.date,
                      b1fun: () {},
                      b2fun: () {},
                    );
                  },
                );
              } else {
                return Center(
                    child: Lottie.asset("assets/animation/emptybox.json",
                        width: size.width * 0.6));
              }
            } else if (snapshot.hasError) {
              return Errorpage(size: size.width * 0.7);
            }

            return Center(
                child: Lottie.asset("assets/animation/loadingdots.json",
                    width: size.width * 0.6));
          },
        ),
      ),
    );
  }
}
