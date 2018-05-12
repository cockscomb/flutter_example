import 'dart:async';

import 'package:atomparser/atomparser.dart' show AtomFeed, parse;
import 'package:flutter/material.dart';
import 'package:flutter_example/entries.dart';
import 'package:http/http.dart' as http;

Future<AtomFeed> fetchAtom(String atomUrl) async {
  var atomXml = await http.read(atomUrl);
  return parse(atomXml);
}

class Feed extends StatelessWidget {
  final String url;

  const Feed({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var entries = new FutureBuilder<AtomFeed>(
        future: fetchAtom(url),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var feed = snapshot.data;
            return new Entries(feed: feed);
          } else if (snapshot.hasError) {
            return new Text("${snapshot.error}");
          }
          return new CircularProgressIndicator();
        });

    return new Scaffold(
      appBar: new AppBar(title: new Text("Feed")),
      body: entries,
    );
  }
}
