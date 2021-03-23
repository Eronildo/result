import 'package:flutter/material.dart';
import 'package:result/result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

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
        onPressed: () {
          final result = _increment(_counter);
          if (result.isSuccess()) {
            setState(() {
              _counter++;
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Counter cannot be bigger than 9")));
          }
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Result<IncrementException, int> _increment(int currentCount) {
    if (currentCount + 1 == 10) {
      return Error(IncrementException("counter can't be bigger than 9"));
    } else {
      return Success(currentCount++);
    }
  }
}

class IncrementException implements Exception {
  final String message;

  IncrementException(this.message);
}
