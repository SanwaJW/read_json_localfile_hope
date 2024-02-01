import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kt_dart/kt.dart';
import 'package:read_json_localfile_hope/ItemDataModel.dart';

class FutureBuilderJson extends StatefulWidget {
  FutureBuilderJson({super.key});
  final _FutureBuilderJsonState _futureBuilderJsonState =
      _FutureBuilderJsonState();
  call() {
    return _futureBuilderJsonState.futureOfList();
  }

  @override
  State<FutureBuilderJson> createState() => _FutureBuilderJsonState();
}

class _FutureBuilderJsonState extends State<FutureBuilderJson> {
  String url = dotenv.get("JSON_URL", fallback: "");
  String imageUrl =
      'https://www.shutterstock.com/shutterstock/photos/1201640329/display_1500/stock-vector-hope-vector-hope-typography-motivational-word-1201640329.jpg';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: futureOfList()),
    );
  }

  Future<List<ItemDataModel>> readJsonData() async {
    final String response = await rootBundle.loadString(url);
    final data = await json.decode(response);
    // List<dynamic> records = data["items"] as List<dynamic>;
    var records = mutableListFrom(data["items"]);
    var distinct = records.distinctBy((it) => it["id"]);
    List<dynamic> lstDynamic = distinct.cast<dynamic>().asList();
    return lstDynamic.map((e) => ItemDataModel.fromJson(e)).toList();
  }

  futureOfList() {
    return FutureBuilder(
        future: readJsonData(),
        builder: (context, items) {
          if (items.hasError) {
            return Center(
              child: Text('$items.error'),
            );
          } else if (items.hasData) {
            List<ItemDataModel>? i = items.data;
            return ListView.builder(
              itemCount: i?.length,
              itemBuilder: (context, index) {
                return Card(
                  // key: ValueKey(_items[index]["id"]),
                  margin: const EdgeInsets.all(10),
                  color: const Color.fromARGB(255, 193, 147, 10),
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        imageUrl =
                            'https://paisaboltahai.rbi.org.in/images/500-note-front.png';
                      });
                    },
                    leading: Text(i?[index].id ?? "DefaultValue"),
                    title: Text(i?[index].name ?? "DefaultValue"),
                    subtitle: Text(i?[index].description ?? "DefaultValue"),
                    trailing: Image(image: NetworkImage(imageUrl)),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
