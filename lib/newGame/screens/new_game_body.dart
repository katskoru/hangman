import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hang/newGame/data/providers/new_game_provider.dart';
import 'package:hang/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class NewGameBody extends StatelessWidget {
  const NewGameBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List _alphabet = Provider.of<NewGameProvider>(context).alphabet;
    List listOfWords =
        Provider.of<NewGameProvider>(context).randomWords!.randomWords!;
    int? _currentWord = Provider.of<NewGameProvider>(context).currentWord;
    List _textList = listOfWords[_currentWord!].toLowerCase().split('');
    int _mistakes = Provider.of<NewGameProvider>(context).mistakes!;
    List _passedWords = Provider.of<NewGameProvider>(context).passedWords!;

    return Provider.of<NewGameProvider>(context).loading!
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Container(
                color: Colors.grey[900],
                child: Stack(
                  children: [
                    SvgPicture.asset("assets/svg/hangman.svg"),
                    if (_mistakes > 0) SvgPicture.asset("assets/svg/head.svg"),
                    if (_mistakes > 1) SvgPicture.asset("assets/svg/c.svg"),
                    if (_mistakes > 2) SvgPicture.asset("assets/svg/lA.svg"),
                    if (_mistakes > 3) SvgPicture.asset("assets/svg/lL.svg"),
                    if (_mistakes > 4) SvgPicture.asset("assets/svg/rA.svg"),
                    if (_mistakes > 5) SvgPicture.asset("assets/svg/rL.svg"),
                  ],
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 1 / 3,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 1 / 6,
                color: Colors.yellow,
                child: Center(
                    child: Wrap(
                  spacing: 10.0,
                  children: _textList
                      .map((e) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MyTextWidget(
                                text: _passedWords.contains(e.toLowerCase())
                                    ? e
                                    : "#$e",
                                size: 20.0,
                              ),
                              Container(
                                width: 30.0,
                                height: 5,
                                color: Colors.black,
                              )
                            ],
                          ))
                      .toList(),
                )),
              ),
              Expanded(
                  child: Center(
                child: Wrap(
                  spacing: 3,
                  runSpacing: 0,
                  children: _alphabet
                      .map((e) => Container(
                            width: 60.0,
                            child: ElevatedButton(
                              // step 1
                              child: MyTextWidget(
                                text: e,
                                size: 30.0,
                              ),
                              onPressed: _passedWords.contains(e.toLowerCase())
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
              )),
            ],
          );
  }

  _checkButton({String? letter, List? textList, context}) {
    if (textList!.contains(letter)) {
      Provider.of<NewGameProvider>(context, listen: false)
          .addPassedLetter(letter!);

////////////////// is next level check

      bool _myLocalBool = false;
      List<bool> _wordCheck = [];

      textList.forEach((element) {
        if (Provider.of<NewGameProvider>(context, listen: false)
            .passedWords!
            .contains(element)) {
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
      if (Provider.of<NewGameProvider>(context, listen: false).currentWord! <
          Provider.of<NewGameProvider>(context, listen: false)
                  .randomWords!
                  .randomWords!
                  .length -
              1) {
        if (_myLocalBool) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            borderSide: BorderSide(color: Colors.green, width: 2),
            buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
            headerAnimationLoop: true,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Congratulations',
            dismissOnBackKeyPress: false,
            desc: 'Move to next word',
            btnCancelOnPress: () {
              Navigator.pop(context);
            },
            btnOkOnPress: () {
              Provider.of<NewGameProvider>(context, listen: false).currentWord =
                  Provider.of<NewGameProvider>(context, listen: false)
                          .currentWord! +
                      1;
              Provider.of<NewGameProvider>(context, listen: false).passedWords =
                  [];
            },
          ).show();
        }
      } else if (_myLocalBool == true) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          borderSide: BorderSide(color: Colors.green, width: 2),
          buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
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
            Provider.of<NewGameProvider>(context, listen: false).loading = true;
            Provider.of<NewGameProvider>(context, listen: false).init();
          },
        ).show();
        // show end game dialog -> close i start again (new game plus)
      }

      ////////////////
    } else {
      Provider.of<NewGameProvider>(context, listen: false).mistakes =
          Provider.of<NewGameProvider>(context, listen: false).mistakes! + 1;
      if (Provider.of<NewGameProvider>(context, listen: false).mistakes! >= 6) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          borderSide: BorderSide(color: Colors.red, width: 2),
          buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
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
            Provider.of<NewGameProvider>(context, listen: false).loading = true;
            Provider.of<NewGameProvider>(context, listen: false).init();
          },
        ).show();
      }
    }
  }
}
