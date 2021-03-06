import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myproject/calculator.dart';
import 'package:myproject/driver_search.dart';
import 'package:myproject/driver_list.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    const MyApp(),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'My Project'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              // style: style,
              onPressed: () {
                MaterialPageRoute materialPageRoute =
                    MaterialPageRoute(builder: (BuildContext buildContext) {
                  return Calculator();
                });
                Navigator.of(context).push(materialPageRoute);
              },
              child: const Text('Caculator'),
            ),
            ElevatedButton(
              // style: style,
              onPressed: () {
                MaterialPageRoute materialPageRoute =
                    MaterialPageRoute(builder: (BuildContext buildContext) {
                  return FindDriver();
                });
                Navigator.of(context).push(materialPageRoute);
              },
              child: const Text('Find driver'),
            ),
            ElevatedButton(
              // style: style,
              onPressed: () {
                MaterialPageRoute materialPageRoute =
                    MaterialPageRoute(builder: (BuildContext buildContext) {
                  return ListDriver();
                });
                Navigator.of(context).push(materialPageRoute);
              },
              child: const Text('List Driver'),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
