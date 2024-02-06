import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sirib_app/dictionary_data.dart';
import 'package:sirib_app/pages/dictionary_details_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirib_app/pages/color_constants.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  late List<Dictionary> dictionary;
  late List<Dictionary> filteredDictionary = [];
  final alphabet = "abdefghiklmnoprstuwy";
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Load the dictionary data when the widget is initialized
    getDictionary().then((data) {
      setState(() {
        dictionary = data;
        filteredDictionary = List.from(dictionary);
      });
    });
  }

  Future<List<Dictionary>> getDictionary() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/data/dictionary.json");

    List mapData = jsonDecode(data);

    List<Dictionary> dictionary =
        mapData.map((dictionary) => Dictionary.fromJson(dictionary)).toList();

    return dictionary;
  }

  void filterDictionary(String query) {
    setState(() {
      if (query.isEmpty) {
        // If the query is empty, show the entire dictionary
        filteredDictionary = List.from(dictionary);
      } else {
        filteredDictionary = dictionary
            .where((entry) =>
                (entry.ilokano
                        ?.toLowerCase()
                        .startsWith(query.toLowerCase()) ??
                    false) ||
                (entry.english
                        ?.toLowerCase()
                        .startsWith(query.toLowerCase()) ??
                    false))
            .toList();
      }
    });
  }

  final Map<String, double> letterHeights = {
    'a': 80.0,
    'b': 80.0,
    'd': 80.0,
    'e': 55.0,
    'f': 10.0,
    'g': 100.0,
    'h': 80.0,
    'i': 75.0,
    'k': 85.0,
    'l': 70.0,
    'm': 75.0,
    'n': 70.0,
    'o': 65.0,
    'p': 80.0,
    'r': 80.0,
    's': 80.0,
    't': 80.0,
    'u': 70.0,
    'w': 75.0,
    'y': 40.0,
  };

  void scrollToSection(String letter) {
    double totalHeight = _calculateTotalHeight(letter);
    _scrollController.animateTo(
      totalHeight,
      duration: const Duration(milliseconds: 5000),
      curve: Curves.easeInOut,
    );
  }

  double _calculateTotalHeight(String targetLetter) {
    double totalHeight = 0.0;
    bool found = false;

    for (int i = 0; i < filteredDictionary.length; i++) {
      String currentLetter = filteredDictionary[i].ilokano![0].toLowerCase();

      if (letterHeights.containsKey(currentLetter)) {
        // If the letter has a defined height, add it to the total height
        totalHeight += letterHeights[currentLetter]!;
      }

      // Stop when you reach the desired letter
      if (currentLetter == targetLetter.toLowerCase()) {
        found = true;
        break;
      }
    }

    if (!found) {
      // If the target letter is not found, scroll to the top
      totalHeight = 4.0;
    } else {
      // Adjust the totalHeight to show a few more items for better visibility

      totalHeight -= 80.0; // You can adjust this value as needed
    }

    return totalHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background1,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 10),
                Text(
                  'Dictionary',
                  style: GoogleFonts.oswald(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(198, 171, 124, 1),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  onChanged: (query) {
                    filterDictionary(query);
                  },
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
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
                    hintText: 'Search ilokano or english',
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // Alphabet Scroll List
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: alphabet.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: ElevatedButton(
                        onPressed: () {
                          scrollToSection(alphabet[index]);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          backgroundColor: const Color.fromRGBO(137, 98, 61, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          alphabet[index],
                          style: GoogleFonts.poppins(fontSize: 15),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(10),
                  itemCount: filteredDictionary.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            filteredDictionary[index].ilokano!,
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          subtitle: Text(
                            filteredDictionary[index].english ??
                                'N/A', // Use 'N/A' as a fallback value
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DictionaryDetailsPage(
                                  dictionary: filteredDictionary[index],
                                  item: '',
                                ),
                              ),
                            );
                          },
                        ),
                        const Divider(
                          height: 2,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
