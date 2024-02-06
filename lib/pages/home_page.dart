// ignore_for_file: deprecated_member_use
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sirib_app/dictionary_data.dart';
import 'package:sirib_app/pages/about_us_page.dart';
import 'package:sirib_app/pages/color_constants.dart';
import 'package:sirib_app/pages/dictionary_details_page.dart';
import 'package:sirib_app/pages/dictionary_page.dart';
import 'package:sirib_app/pages/favorite_page.dart';
import 'package:sirib_app/pages/translation_page.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Dictionary> dictionary;
  late List<String> ilokanoWords = [];
  late List<String> filteredIlokanoWords = [];
  List<Map<String, String>> wordOfTheDayList =
      []; // List to store Word of the Day data
  late SharedPreferences _prefs;
  static const String _wordOfTheDayKey = 'word_of_the_day';

  Future<void> _showExitConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit Confirmation'),
          content: const Text('Are you sure you want to exit?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                SystemNavigator.pop();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Load the dictionary data when the widget is initialized
    getDictionary().then((data) async {
      await _loadWordOfTheDay();
      setState(() {
        dictionary = data;
        ilokanoWords = dictionary.map((entry) => entry.ilokano!).toList();
        filteredIlokanoWords = List.from(ilokanoWords);
      });
    });
  }

  Future<void> _loadWordOfTheDay() async {
    _prefs = await SharedPreferences.getInstance();

    String? savedWordOfTheDay = _prefs.getString(_wordOfTheDayKey);

    if (savedWordOfTheDay != null) {
      Map<String, dynamic> decodedWord = jsonDecode(savedWordOfTheDay);
      _updateWordOfTheDay(decodedWord.cast<String, String>());
    } else {
      // Use the saved Word of the Day
      Map<String, String> decodedWord = jsonDecode(savedWordOfTheDay!);
      _updateWordOfTheDay(decodedWord);
    }
  }

  void _updateWordOfTheDay(Map<String, String> word) {
    setState(() {
      wordOfTheDayList = [word];
    });
  }

  Future<void> loadWordOfTheDay() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM dd, yyyy').format(now);

    dictionary.shuffle();

    Dictionary wordOfTheDay = dictionary.first;

    // Save the Word of the Day to SharedPreferences
    await _prefs.setString(
      _wordOfTheDayKey,
      jsonEncode({
        'date': formattedDate,
        'ilokano': wordOfTheDay.ilokano!,
        'partOfSpeech': wordOfTheDay.partOfSpeech!,
        'pronunciation': wordOfTheDay.pronunciation!,
        'example': wordOfTheDay.example!,
      }),
    );
  }

  // Function para makuha yung dictionary data
  Future<List<Dictionary>> getDictionary() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/data/dictionary.json");

    List mapData = jsonDecode(data);

    List<Dictionary> dictionary =
        mapData.map((dictionary) => Dictionary.fromJson(dictionary)).toList();

    return dictionary;
  }

  void filterIlokanoWords(String query) {
    setState(() {
      filteredIlokanoWords = ilokanoWords
          .where((word) => word.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void navigateToDictionaryDetailsPage(String ilokanoWord) {
    Dictionary selectedDictionary = dictionary.firstWhere(
      (entry) => entry.ilokano == ilokanoWord,
      orElse: () => Dictionary(),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DictionaryDetailsPage(
          dictionary: selectedDictionary,
          item: '',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color scaffoldBackgroundColor = AppColors.background1;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(33, 54, 68, 1),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(137, 98, 61, 1),
          size: 35,
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: const Color.fromRGBO(58, 91, 113, 1),
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: const Color.fromRGBO(58, 91, 113, 1),
                leading: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.book_rounded,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                title: const Text(
                  'Dictionary',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DictionaryPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.translate,
                    color: Color.fromRGBO(255, 255, 255, 1)),
                title: const Text(
                  'Translate',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TranslationPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.favorite_border,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                title: const Text(
                  'Favorites',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoritePage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.new_releases_outlined,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                title: const Text(
                  'About Us',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutUS(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                title: const Text(
                  'Exit',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  _showExitConfirmationDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Image.asset(
                'lib/images/SIRIB_LOGO.png',
                height: 140.0,
              ),
            ),

            // Search bar using AutoCompleteTextField
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: AutoCompleteTextField<String>(
                key: GlobalKey(),
                clearOnSubmit: false,
                suggestions: ilokanoWords,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 161, 168, 155),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 35,
                    ),
                    hintText: 'Search Ilokano',
                    hintStyle: GoogleFonts.poppins(fontSize: 17)),
                style: const TextStyle(
                  color: Color.fromARGB(255, 3, 3, 3),
                ),
                itemFilter: (item, query) {
                  return item.toLowerCase().startsWith(query.toLowerCase());
                },
                itemSorter: (a, b) {
                  return a.compareTo(b);
                },
                itemSubmitted: (item) {
                  navigateToDictionaryDetailsPage(item);
                },
                itemBuilder: (context, item) {
                  return ListTile(
                    title: Text(
                      item,
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DictionaryPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(137, 98, 61, 1),
                    minimumSize: const Size(150, 50),
                    fixedSize: const Size(150, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Dictionary',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color.fromARGB(221, 255, 255, 255),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TranslationPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.background2,
                    minimumSize: const Size(150, 55),
                    fixedSize: const Size(150, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Translation',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color.fromARGB(221, 255, 255, 255),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            //word of the day
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Word of the Day title
                        Center(
                          child: Text(
                            'Word of the Day',
                            style: GoogleFonts.anekBangla(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),

                        // Display Word of the Day
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: wordOfTheDayList.map((word) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //date
                                Center(
                                  child: Text(
                                    '${word['date']}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 161, 157, 157),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                //Ilokano word
                                Center(
                                  child: Text(
                                    '${word['ilokano']}',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          const Color.fromRGBO(137, 98, 61, 1),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    ' ${word['pronunciation']}',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                //part of speech word
                                Text(
                                  '${word['partOfSpeech']}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                Text(
                                  '${word['example']}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
