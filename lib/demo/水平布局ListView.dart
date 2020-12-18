import 'package:flutter/material.dart';
// import 'package:flutter_trip/navigator/tab_navigator.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';

void main() => runApp(MyApp());
const CITY_NAMES = [ '北京', '上海', '广州', '深圳', '杭州', '苏州', '成都', '武汉', '郑州', '洛阳', '厦门', '青岛', '拉萨' ];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Basic List';

    return MaterialApp(
      title: title,
      home: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Container(
            height: 200,
            child: ListView(
              ///滚动的方向，默认上下排列，也就是垂直
              scrollDirection: Axis.horizontal, ///这是水平排列
              children: _buildList(),
            ),
          )
      ),
    );
  }

  List<Widget> _buildList() {
    return CITY_NAMES.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      //height: 80,
      width: 160,
      margin: EdgeInsets.only(right: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}


