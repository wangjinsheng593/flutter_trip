

import 'package:flutter/material.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';

class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

   //用@required标注gridNavModel参数是必须要的，设置默认值：this.name=''
  const GridNav({Key key,@required this.gridNavModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

