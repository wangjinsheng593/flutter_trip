

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/widget/webview.dart';



class SubNav extends StatelessWidget {
  final List<CommonModel> subNavList;

  const SubNav({Key key, @required this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        //circular设置四个角的圆角读书
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (subNavList == null) return null;
    List<Widget> items = [];
    subNavList.forEach((model) {
      items.add(_item(context, model));
    });
    //计算出第一行显示的数量
    int separate = (subNavList.length/2+0.5).toInt();
    return Column(
      children: <Widget>[
        //第一行
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //裁剪，起点是0，终点是separate
          children: items.sublist(0,separate),
        ),
        //第二行，添加上边距
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //裁剪，起点是0终点是separate，终点是subNavList.length
            children: items.sublist(separate,subNavList.length),
          ),
        )
      ],

    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    //平分布局的大小
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=>
                    WebView(url: model.url,statusBarColor: model.statusBarColor,
                      hideAppBar: model.hideAppBar,
                    )
                )
            );
          },
          child: Column(
            children: <Widget>[
              Image.network(
                model.icon,
                width: 18,
                height: 18,
              ),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                  model.title,
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
        ),
    );
  }
}
