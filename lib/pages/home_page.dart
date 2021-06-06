import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:tataclassedgeassignment/model/topics.dart';
import 'package:circular_countdown/circular_countdown.dart';
import 'package:tataclassedgeassignment/route/routes.dart';
import 'package:timer_controller/timer_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final url = "https://api.jsonbin.io/b/604dbddb683e7e079c4eefd3";
  late bool isSelected = false;
  final questions = [
    "Who won 2011 cricket world cup?",
    "Who won 2020 cricket IPL?"
  ];
  final optionsWc = ["England", "Australia", "India", "NewZeland"];
  int delayAmount = 300;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadJSON();
  }

  loadJSON() async {
    await Future.delayed(const Duration(seconds: 2));
    final json = await rootBundle.loadString("assets/topics.json");
    final decodedData = jsonDecode(json);
    var topics = decodedData["topics"];
    var topic =
        List.from(topics).map((topic) => Topics.fromMap(topic)).toList();
    // print(topic);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.purple,
        appBar: AppBar(
          title: "Oh! My Quiz".text.xl4.bold.make(),
        ),
        body: Center(
          child: Container(
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
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        curve: Curves.linear,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent), //BoxDecoration
                          // child:
                          child: ShowUp(
                            child: "Who won 2011 cricket world cup?"
                                .text
                                .xl4
                                .extraBold
                                .color(Colors.white)
                                .make()
                                .py16()
                                .p16(),
                            delay: delayAmount,
                          ),
                        ),
                      ), //Container
                    ),

                    Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      // child: AnimatedContainer(
                      // duration: const Duration(seconds: 2),
                      // curve: Curves.linear,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent),
                          child: const Center(child: Countdowns())),
                      // ), //Container
                    ),
                    //Flexible
                    Flexible(
                      flex: 2,
                      fit: FlexFit.loose,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: InkWell(
                              onTap: () {
                                //
                              },
                              child: Hero(
                                tag: '1',
                                child: optionsWidget(
                                    options: optionsWc,
                                    delayAmount: delayAmount),
                              ),
                            ),
                          ), //Container
                          //Flexible
                        ], //<Widget>[]
                        // mainAxisAlignment: MainAxisAlignment.center,
                      ), //Row
                    ), //Flexible
                    const SizedBox(height: 0)
                  ], //<Widget>[]
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ), //Column
              ) //Padding
              ), //Container
        ) //Container
        ); //Scaffold
  }
}

class _Countdowns {}

class optionsWidget extends StatelessWidget {
  const optionsWidget({
    Key? key,
    required this.options,
    required this.delayAmount,
  }) : super(key: key);

  final List<String> options;
  final int delayAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 16.0,
        ),
        itemCount: options.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(options[index]);
              // Navigator.of(context).push(FadePageRoute(widget: QuizDetails()));
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: ShowUp(
                delay: delayAmount + 300,
                child: Card(
                  elevation: 10,
                  color: Colors.white,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      const Icon(Icons.account_balance_sharp).py32(),
                      options[index].text.xl2.bold.make()
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ShowUp extends StatefulWidget {
  final Widget child;
  final int delay;

  const ShowUp({required this.child, required this.delay});

  @override
  _ShowUpState createState() => _ShowUpState();
}

class _ShowUpState extends State<ShowUp> with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);

    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _animController,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<Animation<Offset>>('_animOffset', _animOffset));
  }
}

class Countdowns extends StatefulWidget {
  const Countdowns({
    Key? key,
  }) : super(key: key);

  @override
  __CountdownsState createState() => __CountdownsState();
}

class __CountdownsState extends State<Countdowns> {
  late final TimerController _controller;
  int isFinished = 0;
  final optionsIpl = ["Mumbai", "Chennai", "RCB", "DC"];

  get delayAmount => null;
  @override
  void initState() {
    super.initState();
    _controller = TimerController.seconds(5);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.start();
    return TimerControllerListener(
      controller: _controller,
      listenWhen: (previousValue, currentValue) =>
          previousValue.status != currentValue.status,
      listener: (context, timerValue) {
        // ignore: avoid_print
        print("Timer finished ${timerValue.status}");
        if (timerValue.status == TimerStatus.finished) {
          optionsWidget(options: optionsIpl, delayAmount: 200);
        }
        setState(() {});
        // Navigator.popUntil(context, (route) => '')
      },
      child: TimerControllerBuilder(
        controller: _controller,
        builder: (context, timerValue, _) {
          Color? timerColor;
          switch (timerValue.status) {
            case TimerStatus.running:
              timerColor = Colors.green;
              break;
            default:
          }
          return Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            spacing: 40,
            runSpacing: 40,
            children: <Widget>[
              CircularCountdown(
                diameter: 150,
                countdownTotal: _controller.initialValue.remaining,
                countdownRemaining: timerValue.remaining,
                countdownCurrentColor: timerColor,
                strokeWidth: 5,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                ),
              ),
              if (isFinished == true)
                optionsWidget(
                  options: optionsIpl,
                  delayAmount: 200,
                )
            ],
          );
        },
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  const _ActionButton({
    required this.title,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String title;

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.onPressed,
      child: Text(widget.title),
    );
  }
}

// class _StatusSnackBar extends SnackBar {
//   _StatusSnackBar(
//     String title,
//   ) : super(
//           content: Text(title),
//           duration: const Duration(seconds: 1),
//         );
// }
