import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../local/favorites_manager.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesManager = Provider.of<FavoritesManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: favoritesManager.loadFavorites(),
        builder: (context, snapshot) {
          if (favoritesManager.favorites.isEmpty) {
            return const Center(
              child: Text('No favorite quotes yet.'),
            );
          } else {
            return ListView.builder(
              itemCount: favoritesManager.favorites.length,
              itemBuilder: (context, index) {
                final quote = favoritesManager.favorites[index];
                return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            // show dialog for delete confirmation
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                    child: AlertDialog(
                                  title: const Text("Remove quote?"),
                                  content: const Text(
                                      "Are you sure you want to remove this quote from favorites?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel")),
                                    TextButton(
                                      onPressed: () {
                                        // delete quote from favorites
                                        //! CHECK THIS!
                                        favoritesManager
                                            .removeFromFavorites(quote);
                                        Navigator.pop(context);
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ));
                              },
                            );
                          },
                          label: 'Delete',
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(quote.q.toString()),
                      subtitle: Text(quote.a.toString()),
                      textColor: Colors.black,
                    ));
              },
            );
          }
        },
      ),
    );
  }
}
