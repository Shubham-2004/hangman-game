import 'package:flutter/material.dart';
import 'package:hangman/const/const.dart';
import 'package:hangman/game/figure.dart';
import 'package:hangman/game/letters.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var character = "abcdefghijklmnopqrstuvwxyz".toUpperCase();
  List<String> words = [
    "Mohan",
    "Rockstar",
    "Starwars",
    "Galaxy",
    "Brahmastra",
    "University",
    "Reflection"
  ].map((e) => e.toUpperCase()).toList();
  late String currentWord;
  List<String> selectedChar = [];
  var tries = 0;
  int points = 0;

  // List<String> champ = ["You are Winner"];

  List<String> win = ["You are Losser"];
  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    if (words.isEmpty) {
      // No more words left, reset the game
      words = [
        "Mohan",
        "Rockstar",
        "Starwars",
        "Galaxy",
        "Brahmastra",
        "University",
        "Reflection"
      ].map((e) => e.toUpperCase()).toList();
      points--;
    } else {
      currentWord = words.removeAt(0);
      selectedChar.clear();
      tries = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("HANGMAN : The Game"),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Expanded(
                    flex: 4,
                    child: Stack(
                      children: [
                        figure(GameUI.pole, tries >= 0),
                        figure(GameUI.head, tries >= 1),
                        figure(GameUI.body, tries >= 2),
                        figure(GameUI.lefth, tries >= 3),
                        figure(GameUI.righth, tries >= 4),
                        figure(GameUI.leftl, tries >= 5),
                        figure(GameUI.rightl, tries >= 6),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(8.0),


                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: currentWord

                            .split("")
                            .map((e) => hiddenLetter(
                                  e,
                                  !selectedChar.contains(e.toUpperCase()),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 7,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: character.split("").map((e) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black54,
                    ),
                    onPressed: selectedChar.contains(e.toUpperCase())
                        ? null
                        : () {
                            setState(() {
                              selectedChar.add(e.toUpperCase());
                              if (!currentWord
                                  .split("")
                                  .contains(e.toUpperCase())) {
                                tries++;
                                if (tries >= 6) {
                                  // If max tries reached, end the game and move to next word
                                  _startNewGame();
                                }
                              } else {
                                // Check if the word has been completely guessed
                                if (currentWord.split("").every((char) =>
                                    selectedChar
                                        .contains(char.toUpperCase()))) {
                                  points++;
                                  _startNewGame();
                                }
                              }
                            });
                          },
                    child: Text(
                      e,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            child: Text(
              "Points: $points",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
