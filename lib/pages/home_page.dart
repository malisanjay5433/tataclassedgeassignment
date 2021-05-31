import 'dart:convert';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadJSON();
  }

  loadJSON() async {
    await Future.delayed(const Duration(seconds: 2));
    final json = await rootBundle.loadString("assets/topics.json");
    final decodedData = jsonDecode(json);
    var topics = decodedData["topics"];
    var topic =
        List.from(topics).map((topic) => Topics.fromMap(topic)).toList();
    print(topic);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.deepPurple,
      body: Container(
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
        padding: Vx.m32,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [CatalogHeader().py(32)],
        ),
      ),
      // drawer: MyDrawer(),
    );
  }
}

class CatalogHeader extends StatefulWidget {
  @override
  State<CatalogHeader> createState() => _CatalogHeaderState();
}

class _CatalogHeaderState extends State<CatalogHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "TataClassEdge".text.xl5.bold.color(Colors.white).make(),
        "Treding Topics".text.xl.color(Colors.orange).make()
      ],
    );
  }
}

class TopicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: TopicModel.topic.length,
      itemBuilder: (context, index) {
        return ItemWidget(
          topic: TopicModel.topic[index],
        );
      },
    );
  }
}

class ItemWidget extends StatelessWidget {
  final Topics topic;
  const ItemWidget({Key? key, required this.topic}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(topic.name),
      subtitle: Text(topic.desc),
    );
  }
}
