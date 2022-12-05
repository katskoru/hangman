import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hang/newGame/data/providers/new_game_provider.dart';
import 'package:hang/widgets/letters_buttons.dart';
import 'package:hang/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class NewGameBody extends StatelessWidget {
  const NewGameBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewGameProvider gameProvider = Provider.of<NewGameProvider>(context);

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
              LettersButtons(passedWords: _passedWords, textList: _textList),
            ],
          );
  }
}
