import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];

class WebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;


   WebView({this.url, this.statusBarColor, this.title, this.hideAppBar, this.backForbid = false});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final webviewReference = new FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError>  _onHttpError;
  bool exiting = false;

  @override
  void initState() {
    super.initState();
    //防止页面重新打开，先调用关闭的方法
    webviewReference.close();
    //监听页面url的变化，并返回字符串的url
    _onUrlChanged = webviewReference.onUrlChanged.listen((String url) {

    });
    //监听页面导航栏状态发生改变
    _onStateChanged = webviewReference.onStateChanged.listen((WebViewStateChanged state) {
      switch(state.type){
        case WebViewState.startLoad:
          if(_isToMain(state.url) && !exiting){
            //禁止返回
            if(widget.backForbid){
              //重新加载当前页面
              webviewReference.launch(widget.url);
            }else{
              //返回上页
              Navigator.pop(context);
              exiting = true;
            }

          }
          break;
        default:
          break;
      }
    });
    //网络发生错误的监听
    _onHttpError = webviewReference.onHttpError.listen((WebViewHttpError error) {
      print(error);
    });
  }
  _isToMain(String url){
    bool contain = false;
    for(final value in CATCH_URLS){
      //url?判断url是否为空，如果为空则不调用后面的方法
      //true??false，类似三元表达式，为true则使用前面的值，不然就使用后面的值
      if(url?.endsWith(value) ?? false){
        contain = true;
        break;
      }
    }
    return contain;
  }

  @override
  void dispose() {

    //销毁页面，同时也要取消监听
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    //注销插件
    webviewReference.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if(statusBarColorStr == 'ffffff'){
      backButtonColor = Colors.black;
    }else{
      backButtonColor = Colors.white;
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          //将字符串的颜色转换
          _appBar(
              Color(int.parse('0xff'+statusBarColorStr)),
              backButtonColor
          ),
          //撑满一行
          Expanded(
              child: WebviewScaffold(
                url: widget.url,
                withZoom: true,//是否可以缩放
                withLocalStorage: true,//是否取用本地存储缓存
                hidden: true,//url地址加载出来之前是隐藏
                //在url加载的过程中显示的东西。比如loading
                initialChild:Container(
                  color: Colors.white,
                  child: Center(
                    child: Text('Waiting...'),
                  ),

                ) ,

              )
          )
        ],
      ),
    );
  }
  _appBar(Color backgroundColor,Color backButtonColor){
    if(widget.hideAppBar??false){
      return Container(
        color: backgroundColor,
        height: 30,
      );
    };
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0,40, 0, 10),
      //FractionallySizedBox撑满整个屏幕的宽度
      child: FractionallySizedBox(
        widthFactor: 1,//撑满
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            //绝对定位
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                    widget.title??'',
                    style: TextStyle(color: backButtonColor,fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );

  }
}
