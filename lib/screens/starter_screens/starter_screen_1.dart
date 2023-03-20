import "package:flutter/material.dart";

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
              const Text(
                'Welcome to Zompot',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "we provide you to manage yoour bussiness!!!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ));
  }
}
