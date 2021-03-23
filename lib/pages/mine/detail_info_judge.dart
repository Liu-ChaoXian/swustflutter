import 'package:flutter/material.dart';
import 'package:swustflutter/model/experiment_info.dart';
import 'package:swustflutter/client/swust_api_client.dart';
import 'personal_center.dart';
import 'package:swustflutter/config/constant.dart';

class DetailInfoJudgePage extends StatefulWidget {
  ExperimentInfo experimentInfo;
  DetailInfoJudgePage(this.experimentInfo);
  @override
  _DetailInfoJudgePageState createState() => _DetailInfoJudgePageState();
}

class _DetailInfoJudgePageState extends State<DetailInfoJudgePage> {
  final _normalFont = const TextStyle(fontSize: 18.0);
  final _titleFont =
      const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600);
  SwustAPIClient apiClient = new SwustAPIClient();
  Map paras = {};

  Future<dynamic> getPassJudge(Map paras) async {
    print('getPassJudge');
    return await apiClient.judgeExperiment(
        paras, Constant.userConfigInfo.authtoken);
  }

  Future<dynamic> getFailJudge(Map paras) async {
    return await apiClient.judgeExperiment(
        paras, Constant.userConfigInfo.authtoken);
  }

  passJudge(String labId) {
    return () {
      print(labId);
      paras['labId'] = labId;
      paras['result'] = 'pass';
      getPassJudge(paras).then((msg) {
        print(msg);
        if (msg == '审核通过') {
          setState(() {
            Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => PersonalCenter()),
                (route) => route == null);
            Constant.useFlush(msg, context);
          });
        }
      });
    };
  }

  failJudge(String labId) {
    return () {
      paras['labId'] = labId;
      paras['result'] = 'pass';
      getFailJudge(paras).then((msg) {
        print(msg);
        if (msg == '审核不通过') {
          setState(() {
            Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => PersonalCenter()),
                (route) => route == null);
            Constant.useFlush(msg, context);
          });
        }
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.experimentInfo.experimentName}'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Card(
                  color: Color.fromARGB(255, 240, 240, 240),
                  child: Column(children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                        ])
                  ])),
              Card(
                  color: Color.fromARGB(255, 240, 240, 240),
                  child: Column(children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Text('申请人：', style: _titleFont),
                          Expanded(
                            child: Text('${widget.experimentInfo.director}',
                                style: _normalFont),
                          )
                        ])
                  ])),
              Card(
                  color: Color.fromARGB(255, 240, 240, 240),
                  child: Column(children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Text('实验室简介：', style: _titleFont),
                          Expanded(
                            child: Text('${widget.experimentInfo.detailInfo}',
                                style: _normalFont),
                          )
                        ])
                  ])),
              Card(
                  color: Color.fromARGB(255, 240, 240, 240),
                  child: Column(children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Text('实验室地址：', style: _titleFont),
                          Expanded(
                            child: Text(
                                '${widget.experimentInfo.experimentAddress}',
                                style: _normalFont),
                          )
                        ])
                  ])),
              Card(
                  color: Color.fromARGB(255, 240, 240, 240),
                  child: Column(children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Text('实验室成果：', style: _titleFont),
                          Expanded(
                            child: Text('${widget.experimentInfo.achievement}',
                                style: _normalFont),
                          )
                        ])
                  ])),
              Card(
                  color: Color.fromARGB(255, 240, 240, 240),
                  child: Column(children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Text('联系方式：', style: _titleFont),
                          Expanded(
                            child: Text('${widget.experimentInfo.labContact}',
                                style: _normalFont),
                          )
                        ])
                  ])),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 10),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.green,
                    child: Text('同意'),
                    onPressed: () {
                      print('点击了同意1');
                      print('labId: ${widget.experimentInfo.labId}');
                      passJudge(widget.experimentInfo.labId);
                      print('点击了同意2');
                    },
                  ),
                  RaisedButton(
                      textColor: Colors.white,
                      color: Colors.red,
                      child: Text('拒绝'),
                      onPressed: () {
                        print('点击了拒绝');
                        failJudge(widget.experimentInfo.labId);
                      }),
                  SizedBox(width: 10),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
