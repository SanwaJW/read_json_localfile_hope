import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:read_json_localfile_hope/ReadJson.dart';
import 'package:read_json_localfile_hope/ReadJsonWithFutureBuilder.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(HomePage());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  HomePage homePage = HomePage();
  FutureBuilderJson futureBuilderJson = FutureBuilderJson();
  // futureBuilderJson.call()
  int index = 0;
  final tabs = [
    'futureBuilderJson.call()',
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'dbestech',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Title')),
        body: homePage.call(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home1",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home1",
            ),
          ],
          onTap: (currentIndex) {
            setState(() {
              index = currentIndex;
            });
          },
        ),
      ),
    );
  }
}
