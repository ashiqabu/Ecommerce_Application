// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ReorderableListScreen extends StatefulWidget {
  const ReorderableListScreen({super.key});

  @override
  State<ReorderableListScreen> createState() => _ReorderableListScreenState();
}

class _ReorderableListScreenState extends State<ReorderableListScreen> {
  final List myList = ['A', 'b', 'C', 'D'];

  void updateMyTiles(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex--;
      }
      final tile = myList.removeAt(oldIndex);
      myList.insert(newIndex, tile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Re-Orderable ListView'),
      ),
      backgroundColor: Colors.white,
      body: ReorderableListView(onReorder: updateMyTiles, children: [
        for (final tile in myList)
          ListTile(
            key: ValueKey(tile),
            title: Text(tile),
          )
      ]),
    );
  }
}
