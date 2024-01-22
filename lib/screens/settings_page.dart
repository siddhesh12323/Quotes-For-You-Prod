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
    Colors.black,
  ];

  List<String> fonts = [];

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                onTap: () {
                  // show dialog for theme selection
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Choose a color'),
                          content: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4),
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
                        );
                      });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Theme",
                      style: TextStyle(fontSize: 20),
                    ),
                    const Spacer(),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: themeManager.chosenColor,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                onTap: () {
                  // show dialog for font selection
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Choose a font'),
                          content: ListView(
                            children: [
                              ListTile(
                                title: const Text('Crimson Text'),
                                onTap: () {
                                  themeManager.setChosenFont('CrimsonText');
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Dancing Script'),
                                onTap: () {
                                  themeManager.setChosenFont('DancingScript');
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Georgia'),
                                onTap: () {
                                  themeManager.setChosenFont('Georgia');
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Hind Siliguri'),
                                onTap: () {
                                  themeManager.setChosenFont('HindSiliguri');
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Lora'),
                                onTap: () {
                                  themeManager.setChosenFont('Lora');
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Merriweather'),
                                onTap: () {
                                  themeManager.setChosenFont('Merriweather');
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Nunito'),
                                onTap: () {
                                  themeManager.setChosenFont('Nunito');
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Open Sans'),
                                onTap: () {
                                  themeManager.setChosenFont('OpenSans');
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Playfair Display'),
                                onTap: () {
                                  themeManager.setChosenFont('PlayfairDisplay');
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Product Sans'),
                                onTap: () {
                                  themeManager.setChosenFont('ProductSans');
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Quicksand'),
                                onTap: () {
                                  themeManager.setChosenFont('Quicksand');
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Roboto Slab'),
                                onTap: () {
                                  themeManager.setChosenFont('RobotoSlab');
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('San Francisco'),
                                onTap: () {
                                  themeManager.setChosenFont('SanFrancisco');
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Times New Roman'),
                                onTap: () {
                                  themeManager.setChosenFont('TimesNewRoman');
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Font",
                      style: TextStyle(fontSize: 20),
                    ),
                    const Spacer(),
                    Text(
                      themeManager.chosenFont
                          .replaceAllMapped(RegExp(r"([a-z])([A-Z])"), (match) {
                        return "${match.group(1)} ${match.group(2)}";
                      }),
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
