import 'package:driverapp/src/Screen/oder_Detail_View.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<double> headerNegativeOffset = ValueNotifier<double>(0);
  final ValueNotifier<bool> appbarShadow = ValueNotifier<bool>(false);
  GlobalKey<RefreshIndicatorState> _refreshKey =
  new GlobalKey<RefreshIndicatorState>();
  final double maxHeaderHeight = 250.0;
  final double minHeaderHeight = 56.0;
  final double bodyContentRatioMin = .8;
  final double bodyContentRatioMax = 1.0;
  String tile = "";

  ///must be between min and max values of body content ratio.
  final double bodyContentRatioParallax = .9;

  @override
  void dispose() {
    headerNegativeOffset.dispose();
    appbarShadow.dispose();
    super.dispose();
  }

  List name = [
    "abc",
    "bc2",
    "abc3",
    "abc4",
    "abc5",
    "abc6",
    "abc7",
    "abc8",
    "abc9",
    "âbc10"
  ];
  List desition = [
    "abc",
    "bc2",
    "abc3",
    "abc4",
    "abc5",
    "abc6",
    "abc7",
    "abc8",
    "abc9",
    "âbc10"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //just for status bar color
      body: Stack(
        children: <Widget>[
          Stack(children: [
            Container(
                child: ValueListenableBuilder<double>(
                    valueListenable: headerNegativeOffset,
                    builder: (context, offset, child) {
                      return Transform.translate(
                        offset: Offset(0, offset * -1),
                        child: SizedBox(
                          height: maxHeaderHeight,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30.0),
                                        bottomRight: Radius.circular(30.0))),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Abc"),
                                    Text("Abc"),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    })),
            NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                if (notification.extent == bodyContentRatioMin) {
                  appbarShadow.value = false;
                  headerNegativeOffset.value = 0;
                  tile = "";
                } else if (notification.extent == bodyContentRatioMax) {
                  appbarShadow.value = true;
                  headerNegativeOffset.value =
                      maxHeaderHeight - minHeaderHeight;
                  tile = "abc";
                } else {
                  double newValue = (maxHeaderHeight - minHeaderHeight) -
                      ((maxHeaderHeight - minHeaderHeight) *
                          ((bodyContentRatioParallax - (notification.extent)) /
                              (bodyContentRatioMax -
                                  bodyContentRatioParallax)));
                  appbarShadow.value = false;
                  tile = "";
                  if (newValue >= maxHeaderHeight - minHeaderHeight) {
                    appbarShadow.value = true;
                    newValue = maxHeaderHeight - minHeaderHeight;
                    tile = "";
                  } else if (newValue < 0) {
                    appbarShadow.value = false;
                    newValue = 0;
                  }
                  headerNegativeOffset.value = newValue;
                  print(headerNegativeOffset);
                  tile = "";
                }

                return true;
              },
              child: Stack(
                children: <Widget>[
                  DraggableScrollableSheet(
                    initialChildSize: bodyContentRatioMin,
                    minChildSize: bodyContentRatioMin,
                    maxChildSize: bodyContentRatioMax,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Stack(
                        children: <Widget>[
                          Container(
                            alignment: AlignmentDirectional.center,
                            padding: EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 16.0),
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: 10,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) =>
                                  Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                child: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetail(
                                        code: name[index],
                                        key: _refreshKey,
                                      )));
                                    });
                                  },
                                  child: Card(
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 30,
                                                child: Image(
                                                  image: NetworkImage(
                                                      "https://i.ytimg.com/vi/TkAlSDzoD3E/hqdefault.jpg"),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    name[index],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    desition[index],
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    "April 08, 2020-18:00",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18.0,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                child: Text(
                                                  "Oder Total",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                name[index],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                desition[index],
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                              Text(
                                                "April 08, 2020-18:00",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 18.0,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            )
          ]),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 0.0,
            child: ValueListenableBuilder<bool>(
                valueListenable: appbarShadow,
                builder: (context, value, child) {
                  ///default height of appbar is 56.0. You can also
                  ///use a custom widget with custom height if you want.
                  return AppBar(
                    backgroundColor: Colors.blue,
                    title: Text(tile),
                    elevation: value ? 2.0 : 0.0,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
