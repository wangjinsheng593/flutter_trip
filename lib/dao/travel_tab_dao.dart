import 'package:flutter_trip/model/travel_tab_model.dart';
import 'dart:async';
import 'dart:convert';//转换模型需要用到
import 'package:http/http.dart' as http;

///旅拍类别接口
const HOME_URL ='http://www.devio.org/io/flutter_app/json/travel_page.json';
class TravelTabDao {
  static Future<TravelTabModel> fetch() async {
    final response = await http.get(HOME_URL);
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder(); //fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelTabModel.fromJson(result);
    }else{
      throw Exception('Failed to load travel_page.json');
    }
  }
}