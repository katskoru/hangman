import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hang/newGame/data/providers/new_game_provider.dart';

import 'package:hang/newGame/screens/new_game_body.dart';
import 'package:hang/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class NewGame extends StatefulWidget {
  const NewGame({Key? key}) : super(key: key);

  @override
  State<NewGame> createState() => _NewGameState();
}

class _NewGameState extends State<NewGame> {
  Timer? _timer;
  @override
  void initState() {
    // Provider.of<TimerProvider>(context).init();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int? _currentWord = Provider.of<NewGameProvider>(context).currentWord;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (Provider.of<NewGameProvider>(context, listen: false).timer !=
                  null) {
                Provider.of<NewGameProvider>(context, listen: false).endTimer();
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.reply_outlined)),
        centerTitle: true,
        title: MyTextWidget(
          size: 30.0,
          text: Provider.of<NewGameProvider>(context).time.toString() + " s",
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: MyTextWidget(
                text: _currentWord!.toString(),
                size: 30.0,
              )),
        ],
      ),
      body: const NewGameBody(),
    );
  }
}
