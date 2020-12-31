

import 'package:flutter/material.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';

///网格卡片
class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

   //用@required标注gridNavModel参数是必须要的，设置默认值：this.name=''
  const GridNav({Key key,@required this.gridNavModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //column 上下布局
    return Column(
      children: _gridNavItems(context),
    );
  }

  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if(gridNavModel==null) return items;
    if(gridNavModel.hotel!=null){

    }
    if(gridNavModel.flight!=null){

    }
    if(gridNavModel.travel!=null){

    }
  }
  _gridNavItem(BuildContext context,GridNavItem gridNavItem,bool first){

  }
}

