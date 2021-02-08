import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swustflutter/model/experiment_info.dart';

///实验室详细信息界面
class DetailInfo extends StatelessWidget{

  ExperimentInfo experimentInfo;
  DetailInfo({this.experimentInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(experimentInfo.experimentName),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.white),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Image.asset(
              experimentInfo.imageLink,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover),
          Text('负责人：' + experimentInfo.director),
          Text('实验室地址：' + experimentInfo.experimentAddress),
          Text('详细信息：' + experimentInfo.detailInfo),
        ],
      ),
    );
  }
}