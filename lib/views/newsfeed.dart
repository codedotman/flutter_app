import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../model/News.dart';
import '../utils/constants.dart';
import '../widgets/newslist.dart';


void main() => runApp(new NewsFeed());

class NewsFeed extends StatelessWidget{
  final bool boolTrue = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final Color main = Color(0xff2F4F4F);
    return MaterialApp(
        home: Scaffold(
        appBar: boolTrue ? AppBar( ) : null,
        body: new SafeArea(
            child: new Column(
              children: [
                new Expanded(
                  flex: 1,
                  child: new Container(
                     width: width,
                     color: main,
                      child: new GestureDetector(
                        child: new FutureBuilder<List<News>>(
                          future: fetchNews(),
                          builder: (BuildContext context,AsyncSnapshot<List<News>> snapshot) {
                            if (snapshot.hasError) print(snapshot.error);

                            return snapshot.hasData
                                ? NewsList(snapshot.data)
                                : Center(child: CircularProgressIndicator());
                          },
                        ),
                      )),
               ),
              ],
            )),
      ));  }
  }

Future<List<News>> fetchNews() async {
  String url= Constant.list_url;
  final response = await http.get(url);
  return compute(parsenews, response.body);
}

List<News> parsenews(String responsebody) {
  final parsed = json.decode(responsebody).cast<Map<String,dynamic>>();
  return parsed.map<News>((json) => new News.fromJson(json))
      .toList();
}

