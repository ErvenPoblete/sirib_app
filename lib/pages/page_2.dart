import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

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
                const SizedBox(height: 20),

                //the images
                Image.asset(
                  'lib/images/mission.png',
                  width: 180,
                  height: 180,
                ),

                const SizedBox(height: 20), //space ng image at title and text

                //title
                const Center(
                  child: Text(
                    'Mission',
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
                      'At Sirib, our mission is to make the Iloko language accessible and enjoyable for everyone. We strive to provide an immersive and interactive language-learning experience that fosters a deeper connection to Iloko culture.',
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
