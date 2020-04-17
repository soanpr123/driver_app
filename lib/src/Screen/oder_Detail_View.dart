import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetail extends StatefulWidget {
  OrderDetail({Key key, this.code}) : super(key: key);
  String code;
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  ScrollController _controller;
  double magin=0.0;
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }
  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
      magin=MediaQuery.of(context).size.height/100;
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        magin=MediaQuery.of(context).size.height/3.5;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text( widget.code),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0))),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("You have collect")
                ],
              ),
            ),
          ),
          Container(
            margin:EdgeInsets.only(top: magin),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0))),
            child: Column(
              children: <Widget>[
                Container(
                  child: Center(
                    child: Image(

                      width: 100,
                      height: 50,
                      image: NetworkImage(
                          "https://i.ytimg.com/vi/TkAlSDzoD3E/hqdefault.jpg"),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                      itemCount: 50,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(title: Text('Item $index'));
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
