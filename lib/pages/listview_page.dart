import 'package:flutter/material.dart';

class List extends StatefulWidget {
  @override
  State<List> createState() => _ListState();
}

class _ListState extends State<List> {
  List list = ['Java', 'Flutter', 'Swift', 'Kotlin'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TataClassEdge"),
      ),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(list[index]),
            );
          }),
    );
  }
}
