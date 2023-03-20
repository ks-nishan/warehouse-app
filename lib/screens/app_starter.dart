import "package:flutter/material.dart";
import "package:smooth_page_indicator/smooth_page_indicator.dart";
import "package:warehouse_app/screens/employee_list.dart";
import "package:warehouse_app/screens/starter_screens/starter_screen_1.dart";
import "package:warehouse_app/screens/starter_screens/starter_screen_2.dart";
import "package:warehouse_app/screens/starter_screens/starter_screen_3.dart";

class AppStarter extends StatefulWidget {
  const AppStarter({super.key});

  @override
  State<AppStarter> createState() => _AppStarterState();
}

class _AppStarterState extends State<AppStarter> {
  //controller to keep track where the page we were
  PageController _controller = PageController();

  //keep track of if we are in last page
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: const [StarterPage1(), StarterPage3(), StarterPage2()],
        ),

        //dot indicator
        Container(
            alignment: const Alignment(0, 0.85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //skip link
                GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                    child: const Text("Skip")),

                SmoothPageIndicator(controller: _controller, count: 3),

                //next link
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return EmployeeList();
                          }));
                        },
                        child: Text("Done"))
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text("Next")),
              ],
            ))
      ],
    ));
  }
}
