import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shortlink App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Shortlink App'),
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
  TextEditingController _linkEditingController = TextEditingController();
  String result = "-";

  void _getShortLink() async {
    var endPointUrl = 'https://shortlink.api.fayas.me/';
    Map<String, String> queryParams = {
      'query': _linkEditingController.text,
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = Uri.parse(endPointUrl + '?' + queryString);

    await http.get(requestUrl).then((response) {
      Map<String, dynamic> body = jsonDecode(response.body);

      setState(() {
        result = "Chilp it : " +
            body['chilp.it'] +
            "\n" +
            "Click RU : " +
            body['click.ru'];
      });
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
                'Please insert link :',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _linkEditingController,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      result,
                      style: TextStyle(color: Colors.red, fontSize: 18.0),
                    )),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: _getShortLink, label: Text('Generate')));
  }
}
