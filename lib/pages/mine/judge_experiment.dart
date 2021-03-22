import 'package:flutter/material.dart';
import 'package:swustflutter/client/swust_api_client.dart';
import 'package:swustflutter/config/constant.dart';
import 'package:swustflutter/model/experiment_info.dart';
import 'package:swustflutter/pages/mine/detail_info_judge.dart';

class JudgeExperiment extends StatefulWidget {
  @override
  _JudgeExperimentState createState() => _JudgeExperimentState();
}


class _JudgeExperimentState extends State<JudgeExperiment> {

  SwustAPIClient apiClient = new SwustAPIClient();
  List<dynamic> experimentList = [];
  ExperimentInfo experimentInfo;
  @override
  initState(){
    super.initState();
    getList(Constant.userConfigInfo.authtoken).then((value){
      setState(() {
        experimentList = value;
      });
      print(experimentList);
      print(experimentList.length);
    });
  }
  Future<List<dynamic>> getList(String token)async{
    return await apiClient.getexamineList(token);
  }
  Widget buildExperimentList() {
    return experimentList.length == 0 ?
    Container(
      child: Center(
        child: Column(
          children: [
            Icon(Icons.hourglass_empty, size: 60,),
            Text('暂无待审核实验室信息!')
          ],
        ),
      ),
    ) : 
    Container(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: experimentList.length,
          itemBuilder: (BuildContext context, int index) {
            experimentInfo = ExperimentInfo.fromJson(experimentList[index]);
            return buildWidget(experimentInfo);
          }
      ),
    );
  }
  Widget buildWidget(ExperimentInfo experimentInfo) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.5, color: Color(0xffe5e5e5))),
        ),
        child: ListTile(
          leading: Image.asset('assets/logo.jpg'),
          title: Row(
            children: <Widget>[
              Expanded(child: Text(experimentInfo.experimentName)),
            ],
          ),
          subtitle: Text('申请人：' + experimentInfo.director),
        ),
      ),
      onTap: () {
        /// 设置跳转到待审核实验室详情界面
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailInfoJudgePage(experimentInfo)));
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('审核实验室'),
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
              buildExperimentList(),
            ],
          ),
        ),
      ),
    );
  }
}
