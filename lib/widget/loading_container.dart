import 'package:flutter/material.dart';

//加载进度条组件
class LoadingContainer extends StatelessWidget {
  //加载完成之后具体呈现的内容
  final Widget child;
  //组件的状态，外界传进来的
  final bool isLoading;
  //这个组件是否覆盖这个页面也就是是否在child前面
  final bool cover;

  const LoadingContainer({Key key,@required this.isLoading, this.cover=false,@required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return !cover?!isLoading?child:_loadingView
    :Stack(
      children: <Widget>[
        child,
        isLoading?_loadingView:Container(),
      ],

    );
  }
  Widget get _loadingView{
    return Center(
      //进度条
      child: CircularProgressIndicator(),
    );

  }
}
