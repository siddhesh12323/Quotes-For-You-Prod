import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_manager.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  List<Color> colours = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.pink,
    Colors.orange,
    Colors.yellow,
    Colors.teal,
    Colors.brown,
    Colors.indigo,
    Colors.cyan,
    Colors.lime,
    Colors.amber,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.deepPurple,
    Colors.deepOrange,
  ];

  Map<String, String> fontMap = {
    'CrimsonText': 'Crimson Text',
    'DancingScript': 'Dancing Script',
    'Georgia': 'Georgia',
    'HindSiliguri': 'Hind Siliguri',
    'Lora': 'Lora',
    'Merriweather': 'Merriweather',
    'Nunito': 'Nunito',
    'OpenSans': 'Open Sans',
    'PlayfairDisplay': 'Playfair Display',
    'ProductSans': 'Product Sans',
    'Quicksand': 'Quicksand',
    'RobotoSlab': 'Roboto Slab',
    'SanFrancisco': 'San Francisco',
    'TimesNewRoman': 'Times New Roman',
  };

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Choose a color'),
                          content: Container(
                            width: deviceWidth * 0.8,
                            height: deviceHeight * 0.5,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4, childAspectRatio: 1),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    themeManager.setChosenColor(colours[index]);
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: colours[index],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                );
                              },
                              itemCount: colours.length,
                            ),
                          ),
                        );
                      });
                },
                leading: const Text(
                  "Theme",
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: themeManager.chosenColor,
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Choose a font'),
                          content: Container(
                            width: deviceWidth * 0.8,
                            height: deviceHeight * 0.5,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    themeManager.setChosenFont(
                                        fontMap.keys.elementAt(index));
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      fontMap.values.elementAt(index),
                                      style: TextStyle(
                                        fontFamily:
                                            fontMap.keys.elementAt(index),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: fontMap.length,
                            ),
                          ),
                        );
                      });
                },
                leading: const Text(
                  "Font",
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Text(
                  themeManager.chosenFont
                      .replaceAllMapped(RegExp(r"([a-z])([A-Z])"), (match) {
                    return "${match.group(1)} ${match.group(2)}";
                  }),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ));
  }
}
