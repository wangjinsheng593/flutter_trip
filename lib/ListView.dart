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


// class MyApp extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   String showResult = '';
//
//   Future<CommonModel> fetchPost() async {
//     final response = await http
//         .get('http://www.devio.org/io/flutter_app/json/test_common_model.json');
//     Utf8Decoder utf8decoder = Utf8Decoder(); //fix 中文乱码
//     var result = json.decode(utf8decoder.convert(response.bodyBytes));
//     return CommonModel.fromJson(result);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Future与FutureBuilder实用技巧'),
//         ),
//         body: FutureBuilder<CommonModel>(
//             future: fetchPost(),
//             builder:
//                 // ignore: missing_return
//                 (BuildContext context, AsyncSnapshot<CommonModel> snapshot) {
//               switch (snapshot.connectionState) {
//                 case ConnectionState.none:
//                   return new Text('Input a URL to start');
//                 case ConnectionState.waiting:
//                   return new Center(child: new CircularProgressIndicator());
//                 case ConnectionState.active:
//                   return new Text('');
//                 case ConnectionState.done:
//                   if (snapshot.hasError) {
//                     return new Text(
//                       '${snapshot.error}',
//                       style: TextStyle(color: Colors.red),
//                     );
//                   } else {
//                     return new Column(children: <Widget>[
//                       Text('icon:${snapshot.data.icon}'),
//                       Text('statusBarColor:${snapshot.data.statusBarColor}'),
//                       Text('title:${snapshot.data.title}'),
//                       Text('url:${snapshot.data.url}')
//                     ]);
//                   };
//                 }
//             }),
//       ),
//     );
//   }
// }
//
// class CommonModel {
//   final String icon;
//   final String title;
//   final String url;
//   final String statusBarColor;
//   final bool hideAppBar;
//
//   CommonModel(
//       {this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});
//
//   factory CommonModel.fromJson(Map<String, dynamic> json) {
//     return CommonModel(
//       icon: json['icon'],
//       title: json['title'],
//       url: json['url'],
//       statusBarColor: json['statusBarColor'],
//       hideAppBar: json['hideAppBar'],
//     );
//   }
// }


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter之旅',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home:TabNavigator(),
//     );
//   }
// }