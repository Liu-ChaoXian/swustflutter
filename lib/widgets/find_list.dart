import 'package:swustflutter/model/experiment_info.dart';
import 'package:swustflutter/config/constant.dart';
import 'package:flutter/material.dart';

import '../model/experiment_info.dart';
import '../model/experiment_info.dart';

///回调函数
typedef ExperimentOnTap = void Function(String labId);

class ExperimentListWidget extends StatelessWidget { ///实验室列表

  List<dynamic> experiment;

  ExperimentOnTap onFileTap;

  ExperimentListWidget(this.experiment, {this.onFileTap});

  @override
  Widget build(BuildContext context) => _buildFilesWidget();

  ///用ListView.builder展示实验室信息
  Widget _buildFilesWidget() => this.experiment.length == 0
      ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 200),
              Icon(Icons.hourglass_empty, size: 40,),
              Text('未找到相关信息')
            ],
          ),
        )
      : ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: this.experiment.length,
          itemBuilder: (BuildContext context, int index) {
             ExperimentInfo experimentInfo = ExperimentInfo.fromJsonDefault(this.experiment[index]);
             return _buildExperimentItem(experimentInfo);
          },
        );

  Widget _buildExperimentItem(ExperimentInfo experimentInfo) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.5, color: Color(0xffe5e5e5))),
        ),
        child: ListTile(
          leading: Image.network(Constant.baseUrl + experimentInfo.labAvatarUrl),
          title: Row(
            children: <Widget>[
              Expanded(child: Text(experimentInfo.experimentName)),
            ],
          ),
          subtitle: Text("负责人：" + experimentInfo.director),
        ),
      ),
      onTap: () {
        if (null != this.onFileTap) this.onFileTap(experimentInfo.labId);
      },
    );
  }
}
