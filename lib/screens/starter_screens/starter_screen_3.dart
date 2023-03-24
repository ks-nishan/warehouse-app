import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import 'package:google_fonts/google_fonts.dart';

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
              Text(
                'Simple UI',
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w700)),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  "We are excited to introduce you to a user-friendly way to manage your warehouse.",
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
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
