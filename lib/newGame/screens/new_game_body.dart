import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hang/newGame/data/providers/auth_state_hang.dart';
import 'package:hang/newGame/data/providers/new_game_provider.dart';
import 'package:hang/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class NewGameBody extends StatelessWidget {
  const NewGameBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewGameProvider gameProvider = Provider.of<NewGameProvider>(context);
    List _alphabet = gameProvider.alphabet;
    List listOfWords = gameProvider.randomWords!.randomWords!;
    int? _currentWord = gameProvider.currentWord;
    List _textList = listOfWords[_currentWord!].toLowerCase().split('');
    int _mistakes = gameProvider.mistakes!;
    List _passedWords = gameProvider.passedWords!;

    return gameProvider.loading!
        ? Container(
            color: Colors.grey[850],
            child: const Center(child: CircularProgressIndicator()),
          )
        : Column(
            children: [
              Container(
                color: Colors.grey[850],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      SvgPicture.asset("assets/svg/hangman.svg"),
                      if (_mistakes > 0)
                        SvgPicture.asset("assets/svg/head.svg"),
                      if (_mistakes > 1) SvgPicture.asset("assets/svg/c.svg"),
                      if (_mistakes > 2) SvgPicture.asset("assets/svg/lA.svg"),
                      if (_mistakes > 3) SvgPicture.asset("assets/svg/rA.svg"),
                      if (_mistakes > 4) SvgPicture.asset("assets/svg/lL.svg"),
                      if (_mistakes > 5) SvgPicture.asset("assets/svg/rL.svg"),
                    ],
                  ),
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 1 / 3,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 1 / 6,
                color: Colors.grey[850],
                child: Center(
                    child: Wrap(
                  spacing: 10.0,
                  children: _textList
                      .map((letter) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MyTextWidget(
                                text:
                                    _passedWords.contains(letter.toLowerCase())
                                        ? letter
                                        : "",
                                size: 20.0,
                              ),
                              Container(
                                width: 30.0,
                                height: 5,
                                color: Colors.white,
                              )
                            ],
                          ))
                      .toList(),
                )),
              ),
              Expanded(
                  child: Container(
                color: Colors.grey[850],
                child: Center(
                  child: Wrap(
                    spacing: 3,
                    runSpacing: 0,
                    children: _alphabet
                        .map((e) => Container(
                              width: 60.0,
                              child: ElevatedButton(
                                child: MyTextWidget(
                                  text: e,
                                  size: 30.0,
                                ),
                                onPressed:
                                    _passedWords.contains(e.toLowerCase())
                                        ? null
                                        : () {
                                            _checkButton(
                                                context: context,
                                                letter: e.toLowerCase(),
                                                textList: _textList);
                                          },
                              ),
                            ))
                        .toList(),
                  ),
                ),
              )),
            ],
          );
  }

  _checkButton({String? letter, List? textList, context}) {
    NewGameProvider _gameProvider =
        Provider.of<NewGameProvider>(context, listen: false);
    if (textList!.contains(letter)) {
      _gameProvider.addPassedLetter(letter!);

////////////////// is next level check

      bool _myLocalBool = false;
      List<bool> _wordCheck = [];

      textList.forEach((element) {
        if (_gameProvider.passedWords!.contains(element)) {
          _wordCheck.add(true);
        } else {
          _wordCheck.add(false);
        }
      });

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
            btnOkOnPress: () {
              _gameProvider.currentWord = _gameProvider.currentWord! + 1;
              _gameProvider.passedWords = [];

              _gameProvider.startTimer();
              _gameProvider.mistakes = 0;
            },
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
          btnOkOnPress: () {
            _gameProvider.loading = true;
            _gameProvider.init();
          },
        ).show();
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
          btnOkOnPress: () {
            _gameProvider.loading = true;
            _gameProvider.init();
          },
        ).show();
      }
    }
  }
}
