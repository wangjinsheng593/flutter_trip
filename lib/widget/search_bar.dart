


import 'package:flutter/material.dart';

//首页状态home  首页状态高亮homeLight  搜索状态下的normal
enum SearchBarType { home,normal,homeLight }
class SearchBar extends StatefulWidget {
  //是否禁止搜索
  final bool enabled;
  //左边按钮是否隐藏
  final bool hideLeft;
  final SearchBarType searchBarType;
   //默认提示文案
  final String hint;
  final String defaultText;
  //左边的点击回调
  final void Function() leftButtonClick;
  //右边的点击回调
  final void Function() rightButtonClick;
  //语音按钮的点击回调
  final void Function() speakClick;
  //输入框的点击回调
  final void Function() inputBoxClick;
  //左输入框内容变化的点击回调
  final ValueChanged<String> onChanged;

  const SearchBar(
      {Key key,
        this.enabled = true,
        this.hideLeft,
        this.searchBarType = SearchBarType.normal,
        this.hint,
        this.defaultText,
        this.leftButtonClick,
        this.rightButtonClick,
        this.speakClick,
        this.inputBoxClick,
        this.onChanged}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  //是否显示清除的icon图标
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    if(widget.defaultText != null){
      setState(() {
        _controller.text = widget.defaultText;
      });
    }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal?_genNormalSearch():_genHomeSearch();
  }
  _genNormalSearch(){
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(
            Container(
              padding: EdgeInsets.fromLTRB(6,5,10,5),
              child: widget?.hideLeft ?? false ? null :Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
                size: 26,
              ),
            ),
              widget.leftButtonClick
          ),
          Expanded(
              flex: 1,
              child: _inputBox(),
          ),
          _wrapTap(
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                '搜索',
                style: TextStyle(color: Colors.blue,fontSize: 17),
              ),
            ),
            widget.rightButtonClick
          )
        ],
        
      ),
    );
  }

  _genHomeSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(6,5,5,5),
                child: Row(
                  children: <Widget>[
                    Text(
                        '上海',
                      style: TextStyle(color: _homeFontColor(),fontSize: 14),
                    ),
                    Icon(
                      Icons.expand_more,
                      color:_homeFontColor(),
                      size: 22,
                    ),
                  ],
                   
                )
              ),
              widget.leftButtonClick
          ),
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Icon(
                  Icons.comment,
                  color: _homeFontColor(),
                  size: 26,
                )
              ),
              widget.rightButtonClick
          )
        ],

      ),
    );
  }

  _inputBox(){
    Color inputBoxColor;
    if(widget.searchBarType == SearchBarType.home){
      inputBoxColor = Colors.white;
    }else{
      inputBoxColor = Color(int.parse('0xffEDEDED'));
    }
    return  Container(
      height: 30,
      padding: EdgeInsets.fromLTRB(10, 0, 10,0),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(
          widget.searchBarType == SearchBarType.normal?5:15
        )
      ),
      child: Row(
        children: <Widget>[
          //左边的icon
          Icon(
            Icons.search,
            size: 20,
            color: widget.searchBarType == SearchBarType.normal?Color(0xffA9A9A9):Colors.blue,
          ),
          //输入框
          Expanded(
              flex: 1,
              child: widget.searchBarType == SearchBarType.normal?TextField(
                controller: _controller,
                onChanged: _onChanged,
                autofocus: true,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w300
                ),
                //输入文版的样式
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 5, bottom: 15, right: 5),
                  border: InputBorder.none,
                  hintText: widget.hint ?? '',
                  hintStyle: TextStyle(fontSize: 15),
                ),
              ):_wrapTap(
                Container(
                  child: Text(
                      widget.defaultText,
                      style: TextStyle(fontSize: 13,color:Colors.grey),
                  ),
                ),
                widget.inputBoxClick,
              )
          ),
          !showClear?
              _wrapTap(Icon(
                Icons.mic,
                size: 22,
                color: widget.searchBarType == SearchBarType.normal?Colors.blue:Colors.grey,
              ), widget.speakClick)
              :_wrapTap(
                 Icon(
                   Icons.clear,
                   size: 22,
                   color: Colors.grey,
                 ),(){
                  setState(() {
                    _controller.clear();
                  });
                  _onChanged('');
          }
          )
        ],
      ),
    );
  }

  _wrapTap(Widget child, void Function() callback) {
    return GestureDetector(
      onTap: (){
        if(callback !=null) callback();
      },
      child: child,

    );
  }

   _onChanged(String text) {
    if(text.length>0){
      setState(() {
        showClear = true;
      });
    }else{
      setState(() {
        showClear = false;
      });
    }
    if(widget.onChanged != null){
      widget.onChanged(text);
    }

  }

  _homeFontColor(){
    return widget.searchBarType == SearchBarType.homeLight?Colors.black54:Colors.white;
  }
}
