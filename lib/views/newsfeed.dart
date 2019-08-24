import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../model/News.dart';
import 'package:flutter_app/views/details.dart';
import '../utils/constants.dart';
import '../utils/utility.dart';


void main() => runApp(new NewsFeed());

class NewsFeed extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Color main = Color(0xff2F4F4F);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
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
                              ? NewsList(news: snapshot.data)
                              : Center(child: CircularProgressIndicator());
                        },
                      ),
                    )),
              ),
            ],
          )),
    );  }
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

class NewsList extends StatelessWidget {
  final List<News> news;

  NewsList({Key key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = (MediaQuery.of(context).size.height - kToolbarHeight - 24)/2;
    final double width = MediaQuery.of(context).size.width/2;
    return GridView.builder(
      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: width/height,
        crossAxisCount: 2,
      ),
      itemCount: news.length,
      itemBuilder: (BuildContext context,int index) {
        return GestureDetector(
          onTap: (){
            var Id = news[index].id;
            var Title = news[index].title;

            Navigator.push(context,MaterialPageRoute(builder: (context) => NewsDetails(Id),
            ),
            );
          },
          child: Hero(
            tag: news[index].id,
            child: Container(
              margin: EdgeInsets.all(8.0),
              child:Column(
                  children: <Widget>[
                    //Image
                    SizedBox(
                      width: double.infinity,
                      height: 230.0,
                      child: Image.memory(
                        convertToImage(news[index].image),
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        news[index].title,
                        style:TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight:FontWeight.bold,
                        ),
                      ),
                    ),
                  ]
              ),
            ),
          ),
        );
      },
    );

  }
}

