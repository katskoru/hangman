import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hang/newGame/data/models/leaderboard.dart';

class LeaderboardScreen extends StatelessWidget {
  LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hangman")),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Login"),
              Text("Score"),
              Text("Time"),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("leaderboard")
                      .orderBy("score", descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      List<Leaderboard> _listOfRecords =
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;

                        return Leaderboard.fromJson(data);
                      }).toList();

                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: _listOfRecords.length,
                          itemBuilder: (context, index) {
                            Leaderboard _records = _listOfRecords[index];
                            return ListTile(
                                title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(_records.login!),
                                Text(_records.score!.toString()),
                                Text(_records.time!.toString()),
                              ],
                            ));
                          });
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
