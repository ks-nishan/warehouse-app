import "package:flutter/material.dart";
import "package:lottie/lottie.dart";

class StarterPage3 extends StatelessWidget {
  const StarterPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.yellow[700],
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Page 02',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Image.asset("assets/images/calender.png"),
              ),
            ],
          ),
        ));
  }
}
