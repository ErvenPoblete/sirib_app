import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirib_app/dictionary_data.dart';
import 'favorites_provider.dart';
import 'dictionary_details_page.dart';
import 'package:sirib_app/pages/color_constants.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Dictionary> favorites =
        Provider.of<FavoritesProvider>(context).favorites;

    return Scaffold(
      backgroundColor: AppColors.background1,
      appBar: AppBar(
        title: const Text(
          'Favorites',
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
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: RichText(
              text: TextSpan(
                text: favorites[index].ilokano ?? '',
                style: const TextStyle(
                  color: Color.fromARGB(
                      255, 255, 255, 255), 
                  fontSize: 18.0, 
                  fontWeight: FontWeight.bold, 
                ),
              ),
            ),
            onTap: () {
            
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DictionaryDetailsPage(
                    dictionary: favorites[index],
                    item: '',
                  ),
                ),
              );
            },
            trailing: IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
             
                Provider.of<FavoritesProvider>(context, listen: false)
                    .removeFromFavorites(favorites[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
