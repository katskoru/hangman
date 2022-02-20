import 'package:flutter/material.dart';

class NewGame extends StatelessWidget {
  const NewGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.reply_outlined)),
      ),
    );
  }
}
