import 'package:flutter_trip/model/search_model.dart';
import 'dart:async';
import 'dart:convert';//转换模型需要用到
import 'package:http/http.dart' as http;

const HOME_URL ='http://www.devio.org/io/flutter_app/json/home_page.json';

class SearchDao {
  static Future<SearchModel> fetch(String url,String text) async {
    final response = await http.get(url);
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder(); //fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      SearchModel model = SearchModel.fromJson(result);
      model.keyword = text;
      return model;
    }else{
      throw Exception('Failed to load home_page.json');
    }
  }
}