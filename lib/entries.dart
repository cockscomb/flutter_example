import 'package:atomparser/atomparser.dart' show AtomFeed;
// ignore: implementation_imports
import 'package:atomparser/src/models/entry.dart' show Entry;
import 'package:flutter/material.dart';

class Entries extends StatelessWidget {
  final AtomFeed feed;

  const Entries({Key key, this.feed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildEntries();
  }

  Widget _buildEntries() {
    return new ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        itemCount: feed.entries.length * 2,
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          return _buildRow(feed.entries[index]);
        });
  }

  Widget _buildRow(Entry entry) {
    return new ListTile(
      title: new Text(entry.title.text),
    );
  }
}
