// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'covid_chart.dart' as covidchart;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demostración',
      //theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Proyecto integrador'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({required this.title});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _parseAndlaunch(String str) async {
    if (!await launchUrl(Uri.parse(str))) throw 'Error desconocido! (${Uri.parse(str)})';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        toolbarHeight: 0,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 15.0,
            bottom: 15.0,
            left: 5,
            right: 5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  _parseAndlaunch('https://github.com/DavidS-UMG');
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.code,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Código fuente'),
                  ],
                ),
              ),
              Flexible(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: covidchart.MyChart(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () => setState(() => covidchart.mexico = !covidchart.mexico),
                    icon: covidchart.mexico ? Icon(Icons.location_on_outlined): Icon(Icons.location_on),
                  ),
                  IconButton(
                    onPressed: () => setState(() => covidchart.cases = !covidchart.cases),
                    icon: Icon(
                      covidchart.cases ? Icons.insert_chart_outlined_rounded : Icons.insert_chart_rounded,
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => covidchart.zoom = !covidchart.zoom),
                    icon: Icon(
                      covidchart.zoom ? Icons.zoom_out : Icons.zoom_in,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
