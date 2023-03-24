import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class StarterPage1 extends StatelessWidget {
  const StarterPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.yellow[700],
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Image.asset("assets/images/deliveries.png"),
              ),
              Text(
                'Welcome to Zompot',
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w700)),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    "Streamline your inventory management, optimize your order processing, and increase productivity.",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
