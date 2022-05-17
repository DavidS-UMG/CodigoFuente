import 'package:flutter/material.dart';
import 'my_charts.dart' as MyCharts;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UMG - COVID-19',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Historial de casos de COVID-19'),
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
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 15.0,
            bottom: 60.0,
            left: 5,
            right: 5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Casos más recientes',
              ),
              Text(
                '36',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 15,
              ),
              Flexible(
                child: MyCharts.MyChart(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {}),
        tooltip: 'Refresh',
        child: const Icon(Icons.rotate_left_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
