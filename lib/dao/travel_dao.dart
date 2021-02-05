import 'package:flutter_trip/model/travel_model.dart';
import 'dart:async';
import 'dart:convert';//转换模型需要用到
import 'package:http/http.dart' as http;

///旅拍页接口
var Params = {
  "districtId": -1,
  "groupChannelCode": "RX-OMF",
  "type": null,
  "lat": -180,
  "lon": -180,
  "locatedDistrictId": 0,
  "pagePara": {
    "pageIndex": 1,
    "pageSize": 10,
    "sortType": 9,
    "sortDirection": 0
  },
  "imageCutType": 1,
  "head": {'cid': "09031014111431397988"},
  "contentType": "json"
};
const HOME_URL ='http://www.devio.org/io/flutter_app/json/travel_page.json';
class TravelDao {
  static Future<TravelModel> fetch(String url,String groupChannelCode,int pageIndex,int pageSize) async {
    Map paramsMap = Params['pagePara'];
    paramsMap['pageIndex'] = pageIndex;
    paramsMap['pageSize'] = pageSize;
    Params['groupChannelCode'] = groupChannelCode;


    final response = await http.post(HOME_URL,body:jsonEncode(Params) );
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder(); //fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelModel.fromJson(result);
    }else{
      throw Exception('Failed to load travel_page.json');
    }
  }
}