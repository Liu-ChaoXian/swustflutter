import 'package:flutter/material.dart';
import 'package:swustflutter/client/swust_api_client.dart';
import 'package:swustflutter/config/constant.dart';
import 'package:swustflutter/widgets/apply_list.dart';

class ApplyListPage extends StatefulWidget {
  String labId;
  ApplyListPage(this.labId);
  @override
  _ApplyListPageState createState() => _ApplyListPageState();
}
enum GetState { loading, loaded, fail }
class _ApplyListPageState extends State<ApplyListPage> {
  final _normalFont = const TextStyle(fontSize: 18.0);
  final _titlrFont = const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400);
  /// 页面状态
  GetState _state = GetState.loading;
  SwustAPIClient apiClient = new SwustAPIClient();

  List<dynamic> userList = [];
  Future<List<dynamic>> getList(String token) async {
    return await apiClient.getApplyList(token, widget.labId);
  }

  @override
  void initState() {
    super.initState();
    getList(Constant.userConfigInfo.authtoken).then((value) {
      setState(() {
        userList = value;
        _state = GetState.loaded;
      });
      print(userList);
      print(userList.length);
    });
  }

  Widget buildInnerWidget() {
    return ApplyListWidget(userList);
  }

  Widget _buildWidget() {
    switch (_state) {
      case GetState.loading:
        return Center(
          heightFactor: 5,
          child: Column(
            children: <Widget>[
              CircularProgressIndicator(strokeWidth: 4.0),
              Text('正在搜索')
            ],
          ),
        );
      case GetState.loaded:
        return buildInnerWidget();
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('申请列表', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 8,
          right: 8,
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 10,
            ),
            Center(child: _buildWidget())
          ],
        ),
      ));
  }
}
