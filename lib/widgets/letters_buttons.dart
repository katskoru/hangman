import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hang/newGame/data/providers/auth_state_hang.dart';
import 'package:hang/newGame/data/providers/new_game_provider.dart';
import 'package:hang/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class LettersButtons extends StatelessWidget {
  const LettersButtons(
      {Key? key, required this.passedWords, required this.textList})
      : super(key: key);
  final List<dynamic> passedWords;
  final List<dynamic> textList;

  @override
  Widget build(BuildContext context) {
    NewGameProvider _newGameProvider = Provider.of<NewGameProvider>(context);
    return Expanded(
        child: Container(
      color: Colors.grey[850],
      child: Center(
        child: Wrap(
          spacing: 3,
          runSpacing: 0,
          children: _newGameProvider.alphabet
              .map((e) => SizedBox(
                    width: 60.0,
                    child: ElevatedButton(
                      child: MyTextWidget(
                        text: e,
                        size: 30.0,
                      ),
                      onPressed: passedWords.contains(e.toLowerCase())
                          ? null
                          : () {
                              _checkButton(
                                  context: context,
                                  letter: e.toLowerCase(),
                                  textList: textList);
                            },
                    ),
                  ))
              .toList(),
        ),
      ),
    ));
  }

  _checkButton({String? letter, List? textList, context}) {
    NewGameProvider _gameProvider =
        Provider.of<NewGameProvider>(context, listen: false);
    if (textList!.contains(letter)) {
      _gameProvider.addPassedLetter(letter!);

////////////////// is next level check

      bool _myLocalBool = false;
      List<bool> _wordCheck = [];

      for (var element in textList) {
        if (_gameProvider.passedWords!.contains(element)) {
          _wordCheck.add(true);
        } else {
          _wordCheck.add(false);
        }
      }

      if (_wordCheck.contains(false)) {
        _myLocalBool = false;
      } else {
        _myLocalBool = true;
      }
      if (_gameProvider.currentWord! <
          _gameProvider.randomWords!.randomWords!.length - 1) {
        if (_myLocalBool) {
          _gameProvider.endTimer();
          _gameProvider.addPassedTimes(_gameProvider.time);
          FirebaseFirestore.instance.collection("leaderboard").add({
            'login': Provider.of<AuthState>(context, listen: false)
                .auth
                .currentUser!
                .email,
            'score': _gameProvider.passedTimes!.length,
            'time':
                _gameProvider.passedTimes!.map((e) => e).fold(0, (int prev, e) {
              return prev + e;
            })
          });
          AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            borderSide: const BorderSide(color: Colors.green, width: 2),
            buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
            headerAnimationLoop: true,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Congratulations',
            dismissOnBackKeyPress: false,
            desc: 'Move to next word',
            btnCancelOnPress: () {
              Navigator.pop(context);
            },
            btnOkOnPress: () => goToNextWord(_gameProvider),
          ).show();
        }
      } else if (_myLocalBool == true) {
        _gameProvider.endTimer();
        _gameProvider.addPassedTimes(_gameProvider.time);
        FirebaseFirestore.instance.collection("leaderboard").add({
          'login': Provider.of<AuthState>(context, listen: false)
              .auth
              .currentUser!
              .email,
          'score': _gameProvider.passedTimes!.length,
          'time':
              _gameProvider.passedTimes!.map((e) => e).fold(0, (int prev, e) {
            return prev + e;
          })
        });
        AwesomeDialog(
                context: context,
                dialogType: DialogType.SUCCES,
                borderSide: const BorderSide(color: Colors.green, width: 2),
                buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
                headerAnimationLoop: true,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Congratulations - you win!',
                dismissOnBackKeyPress: false,
                desc: 'What do you want to do?',
                btnCancelText: "Close",
                btnOkText: "Start again",
                btnCancelOnPress: () {
                  Navigator.pop(context);
                },
                btnOkOnPress: startAgain(_gameProvider))
            .show();
      }
    } else {
      _gameProvider.mistakes = _gameProvider.mistakes! + 1;
      if (_gameProvider.mistakes! >= 6) {
        _gameProvider.endTimer();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          borderSide: const BorderSide(color: Colors.red, width: 2),
          buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
          headerAnimationLoop: true,
          animType: AnimType.BOTTOMSLIDE,
          title: 'GAME OVER',
          dismissOnBackKeyPress: false,
          btnCancelText: "Restart",
          desc: 'Do you want play again?',
          btnCancelOnPress: () {
            Navigator.pop(context);
          },
          btnOkOnPress: () => startAgain(_gameProvider),
        ).show();
      }
    }
  }

  startAgain(NewGameProvider gameProvider) {
    gameProvider.loading = true;
    gameProvider.init();
  }

  goToNextWord(NewGameProvider gameProvider) {
    gameProvider.currentWord = gameProvider.currentWord! + 1;
    gameProvider.passedWords = [];
    gameProvider.startTimer();
    gameProvider.mistakes = 0;
  }
}
