import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dart_numerics/dart_numerics.dart' as numerics;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real numbers have Squares',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Real numbers have Squares'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _number = 0;

  void _onChangeNumber(String value) {
    var guess = int.tryParse(value);
    if (guess != null) {
      setState(() {
        _number = guess;
      });
    }
  }

  Widget _buildPopupDialog(BuildContext context) {
    var is_square = numerics.isPerfectSquare(_number);
    var is_triangular = numerics.isPerfectSquare(8 * _number + 1);

    if (is_square && is_triangular) {
      return new AlertDialog(
        title: new Text("This is a very good number!"),
        content: new Text("Both square and triangular!"),
      );

    } else if (!is_square && !is_triangular) {
      return new AlertDialog(
        title: new Text("This is an useless number!"),
        content: new Text("Neither square nor triangular, such a waste!"),
      );

    } else if (is_square) {
      return new AlertDialog(
        title: new Text("This is a good number!"),
        content: new Text("It's square!"),
      );

    } else {
      return new AlertDialog(
        title: new Text("This is a good number!"),
        content: new Text("It's triangular!"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Please input your number here',
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: _onChangeNumber,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+$')),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialog(context)
          );
        },
        tooltip: 'Check',
        child: Icon(Icons.auto_awesome),
      ),
    );
  }
}
