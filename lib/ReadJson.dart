import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kt_dart/kt.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  final _HomePageState _homePageState = _HomePageState();
  call() {
    return _homePageState.bodyOfContent();
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url = dotenv.get("JSON_URL", fallback: "");
  List _items = [];

  @override
  void initState() {
    super.initState();
    // Call readJson in initState to load data during initialization
    readJson();
  }

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString(url);
    final data = await json.decode(response);

    var records = mutableListFrom(data["items"]);
    var distinct = records.distinctBy((it) => it["id"]);

    List<dynamic> lstDynamic = distinct.cast<dynamic>().asList();

    setState(() {
      _items = lstDynamic;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'db hope',
            ),
          ),
          body: bodyOfContent()
          //dotenv.env['JSON_URL'] ?? 'API_URL not found')
          ),
    );
  }

  bodyOfContent() {
    return Column(
      children: [
        _items.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      // key: ValueKey(_items[index]["id"]),
                      margin: const EdgeInsets.all(10),
                      color: const Color.fromARGB(255, 193, 147, 10),
                      child: ListTile(
                        leading: Text(_items[index]["id"]),
                        title: Text(_items[index]["name"]),
                        subtitle: Text(_items[index]["description"]),
                      ),
                    );
                  },
                ),
              )
            : ElevatedButton(
                onPressed: () {
                  readJson();
                },
                child: const Center(child: Text("Load Json")))
      ],
    );
  }
}
