// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:swustflutter/model/experiment_info.dart';

class DetailPage extends StatelessWidget {
  final ExperimentInfo experimentInfo;

  const DetailPage({
    Key key,
    @required this.experimentInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(experimentInfo.experimentName),
          actions: <Widget>[
            IconButton(
              icon: IconButton(
                  icon: Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  onPressed: () {}),
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 250,
              child: FlipCard(
                direction: FlipDirection.HORIZONTAL,
                front: Image.asset("assets/logo.jpg"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              child: ListTile(
                trailing: Text("地址"),
                leading: Icon(
                  Icons.home,
                  color: Colors.orange,
                ),
                title: Text(
                  "${experimentInfo.experimentAddress}",
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              ),
            ),
            Card(
              child: ListTile(
                trailing: Text(
                  "教师",
                ),
                leading: Icon(
                  Icons.person,
                  color: Colors.orange,
                ),
                title: Text(
                  "${experimentInfo.director}",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                trailing: Text("简介"),
                leading: Icon(
                  Icons.description,
                  color: Colors.orange,
                ),
                title: Text(
                  "${experimentInfo.detailInfo}",
                  style: TextStyle(fontStyle: FontStyle.normal, fontSize: 15),
                ),
              ),
            )
          ],
        ));
  }
}
