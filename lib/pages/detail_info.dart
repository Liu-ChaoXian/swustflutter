import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swustflutter/model/experiment_info.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

///实验室详细信息界面
class DetailInfo extends StatelessWidget {
  ExperimentInfo experimentInfo;
  DetailInfo({this.experimentInfo});
  final _normalFont = const TextStyle(fontSize: 18.0);
  final _titleFont =
      const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(experimentInfo.experimentName),
          leading: IconButton(
            icon: Icon(Icons.chevron_left, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      experimentInfo.imageLink[index],
                      fit: BoxFit.fill,
                    );
                  },
                  itemCount: experimentInfo.imageLink.length,
                  pagination: new SwiperPagination(),
                  loop: true,
                  autoplay: true,
                ),
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Card(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('实验室名称：', style: _titleFont),
                                          Expanded(
                                            child: Text(
                                                '${experimentInfo.experimentName}',
                                                style: _normalFont),
                                          )
                                        ],
                                      ),
//                                    Padding(
//                                      padding: EdgeInsets.only(left: 10, right: 10),
//                                      child: Text('${experimentInfo.experimentName}', style: _normalFont),
//                                    )
                                    ],
                                  )),
                              Card(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('实验室老师：', style: _titleFont),
                                      Text('${experimentInfo.director}',
                                          style: _normalFont),
                                    ],
                                  )),
                              Card(
                                color: Color.fromARGB(255, 240, 240, 240),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('实验室地址：', style: _titleFont),
                                        Expanded(
                                          child: Text(
                                              '${experimentInfo.experimentAddress}',
                                              style: _normalFont),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Card(
                                color: Color.fromARGB(255, 240, 240, 240),
                                child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('招新时间：', style: _titleFont),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text('${experimentInfo.time}',
                                          style: _normalFont),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: RaisedButton(
                                  child: Text("申 请 加 入", style: _normalFont),
                                  color: Colors.blue,
                                  disabledColor: Colors.black12,
                                  textColor: Colors.white,
                                  disabledTextColor: Colors.black12,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  onPressed: () {},
                                ),
                              )
                            ],
                          ))
                    ],
                  )),
            ],
          ),
        ));
  }
}
