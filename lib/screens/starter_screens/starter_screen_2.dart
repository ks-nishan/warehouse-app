import "package:flutter/material.dart";
import "package:lottie/lottie.dart";

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
              "Delivery",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32),
            ),
          ],
        ));
  }
}
