// ignore_for_file: deprecated_member_use

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:sirib_app/pages/color_constants.dart';

class TranslationPage extends StatefulWidget {
  const TranslationPage({Key? key}) : super(key: key);

  @override
  State<TranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  final TextEditingController _textController = TextEditingController();
  String _translatedText = '';
  bool _showPlaceholder = true;
  String _sourceLanguage = 'en'; 
  String _targetLanguage = 'ilo'; 

  String _changeLanguageButtonText = 'English';

  // Initial text
  Future<void> _translateText(String text) async {
    const apiKey = 'AIzaSyBWUZPYZx-5PKX0g7yz6aqUaJvzw1VMACE';
    const apiUrl =
        'https://translation.googleapis.com/language/translate/v2?key=$apiKey';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'q': text,
        'source': _sourceLanguage,
        'target': _targetLanguage,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        _translatedText =
            jsonResponse['data']['translations'][0]['translatedText'];
        _showPlaceholder = false; 
      });
    } else {
      throw Exception('Failed to load translation');
    }
  }

  void _toggleLanguages() {
    setState(() {
      final String tempLanguage = _sourceLanguage;
      _sourceLanguage = _targetLanguage;
      _targetLanguage = tempLanguage;
      _translatedText = '';
      _textController.clear();
      _textController.text = '';

      
      _changeLanguageButtonText =
          _sourceLanguage == 'en' ? 'English' : 'Ilokano';
    });
  }

  @override
  Widget build(BuildContext context) {
    Color scaffoldBackgroundColor = AppColors.background1;
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Translation',
          style: TextStyle(
            color: Color.fromRGBO(198, 171, 124, 1),
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: const Color.fromRGBO(33, 54, 68, 1),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back, 
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, 
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              ElevatedButton.icon(
                onPressed: () {
                  _toggleLanguages();
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(137, 98, 61, 1),
                  minimumSize: const Size(355, 50),
                  fixedSize: const Size(355, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                icon: const Icon(Icons.language, color: Colors.white),
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _changeLanguageButtonText,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const Icon(Icons.swap_horiz,
                        color:
                            Colors.white), 
                    Text(
                      _changeLanguageButtonText == 'English'
                          ? 'Ilokano'
                          : 'English',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 180.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: _textController,
                    maxLines: 3,
                    maxLength: 100,
                    keyboardType: TextInputType.multiline,
                    style: GoogleFonts.poppins(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: _sourceLanguage == 'en'
                          ? 'Enter English'
                          : 'Enter Iloko',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                height: 180.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _showPlaceholder
                            ? Text(
                                'Translation Text Goes Here $_translatedText',
                                style: GoogleFonts.poppins(fontSize: 16),
                                maxLines: 5,
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.only(left: 3, right: 3),
                                child: Text(
                                  _translatedText,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.content_copy),
                        onPressed: () {
                          if (_translatedText.isNotEmpty) {
                            FlutterClipboard.copy(_translatedText)
                                .then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Copied to clipboard'),
                                ),
                              );
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _translateText(_textController.text);
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(137, 98, 61, 1),
                  minimumSize: const Size(150, 50),
                  fixedSize: const Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Translate',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color.fromARGB(221, 255, 255, 255),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
