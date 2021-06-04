import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:tataclassedgeassignment/model/topics.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final url = "https://api.jsonbin.io/b/604dbddb683e7e079c4eefd3";
  late bool isSelected = false;
  final options = ["England", "Australia", "India", "NewZeland"];
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
                                .p16(),
                            delay: delayAmount,
                          ),
                        ),
                      ), //Container
                    ), //Flexible
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: InkWell(
                              onTap: () {
                                if (isSelected == true) {
                                  isSelected = !isSelected;
                                  print("tapped");
                                  setState(() {
                                    isSelected = false;
                                  });
                                } else {
                                  print("untapped");
                                  setState(() {
                                    isSelected = true;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1.0,
                                    mainAxisSpacing: 16.0,
                                    crossAxisSpacing: 16.0,
                                  ),
                                  itemCount: options.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        print(options[index]);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(3),
                                        child: ShowUp(
                                          delay: delayAmount + 300,
                                          child: Card(
                                            elevation: 10,
                                            color: Colors.white,
                                            shadowColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                const Icon(Icons
                                                        .account_balance_sharp)
                                                    .py32(),
                                                options[index]
                                                    .text
                                                    .xl2
                                                    .bold
                                                    .make()
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ), //Container
                          //Flexible
                        ], //<Widget>[]
                        // mainAxisAlignment: MainAxisAlignment.center,
                      ), //Row
                    ), //Flexible
                    const SizedBox(
                      height: 20,
                    )
                  ], //<Widget>[]
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ), //Column
              ) //Padding
              ), //Container
        ) //Container
        ); //Scaffold
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
