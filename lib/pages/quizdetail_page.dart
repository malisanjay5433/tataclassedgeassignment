import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class QuizDetails extends StatefulWidget {
  // final String userOption;
  // const QuizDetails({Key? key, required this.userOption}) : super(key: key);
  @override
  State<QuizDetails> createState() => _QuizDetailsState();
}

class _QuizDetailsState extends State<QuizDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Oh! My Quiz".text.xl4.bold.make(),
      ),
      body: const Hero(tag: '1', child: optionAnswerWidget()),
    );
  }
}

class optionAnswerWidget extends StatelessWidget {
  const optionAnswerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.deepPurple,
          Colors.purple,
          Colors.redAccent,
        ],
      )),
      child: Center(
        child: const Card(
          color: Colors.white,
          child: Center(child: Text("Welcome")),
          elevation: 10,
          // shape: ShapeBorderTween(r),
        ).wh(200, 200),
      ),
    );
  }
}
