import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../model/News.dart';
import '../utils/utility.dart';

class NewsDetail extends StatelessWidget{
  final News news;
  NewsDetail(this.news);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300.0,
              child: Image.memory(convertToImage(news.image),fit: BoxFit.fill,),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: DateDisplay(dateTime: news.createdAt,),),
            _Title(title:news.title),
            Body(body: news.description,),
          ],
        )
    );
  }

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
