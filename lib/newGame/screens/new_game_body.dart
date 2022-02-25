import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hang/newGame/data/providers/new_game_provider.dart';
import 'package:hang/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class NewGameBody extends StatelessWidget {
  const NewGameBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List _alphabet = Provider.of<NewGameProvider>(context).alphabet;
    List listOfWords =
        Provider.of<NewGameProvider>(context).randomWords!.randomWords!;
    int? _currentWord = Provider.of<NewGameProvider>(context).currentWord;
    List _textList = listOfWords[_currentWord!].split('');
    int _mistakes = Provider.of<NewGameProvider>(context).mistakes!;
    return listOfWords.first == ""
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
                                text: "",
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
                              child: MyTextWidget(
                                text: e,
                                size: 30.0,
                              ),
                              onPressed: () {
                                Provider.of<NewGameProvider>(context,
                                        listen: false)
                                    .mistakes = Provider.of<NewGameProvider>(
                                            context,
                                            listen: false)
                                        .mistakes! +
                                    1;
                                if (_mistakes > 5) {
                                  Provider.of<NewGameProvider>(context,
                                          listen: false)
                                      .mistakes = 0;
                                }
                              },
                            ),
                          ))
                      .toList(),
                ),
              )),
            ],
          );
  }
}
