
// ConfigModel  config	Object	NonNull
// List<CommonModel> bannerList	Array	NonNull
// List<CommonModel> localNavList	Array	NonNull
// GridNavModel gridNav	Object	NonNull
// List<CommonModel> subNavList	Array	NonNull
// SalesBoxModel salesBox	Object	NonNull

import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/config_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final GridNavModel gridNav;
  final List<CommonModel> subNavList;
  final SalesBoxModel salesBox;

  HomeModel({this.config,this.bannerList,this.localNavList,this.gridNav,this.subNavList,this.salesBox});

}