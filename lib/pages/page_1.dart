import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

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
                  'lib/images/user.png',
                  width: 200,
                  height: 170,
                  fit: BoxFit.cover,
                ),

                const SizedBox(height: 20), //space ng image at title and text

                //title
                const Center(
                  child: Text(
                    'Overview',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                //text
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0),
                  child: SizedBox(
                    child: Text(
                      'Welcome to Sirib, your go-to multimedia mobile-based Iloko dictionary. Sirib is a passion project crafted by a team dedicated to preserving and promoting the rich linguistic heritage of the Iloko language.',
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
