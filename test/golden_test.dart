import 'package:flutter/material.dart';
import 'package:golden_tester/golden_tester.dart';

void main() {
  testGolden(
    'verifica _DefaultFlutterPage',
    () => _DefaultFlutterPage(
      title: 'Default Flutter Page',
    ),
  );
}

class _DefaultFlutterPage extends StatefulWidget {
  _DefaultFlutterPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _DefaultFlutterPageState createState() => _DefaultFlutterPageState();
}

class _DefaultFlutterPageState extends State<_DefaultFlutterPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
