import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';

import '../model/News.dart';
import '../utils/constants.dart';
import '../utils/utility.dart';



class NewsDetails extends StatelessWidget{

  NewsDetails(this.newsID);
  final int newsID;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Color main = Color(0xff2F4F4F);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Column(
            children: [
               Expanded(
                flex: 1,
                child: Container(
                    width: width,
                    color: main,
                    child: GestureDetector(
                      child: FutureBuilder<News>(
                        future: fetchNewsDetails(newsID),
                        builder: (BuildContext context,AsyncSnapshot<News> snapshot) {
                          if (snapshot.hasError) print(snapshot.error);

                          return snapshot.hasData
                          ? SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    height: 300.0,
                                    child: Image.memory(convertToImage(snapshot.data.image),fit: BoxFit.fill,),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: DateDisplay(dateTime: snapshot.data.createdAt,),),
                                  _Title(title:snapshot.data.title),
                                  Body(body: snapshot.data.description,),
                                ],
                              )
                          ) : Center(child: CircularProgressIndicator());
                        },
                      ),
                    )),
              ),
            ],
          )),
    );
  }

}

Future<News> fetchNewsDetails(int newsId) async {
  String url= Constant.details_url + "$newsId";
  final response = await http.get(url);

  if(response.statusCode == 200){
    return News.fromJson(json.decode(response.body));
  }
  return null;

}

class DateDisplay extends StatelessWidget{
  final String dateTime;

  DateDisplay({@required this.dateTime}):assert(dateTime != null);

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.all(14.0),
      child: Text(formatDate(dateTime),
        style: TextStyle(
          color: Colors.white,
        ),),
    );
  }
}

class _Title extends StatelessWidget{
  final String title;

  _Title({@required this.title}):assert(title != null);

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.all(14.0),
      child: Text(title,
        style:TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class Body extends StatelessWidget{
  final String body;

  Body({@required this.body}):assert(body != null);

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.all(14.0),
      child: Text(body,
        style:TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
            color: Colors.white
        ),
        softWrap: true,
      ),
    );
  }
}



