import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "HangMan Game",
          style: TextStyle(fontFamily: "Marker", fontSize: 30.0),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/img/pexels-photo-220453.jpeg",
              width: 70.0,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("New Game"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Leaderboard"),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Log Out"),
              style: ElevatedButton.styleFrom(primary: Colors.red[900]),
            )
          ],
        ),
      ),
    );
  }
}
