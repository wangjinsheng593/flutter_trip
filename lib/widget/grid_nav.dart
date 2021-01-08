

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/widget/webview.dart';

///网格卡片
class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

   //用@required标注gridNavModel参数是必须要的，设置默认值：this.name=''
  const GridNav({Key key,@required this.gridNavModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //column 上下布局
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      //是否裁切
      clipBehavior:Clip.antiAlias ,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if(gridNavModel==null) return items;
    if(gridNavModel.hotel!=null){
      items.add(_gridNavItem(context,gridNavModel.hotel,true));
    }
    if(gridNavModel.flight!=null){
      items.add(_gridNavItem(context,gridNavModel.flight,false));
    }
    if(gridNavModel.travel!=null){
      items.add(_gridNavItem(context,gridNavModel.travel,false));
    }
    return items;
  }
  _gridNavItem(BuildContext context,GridNavItem gridNavItem,bool first){
    List<Widget> items = [];
    items.add(_mainItem(context,gridNavItem.mainItem));
    items.add(_doubleItem(context,gridNavItem.item1,gridNavItem.item2));
    items.add(_doubleItem(context,gridNavItem.item3,gridNavItem.item4));
    List<Widget> exandItems = [];
    items.forEach((item) {
      exandItems.add(Expanded(child: item,flex:1));
    });
    Color startColor = Color(int.parse('0xff'+gridNavItem.startColor));
    Color endColor = Color(int.parse('0xff'+gridNavItem.endColor));
    return Container(
      height: 88,
      margin: first?null:EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        //线性渐变
        gradient: LinearGradient(colors: [startColor,endColor])
      ),
      child: Row(children: exandItems),
    );

  }

  _mainItem(BuildContext context,CommonModel model){
    return _WrapGesture(context,  Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        Image.network(model.icon,fit: BoxFit.contain,
          height: 88,width: 121,
          alignment: AlignmentDirectional.bottomEnd,
        ),
        Container(
           margin: EdgeInsets.only(top: 11),
          child:Text(
            model.title,
            style: TextStyle(fontSize: 14,color: Colors.white),
          ),
        )

      ],
    ), model);
  }

  _doubleItem(BuildContext context,CommonModel topItem,CommonModel bottomItem){
    return Column(
      children: <Widget>[
        //水平方向展开
        Expanded(
            child: _item(context,topItem,true),
        ),
        Expanded(
            child: _item(context,bottomItem,false),
        )

      ],
    );

  }

  _item(BuildContext context,CommonModel item,bool first){
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    ///水平方向撑满
    return FractionallySizedBox(
      ///宽度撑满父容器
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: borderSide,
            bottom: first?borderSide:BorderSide.none,
          )
        ),
        child: _WrapGesture(context,  Center(
          child: Text(
            item.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14,color: Colors.white),
          ),
        ),item)
      ),

    );

  }

  _WrapGesture(BuildContext context,Widget widget,CommonModel model){
    return GestureDetector(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> WebView(
              url: model.url,
              statusBarColor: model.statusBarColor,
              title: model.title,
              hideAppBar: model.hideAppBar,
            )));
      },
      child: widget,
    );

  }
}

