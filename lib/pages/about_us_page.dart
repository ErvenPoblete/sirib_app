import 'package:flutter/material.dart';
import 'package:sirib_app/pages/page_1.dart';
import 'package:sirib_app/pages/page_2.dart';
import 'package:sirib_app/pages/page_3.dart';
import 'package:sirib_app/pages/page_4.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AboutUS extends StatelessWidget {
  final _controller = PageController();

  AboutUS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(33, 54, 68, 1),
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(
            color: Color.fromRGBO(198, 171, 124, 1),
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: const Color.fromRGBO(33, 54, 68, 1),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back, // Change this to the desired back button icon
            color: Colors.white, // Change this to the desired color
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Change this to the desired color
        ),
      ),
      body: Column(
        children: [
          // page view
          SizedBox(
            height: 500,
            child: PageView(
              controller: _controller,
              children: const [
                Page1(),
                Page2(),
                Page3(),
                Page4(),
              ],
            ),
          ),
          const SizedBox(height: 60),
          // dot indicators
          SmoothPageIndicator(
            controller: _controller,
            count: 4,
            effect: const JumpingDotEffect(
              activeDotColor: Color.fromARGB(255, 201, 198, 205),
              dotColor: Colors.black,
              dotHeight: 15,
              dotWidth: 15,
              spacing: 15,
              jumpScale: 2,
            ),
          ),
        ],
      ),
    );
  }
}
