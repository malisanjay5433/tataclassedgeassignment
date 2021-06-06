import 'package:flutter/material.dart';
import 'package:tataclassedgeassignment/pages/countdown_Page.dart';
import 'package:tataclassedgeassignment/pages/home_page.dart';
import 'package:tataclassedgeassignment/pages/video_page.dart';
import 'package:tataclassedgeassignment/route/routes.dart';
import 'package:tataclassedgeassignment/utility/fadepageroute.dart';
import 'package:velocity_x/velocity_x.dart';

class ListOfTopics extends StatefulWidget {
  @override
  State<ListOfTopics> createState() => _TopicListState();
}

class _TopicListState extends State<ListOfTopics> {
  List list = ['Flutter', 'Objective-c', 'Java', 'Swift', 'Kotlin', 'SwiftUI'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TataClassEdge"),
      ),
      // drawer: const Drawer(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 8.0,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: ListTile(
                    title: list[index]
                        .toString()
                        .text
                        .xl3
                        .bold
                        .color(Colors.deepPurple)
                        .make(),
                    onTap: () {
                      // Navigator.push(context,
                      // MaterialPageRoute(builder: (context) => HomePage()));
                      Navigator.of(context)
                          .push(FadePageRoute(widget: HomePage()));
                    },
                  ),
                ),
              );
            }),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class CatalogHeader extends StatefulWidget {
  @override
  State<CatalogHeader> createState() => _CatalogHeaderState();
}

class _CatalogHeaderState extends State<CatalogHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ["TataClassEdge Quiz".text.xl4.bold.color(Colors.white).make()],
    );
  }
}
