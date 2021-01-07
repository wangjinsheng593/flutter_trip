

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/widget/webview.dart';


///底部卡片入口
class SalesBox extends StatelessWidget {
  final SalesBoxModel salesBox;

  const SalesBox({Key key, @required this.salesBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child:_items(context),
    );
  }

  _items(BuildContext context) {
    if (salesBox == null) return null;
    List<Widget> items = [];
    items.add(_doubleItem(context,salesBox.bigCard1,salesBox.bigCard2,true,false));
    items.add(_doubleItem(context,salesBox.smallCard1,salesBox.smallCard2,true,false));
    items.add(_doubleItem(context,salesBox.smallCard3,salesBox.smallCard4,false,true));

    return Column(
      children: <Widget>[
        Container(
          height: 44,
          margin: EdgeInsets.only(left: 10),
          decoration:  BoxDecoration(
            border: Border(bottom: BorderSide(width: 1,color: Color(0xfff2f2f2)))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.network(
                  salesBox.icon,
                height: 15,
                //图片填满
                fit: BoxFit.fill,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
                margin: EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  //渐变色设置
                  gradient: LinearGradient(colors: [
                    //开始颜色，终止颜色
                    Color(0xffff4e63),
                    Color(0xffff6cc9),
                  ],
                    //渐变色开始的位置
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                ),
                //设置点击效果
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>WebView(url: salesBox.moreUrl,title: '更多活动'),
                      )
                    );
                  },
                ),
              )

            ],
          ),
        )
      ],
    );
  }

  Widget _doubleItem(BuildContext context, CommonModel leftCard, CommonModel rightCard,bool big,bool last){
    return Row(
      //排列方式
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _item(context, leftCard,true,last),
        _item(context, rightCard,false,last)
      ],

    );
  }

  Widget _item(BuildContext context, CommonModel model,bool left,bool last) {
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
