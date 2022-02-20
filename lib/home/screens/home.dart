import 'package:flutter/material.dart';
import 'package:hang/newGame/data/providers/new_game_provider.dart';
import 'package:hang/newGame/screens/new_game_screen.dart';
import 'package:hang/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewGameProvider())
      ],
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
            centerTitle: true,
            title: const MyTextWidget(
              text: "HangMan",
              size: 30.0,
            )),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/pexels-arindam-raha-2213575.jpg",
                width: 70.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewGame()));
                },
                child: const Text("New Game"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Leaderboard"),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Log Out"),
                style: ElevatedButton.styleFrom(primary: Colors.red[900]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
