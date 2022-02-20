import 'package:flutter/material.dart';
import 'package:hang/newGame/data/providers/new_game_provider.dart';
import 'package:hang/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class NewGameBody extends StatelessWidget {
  const NewGameBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List _alphabet = Provider.of<NewGameProvider>(context).alphabet;
    String _example = "Example";
    List _textList = _example.split('');
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 1 / 3,
          color: Colors.green,
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
                          text: e,
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
                          print(e);
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
