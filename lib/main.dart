import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp ({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real numbers have Squares',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Real numbers have Squares'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _number = 0;

  void _onChangeNumber(String value) {
    final int? guess = int.tryParse(value);
    if (guess != null) {
      setState(() {
        _number = guess;
      });
    }
  }

  Widget _buildPopupDialog(BuildContext context) {
    final bool isSquare = _isPerfectSquare(_number);
    final bool isTriangular = _isPerfectSquare(8 * _number + 1);

    if (isSquare && isTriangular) {
      return const AlertDialog(
        title: Text('This is a very good number!'),
        content: Text('Both square and triangular!'),
      );

    } else if (!isSquare && !isTriangular) {
      return const AlertDialog(
        title: Text('This is an useless number!'),
        content: Text('Neither square nor triangular, such a waste!'),
      );

    } else if (isSquare) {
      return const AlertDialog(
        title: Text('This is a good number!'),
        content: Text("It's square!"),
      );

    } else {
      return const AlertDialog(
        title: Text('This is a good number!'),
        content: Text("It's triangular!"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
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
          showDialog<AlertDialog>(
              context: context,
              builder: (BuildContext context) => _buildPopupDialog(context)
          );
        },
        tooltip: 'Check',
        child: const Icon(Icons.auto_awesome),
      ),
    );
  }

  bool _isIntegral(num x) => x is int || x.truncateToDouble() == x;

  bool _isPerfectSquare(num number) => _isIntegral(sqrt(number * number));

}
