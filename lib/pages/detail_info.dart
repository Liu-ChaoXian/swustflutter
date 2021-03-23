import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swustflutter/model/experiment_info.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:swustflutter/config/constant.dart';
import 'package:swustflutter/pages/find/find_page.dart';
import '../client/swust_api_client.dart';

///实验室详细信息界面
class DetailInfo extends StatefulWidget {
  ExperimentInfo experimentInfo;
  DetailInfo({this.experimentInfo});
  @override
  _DetailInfoState createState() => _DetailInfoState();
}

class _DetailInfoState extends State<DetailInfo> {
  final _normalFont = const TextStyle(fontSize: 18.0);
  final _titleFont =
      const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600);
  SwustAPIClient apiClient = new SwustAPIClient();
  Map paras = {};
  Future<Map<String, dynamic>> _applyExperiment(String token, Map paras) async {
    return await apiClient.applyExperiment(paras, token);
  }

  _joinExperiment() {
    return () {
      paras['labId'] = widget.experimentInfo.labId;
      _applyExperiment(Constant.userConfigInfo.authtoken, paras).then((value) {
        setState(() {
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(builder: (context) => FindPage()),
              (route) => route == null);
          Constant.useFlush(value['msg'], context);
        });
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.experimentInfo.experimentName),
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
                      widget.experimentInfo.imageLink[index],
                      fit: BoxFit.fill,
                    );
                  },
                  itemCount: widget.experimentInfo.imageLink.length,
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
                                                '${widget.experimentInfo.experimentName}',
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
                                      Text('${widget.experimentInfo.director}',
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
                                              '${widget.experimentInfo.experimentAddress}',
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
                                      child: Text(
                                          '${widget.experimentInfo.time}',
                                          style: _normalFont),
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
                                        Text('联系方式：', style: _titleFont),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                          '${widget.experimentInfo.labContact}',
                                          style: _normalFont),
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
                                        Text('实验室简介：', style: _titleFont),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                          '${widget.experimentInfo.detailInfo}',
                                          style: _normalFont),
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
                                        Text('实验室成果：', style: _titleFont),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                          '${widget.experimentInfo.achievement}',
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
                                  onPressed: () {
                                    _joinExperiment();
                                  },
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
