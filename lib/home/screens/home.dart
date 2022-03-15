import 'package:flutter/material.dart';
import 'package:hang/newGame/data/providers/new_game_provider.dart';
import 'package:hang/newGame/screens/new_game_screen.dart';
import 'package:hang/newGame/screens/leaderboard_screen.dart';
import 'package:hang/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../../newGame/data/providers/auth_state_hang.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
          centerTitle: true,
          title: const MyTextWidget(
            text: "Hangman",
            size: 30.0,
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              child: Image.asset(
                "assets/img/pexels-neosiam-625219.jpg",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<NewGameProvider>(context, listen: false).init();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const NewGame()));
                },
                child: const Text("New Game"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LeaderboardScreen()));
                },
                child: const Text("Leaderboard"),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<AuthState>(context, listen: false).signOut();
              },
              child: const Text("Log Out"),
              style: ElevatedButton.styleFrom(primary: Colors.red[900]),
            )
          ],
        ),
      ),
    );
  }
}
