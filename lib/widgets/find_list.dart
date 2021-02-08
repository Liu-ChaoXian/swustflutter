import 'package:swustflutter/model/experiment_info.dart';

import 'package:flutter/material.dart';

///回调函数
typedef ExperimentOnTap = void Function(ExperimentInfo file);

class ExperimentListWidget extends StatelessWidget { ///实验室列表

  var experiment = List<ExperimentInfo>();

  ExperimentOnTap onFileTap;

  ExperimentListWidget(this.experiment, {this.onFileTap});

  @override
  Widget build(BuildContext context) => _buildFilesWidget();

  ///用ListView.builder展示实验室信息
  Widget _buildFilesWidget() => this.experiment.length == 0
      ? Column(
          children: <Widget>[
            SizedBox(height: 200),
            Image.asset('assets/folder.png'),
            Text('空空如也')
          ],
        )
      : ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: this.experiment.length,
          itemBuilder: (BuildContext context, int index) {
             return _buildFolderItem(this.experiment[index]);
          },
        );

  Widget _buildFolderItem(ExperimentInfo experimentInfo) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.5, color: Color(0xffe5e5e5))),
        ),
        child: ListTile(
          leading: Image.asset(experimentInfo.imageLink),
          title: Row(
            children: <Widget>[
              Expanded(child: Text(experimentInfo.experimentName)),
            ],
          ),
          subtitle: Text("负责人：" + experimentInfo.director),
        ),
      ),
      onTap: () {
        if (null != this.onFileTap) this.onFileTap(experimentInfo);
      },
    );
  }
}
