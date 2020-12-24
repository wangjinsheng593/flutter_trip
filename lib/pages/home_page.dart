

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/widget/local_nav.dart';
const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() =>_HomePageState();
}

class _HomePageState extends  State<HomePage>{
  List _imageUrls = [
    'http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg',
    'https://dimg04.c-ctrip.com/images/700u0r000000gxvb93E54_810_235_85.jpg',
    'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg',
  ];

  double appBarAlpha = 0;
  List<CommonModel> localNavList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }


  _onScroll(offset){
    double alpha = offset/APPBAR_SCROLL_OFFSET;
    //alpha<0 往顶部推, alpha>1 往下拉
    if(alpha<0){
      alpha = 0;
    }else if(alpha>1){
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });

  }

  //http请求，获取首页数据
  loadData() async{
    //http请求方式一：
    // HomeDao.fetch().then((result){
    //   setState(() {
    //     //json.encode方法在dart:convert里面所以需要引入
    //     resultString = json.encode(result);
    //   });
    // }).catchError((e){
    //   setState(() {
    //     resultString = e.toString();
    //   });
    // });
    try{
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        //将object转为字符串
       // resultString = json.encode(model.config);
      });
    }catch(e){
      print(e);
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      //可使元素叠加,前面的元素在下面,后面的元素在上面
        body: Stack(
          children: <Widget>[
            MediaQuery.removePadding(
                removeTop: true,
                context: context,
                ///横向排列
                child:NotificationListener(
                  onNotification: (scrollNotification){
                    if(scrollNotification is ScrollUpdateNotification
                        && scrollNotification.depth ==0  ///第0元素,只检测ListView的滚动
                    ){
                      //滚动且是列表滚动的时候
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                    return ;
                  },
                  child: ListView(
                    children: <Widget>[
                      ///控制大小
                      Container(
                        height: 160,
                        child: Swiper(
                          itemCount: _imageUrls.length,
                          autoplay: true,
                          itemBuilder: (BuildContext context,int index){
                            return Image.network(_imageUrls[index],fit: BoxFit.fill);
                          },
                          pagination: SwiperPagination(),//指示器
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                        child: LocalNav(localNavList: localNavList),
                      ),
                      Container(
                        height: 800,
                        child: ListTile(
                          title: Text('resultString'),
                        ),
                      )
                    ],
                  ),
                )
            ),
            Opacity(
              opacity: appBarAlpha,
              child: Container(
                height: 80,
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text('首页'),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }

}