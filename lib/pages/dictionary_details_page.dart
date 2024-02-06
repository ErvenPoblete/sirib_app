import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sirib_app/dictionary_data.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'favorites_provider.dart';

class DictionaryDetailsPage extends StatefulWidget {
  final Dictionary dictionary;

  const DictionaryDetailsPage({
    Key? key,
    required this.dictionary,
    required String item,
  }) : super(key: key);

  @override
  State<DictionaryDetailsPage> createState() => _DictionaryDetailsPageState();
}

class _DictionaryDetailsPageState extends State<DictionaryDetailsPage> {
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  bool isSoundIconTapped = false;

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  void _playSound() {
    String? audioPath = widget.dictionary.soundsUrl!;

    // ignore: unnecessary_null_comparison
    if (audioPath != null) {
      _assetsAudioPlayer.open(Audio.network(audioPath));
      _assetsAudioPlayer.play();
    }

    setState(() {
      isSoundIconTapped = true;
    });

    
    if (mounted) {
      Timer(const Duration(seconds: 3), () {
    
        if (mounted) {
          setState(() {
            isSoundIconTapped = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 255,
              color: const Color.fromRGBO(33, 54, 68, 1),
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Text(
                    widget.dictionary.ilokano!,
                    style: GoogleFonts.montserrat(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(
                          198, 171, 124, 1), 
                    ),
                  ),
                  Text(
                    widget.dictionary.pronunciation!,
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  //icon sa heart at sound
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(68, 0, 0, 0)),
                        padding: const EdgeInsets.all(4),
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: Provider.of<FavoritesProvider>(context)
                                    .favorites
                                    .contains(widget.dictionary)
                                ? Colors.red
                                : Colors.white,
                          ),
                          onPressed: () {
                            FavoritesProvider favoritesProvider =
                                Provider.of<FavoritesProvider>(context,
                                    listen: false);

                            if (favoritesProvider.favorites
                                .contains(widget.dictionary)) {
                              favoritesProvider
                                  .removeFromFavorites(widget.dictionary);
                            } else {
                              favoritesProvider
                                  .addToFavorites(widget.dictionary);
                            }
                          },
                        ),
                      ),
                  
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: _playSound,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSoundIconTapped
                                    ? Colors.black
                                    : Colors
                                        .transparent, 
                              ),
                            ),
                            Container(
                              width: 55,
                              height: 55,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(68, 0, 0, 0),
                              ),
                              child: Icon(
                                Icons.volume_up,
                                size: 35,
                                color: isSoundIconTapped
                                    ? const Color.fromARGB(255, 115, 190, 227)
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 9),
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //normal na text na definition title
                    const SizedBox(height: 10),
                    Text(
                      'Definition',
                      style: GoogleFonts.montserrat(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    //part of speech
                    Row(
                      children: [
                        // Part of speech
                        Text(
                          widget.dictionary.partOfSpeech!,
                          style: GoogleFonts.montserrat(
                              fontSize: 17,
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontStyle: FontStyle.italic),
                        ),

                        const SizedBox(width: 7),

                        if (widget.dictionary.affix != null &&
                            widget.dictionary.affix!.isNotEmpty)
                          Text(
                            widget.dictionary.affix!,
                            style: GoogleFonts.montserrat(
                              fontSize: 17,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    //English Example

                    Text(
                      widget.dictionary.english!,
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 15),

                    //example title
                    Text(
                      'Example',
                      style: GoogleFonts.montserrat(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // example
                    Text(
                      widget.dictionary.example!,
                      style: GoogleFonts.montserrat(fontSize: 16),
                    ),
                    const SizedBox(height: 30),

                    // Images with text

                    Center(
                      child: Text(
                        'Image',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Center(
                          child: Image.asset(
                            widget.dictionary.imageUrl!,
                            width: 250,
                            height: 250,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
