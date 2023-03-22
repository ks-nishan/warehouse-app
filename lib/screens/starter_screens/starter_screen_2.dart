import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import 'package:google_fonts/google_fonts.dart';

class StarterPage2 extends StatefulWidget {
  const StarterPage2({super.key});

  @override
  State<StarterPage2> createState() => _StarterPage2State();
}

class _StarterPage2State extends State<StarterPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[700],
        body: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Center(
              child: Container(
                child: Lottie.network(
                    "https://assets8.lottiefiles.com/packages/lf20_eop7ymay.json"),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            const Text(
              "Lets Start!!!",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                "Let's get started and revolutionize the way you manage your warehouse!",
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ));
  }
}
