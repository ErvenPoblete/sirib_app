import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

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
                const SizedBox(height: 40),

                //the images
                Image.asset(
                  'lib/images/visionary.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),

                const SizedBox(height: 30),

                //title
                const Center(
                  child: Text(
                    'Vision',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                //text
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0), 
                  child: SizedBox(
                    child: Text(
                      'We envision a future where the Iloko language thrives, transcending generations. Sirib aims to be a dynamic platform that evolves with the needs of its users, consistently offering innovative features and educational.',
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
