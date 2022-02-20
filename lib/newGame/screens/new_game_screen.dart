import 'package:flutter/material.dart';
import 'package:hang/newGame/screens/new_game_body.dart';
import 'package:hang/widgets/text_widget.dart';

class NewGame extends StatelessWidget {
  const NewGame({Key? key}) : super(key: key);

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
          size: 30.0,
          text: "Timer",
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: MyTextWidget(
                text: "2",
                size: 30.0,
              )),
        ],
      ),
      body: NewGameBody(),
    );
  }
}
