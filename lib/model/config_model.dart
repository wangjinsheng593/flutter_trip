
// ConfigModel config	Object	NonNull
// List<CommonModel> bannerList	Array	NonNull
// List<CommonModel> localNavList	Array	NonNull
// GridNavModel gridNav	Object	NonNull
// List<CommonModel> subNavList	Array	NonNull
// SalesBoxModel salesBox	Object	NonNull

class ConfigModel {
  final String searchUrl;

  ConfigModel({this.searchUrl});

  factory ConfigModel.fromJson(Map<String,dynamic>json){
    return ConfigModel(searchUrl:json['searchUrl']);
  }

}