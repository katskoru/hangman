import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hang/newGame/data/providers/new_game_provider.dart';

import 'package:hang/newGame/screens/new_game_body.dart';
import 'package:hang/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class NewGame extends StatelessWidget {
  const NewGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? _currentWord = Provider.of<NewGameProvider>(context).currentWord;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed:
                Provider.of<NewGameProvider>(context, listen: true).timer ==
                        null
                    ? null
                    : () {
                        if (Provider.of<NewGameProvider>(context, listen: false)
                                .timer !=
                            null) {
                          Provider.of<NewGameProvider>(context, listen: false)
                              .endTimer();
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
      body: WillPopScope(
          onWillPop: () async {
            if (Provider.of<NewGameProvider>(context, listen: false).timer !=
                null) {
              Provider.of<NewGameProvider>(context, listen: false).endTimer();
              return true;
            } else {
              return false;
            }
          },
          child: NewGameBody()),
    );
  }
}
