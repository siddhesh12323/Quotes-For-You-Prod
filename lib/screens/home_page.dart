import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import '../local/favorites_manager.dart';
import '../models/quote_model.dart';
import '../theme/theme_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<QuoteModel> quoteFuture;
  Future<QuoteModel> getRandomQuote() async {
    final response = await http.get(
      Uri.parse('https://zenquotes.io/api/random/[your_key]'),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return QuoteModel.fromJson(data[0]);
    } else {
      throw Exception('Failed to load quote');
    }
  }

  @override
  void initState() {
    super.initState();
    quoteFuture = getRandomQuote();
  }

  @override
  Widget build(BuildContext context) {
    final favoritesManager = Provider.of<FavoritesManager>(context);
    final themeManager = Provider.of<ThemeManager>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes For You'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
          future: quoteFuture,
          builder: (context, AsyncSnapshot<QuoteModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                child: const SizedBox(
                    height: 100,
                    width: 200,
                    child: Center(
                      child: Text(
                        'Loading...',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
              ));
            } else if (snapshot.hasError) {
              return const Center(child: Text('Failed to load quote'));
            } else {
              String quoteText = snapshot.data!.q.toString();
              String quoteAuthor = ' by ${snapshot.data!.a}';
              if (quoteText ==
                  "Too many requests. Obtain an auth key for unlimited access.") {
                quoteText =
                    "Too many requests. Please restart the app to get new quotes.";
                quoteAuthor = "";
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onDoubleTap: () {
                        if (favoritesManager.isFavorite(snapshot.data!)) {
                          favoritesManager.removeFromFavorites(snapshot.data!);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  const Text('Quote removed from favorites'),
                              backgroundColor: themeManager.chosenColor,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        } else {
                          favoritesManager.addToFavorites(snapshot.data!);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Quote added to favorites'),
                              backgroundColor: themeManager.chosenColor,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        }
                        //print(favoritesManager.favorites);
                      },
                      child: Column(
                        children: [
                          Text(
                            quoteText,
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(quoteAuthor,
                              style: const TextStyle(
                                fontSize: 17,
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        quoteFuture = getRandomQuote();
                      });
                    },
                    child: const Text('Get Quote'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      await Share.share(
                        'Check out this Quote:\n${snapshot.data!.q.toString()}\nby ${snapshot.data!.a}',
                      );
                    },
                    child: const Text('Share'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
