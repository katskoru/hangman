import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hang/newGame/data/models/leaderboard.dart';
import 'package:hang/widgets/text_widget.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.reply_outlined)),
          centerTitle: true,
          title: const MyTextWidget(
            text: "Leaderboard",
            size: 30,
          )),
      body: Column(
        children: [
          Container(
            height: 40,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                SizedBox(
                  width: 45,
                ),
                MyTextWidget(
                  text: "Login",
                  size: 20,
                ),
                MyTextWidget(
                  text: "Score",
                  size: 20,
                ),
                MyTextWidget(
                  text: "Time",
                  size: 20,
                ),
              ],
            ),
          ),
          Expanded(
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
                          return Container(
                            width: double.infinity,
                            color: (index % 2 == 0)
                                ? Colors.white
                                : Colors.grey[800],
                            child: ListTile(
                                leading: Text((index + 1).toString()),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(_records.login!),
                                    Text(_records.score!.toString()),
                                    Text(_records.time!.toString()),
                                  ],
                                )),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
