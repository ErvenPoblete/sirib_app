import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 30),

                //the images
                Image.asset(
                  'lib/images/phone-book.png',
                  width: 170,
                  height: 170,
                  fit: BoxFit.cover,
                ),

                const SizedBox(height: 20),

                //title
                const Center(
                  child: Text(
                    'About Us',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                //text
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0), 
                  child: SizedBox(
                    child: Text(
                      'We would love to hear from you! For inquiries, feedback, or support, feel free to reach out to us',
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'erven.poblete@student.dmmmsu.edu.ph',
                  style: GoogleFonts.roboto(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
