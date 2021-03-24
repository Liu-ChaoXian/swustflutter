import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:io';

class SwustAPIClient {
  List list = [];
  Map msg = {};
  String baseUrl = 'http://81.70.222.171:80';

  /// 注册新用户
  Future<String> createAccount(Map paras) async {
//    Map paras = {
//      'userPhone': '13500000030',
//      'userAccount': '5120173559',
//      'userName': 'LiuChaoXian',
//      'password': '201515'
//    };
    Options options = Options(
        headers: {HttpHeaders.acceptHeader: "Content-Type: application/json"});
    var apiUrl = baseUrl + "/account/create";
    try {
      Response response =
          await Dio().post(apiUrl, data: paras, options: options);
      print('注册结果：${response.data}');

      /// 获取到的是Map类型
      return response.data['msg'];
    } on DioError catch (e) {
      /// 异常捕获
      return e.response.data['msg'];
    }
  }

  /// 登录
  Future<Map<String, dynamic>> loginAccount(Map paras) async {
//    Map paras = {
//      'userAccount': '5120173552',
//      'password': '201515'
//    };
    Options options = Options(
        headers: {HttpHeaders.acceptHeader: "Content-Type: application/json"});
    var apiUrl = baseUrl + "/account/sign-in";
    try {
      Response response =
          await Dio().post(apiUrl, data: paras, options: options);
      print('登录结果：${response.data}');

      /// 获取到的是Map类型
      return response.data;
    } on DioError catch (e) {
      /// 异常捕获
      return e.response.data;
    }
  }

  /// 修改密码
  Future<Map<String, dynamic>> changePwd(Map paras, String token) async {
//    Map paras = {
//      "newPwd": "1.2.3-",
//    };
    Map<String, dynamic> header = {
      "auth-token": token,
      'Content-Type': 'application/json'
    };
    Options options = Options(headers: header);
    var apiUrl = baseUrl + "/user/alter/pwd";
    try {
      Response response =
          await Dio().post(apiUrl, data: paras, options: options);
      print('修改密码结果：${response.data}');

      /// 获取到的是Map类型
      return response.data;
    } on DioError catch (e) {
      /// 异常捕获
      print('修改密码错误结果：${e.response.data}');
      return e.response.data;
    }
  }

  /// 用户注销账号
  Future<Map<String, dynamic>> logoffAccount(String token) async {
    Map<String, dynamic> header = {
      "auth-token": token,
      'Content-Type': 'application/json'
    };
    Options options = Options(headers: header);
    var apiUrl = baseUrl + "/user/logoff";
    try {
      Response response = await Dio().post(apiUrl, options: options);
      print('注销结果：${response.data}');

      /// 获取到的是Map类型
      return response.data;
    } on DioError catch (e) {
      /// 异常捕获
      print('注销账号：' + e.response.data);
      return e.response.data;
    }
  }

  /// 创建实验室
  Future<Map<String, dynamic>> createExperiment(Map paras, String token) async {
    Map<String, dynamic> header = {
      "auth-token": token,
      'Content-Type': 'application/json'
    };
    Options options = Options(headers: header);
    var apiUrl = baseUrl + "/lab/create";
    try {
      Response response =
          await Dio().post(apiUrl, data: paras, options: options);
      print('创建实验室结果：${response.data}');

      /// 获取到的是Map类型
      return response.data;
    } on DioError catch (e) {
      /// 异常捕获
      print('创建实验室：' + e.response.data);
      return e.response.data;
    }
  }

  /// 获取用户信息
  Future<Map<String, dynamic>> getUserInfo(String token) async {
    Map<String, dynamic> header = {
      "auth-token": token,
      'Content-Type': 'application/json'
    };
    Options options = Options(headers: header);
    var apiUrl = baseUrl + "/user/info";
    try {
      Response response = await Dio().get(apiUrl, options: options);
      print('获取用户信息：${response.data}');

      /// 获取到的是Map类型
      return response.data;
    } on DioError catch (e) {
      /// 异常捕获
      print('获取用户信息异常：' + e.response.data);
      return e.response.data;
    }
  }

  /// 获取所有创建待审核实验室
  Future<List<dynamic>> getexamineList(String token) async {
    Map<String, dynamic> header = {
      "auth-token": token,
      'Content-Type': 'application/json'
    };
    Options options = Options(headers: header);
    var apiUrl = baseUrl + "/lab/examineList";
    try {
      Response response = await Dio().get(apiUrl, options: options);
      print('获取所有创建待审核实验室：${response.data}');

      /// 获取到的是Map类型
      return response.data['labs'];
    } on DioError catch (e) {
      /// 异常捕获
      print('获取所有创建待审核实验室：' + e.response.data);
      return e.response.data;
    }
  }

  /// 获取实验室列表
  Future<List<dynamic>> getExperimentList(String token) async {
    Map<String, dynamic> header = {
      "auth-token": token,
      'Content-Type': 'application/json'
    };
    Options options = Options(headers: header);
    var apiUrl = baseUrl + "/lab/default_list";
    try {
      Response response = await Dio().get(apiUrl, options: options);
      print('获取实验室列表结果：${response.data}');

      /// 获取到的是Map类型
      return response.data['labs'];
    } on DioError catch (e) {
      /// 异常捕获
      print('获取实验室列表结果：${e.response.data}');
      return e.response.data;
    }
  }

  /// 审核实验室
  Future<Map<String,dynamic>> judgeExperiment(Map paras, String token) async{
    Map<String, dynamic> header = {
      "auth-token": token,
      'Content-Type': 'application/json'
    };
    Options options = Options(headers: header);
    var apiUrl = baseUrl + "/lab/examine/lab";
    try{
      print(paras);
      Response response = await Dio().post(apiUrl, data: paras, options: options);
      print('审核实验室：${response.data}');
      /// 获取到的是Map类型
      return response.data;
    }on DioError catch(e){  /// 异常捕获
      print('审核实验室：' + e.response.data);
      return e.response.data;
    }
  }


  /// 获取实验室详情信息
  Future<Map<String, dynamic>> getDetailInfo(String labId, String token) async {
    Map<String, dynamic> header = {
      "auth-token": token,
      'Content-Type': 'application/json'
    };
    Options options = Options(headers: header);
    var apiUrl = baseUrl + "/lab/detail?labId=$labId";
    try {
      Response response = await Dio().get(apiUrl, options: options);
      print('获取实验室详情信息：${response.data}');

      /// 获取到的是Map类型
      return response.data;
    } on DioError catch (e) {
      /// 异常捕获
      print('获取实验室详情信息：' + e.response.data);
      return e.response.data;
    }
  }

  ///用户申请加入实验室
  Future<Map<String, dynamic>> applyExperiment(Map paras, String token) async {
    Map<String, dynamic> header = {
      "auth-token": token,
      'Content-Type': 'application/json'
    };
    Options options = Options(headers: header);
    var apiUrl = baseUrl + "/lab/join";
    try {
      Response response =
          await Dio().post(apiUrl, data: paras, options: options);
      print('用户申请加入实验室：${response.data}');
      /// 获取到的是Map类型
      return response.data;
    } on DioError catch (e) {
      /// 异常捕获
      print('用户申请加入实验室：' + e.response.data);
      return e.response.data;
    }
  }

  /// 搜索实验室
  Future<List<dynamic>> getSearchList(String token, String keyword) async {
    Map<String, dynamic> header = {
      "auth-token": token,
      'Content-Type': 'application/json'
    };
    Options options = Options(headers: header);
    var apiUrl = baseUrl + "/lab/search?keyword=$keyword";
    try {
      Response response = await Dio().get(apiUrl, options: options);
      print('搜索实验室：${response.data}');
      /// 获取到的是Map类型
      return response.data['labs'];
    } on DioError catch (e) {
      /// 异常捕获
      print('搜索实验室：' + e.response.data);
      return e.response.data;
    }
  }

  /// 获取申请列表
  Future<List<dynamic>> getApplyList(String token, String labId) async {
    Map<String, dynamic> header = {
      "auth-token": token,
      'Content-Type': 'application/json'
    };
    Options options = Options(headers: header);
    var apiUrl = baseUrl + "/lab/applyList?labId=$labId";
    try {
      Response response = await Dio().get(apiUrl, options: options);
      print('获取申请列表结果：${response.data}');
      /// 获取到的是Map类型
      return response.data['applyList'];
    } on DioError catch (e) {
      /// 异常捕获
      print('获取申请列表结果：${e.response.data}');
      return e.response.data;
    }
  }

  /// 管理员审核用户申请
  Future<Map<String,dynamic>> judgeApplyUser(Map paras, String token) async{
    Map<String, dynamic> header = {
      "auth-token": token,
      'Content-Type': 'application/json'
    };
    Options options = Options(headers: header);
    var apiUrl = baseUrl + "/lab/examine/user";
    try{
      print(paras);
      Response response = await Dio().post(apiUrl, data: paras, options: options);
      print('管理员审核用户申请：${response.data}');
      /// 获取到的是Map类型
      return response.data;
    }on DioError catch(e){  /// 异常捕获
      print('管理员审核用户申请：' + e.response.data);
      return e.response.data;
    }
  }

  /// 用户修改用户资料
  Future<Map<String, dynamic>> changeUserInfo(String token, Map paras) async{
    Map<String, dynamic> header = {
      "auth-token": token,
      'Content-Type': 'application/json'
    };
    Options options = Options(headers: header);
    var apiUrl = baseUrl + "/user/alter/info";
    try{
      print(paras);
      Response response = await Dio().post(apiUrl, data: paras, options: options);
      print('用户修改用户资料：${response.data}');
      /// 获取到的是Map类型
      return response.data;
    }on DioError catch(e){  /// 异常捕获
      print('用户修改用户资料：' + e.response.data);
      return e.response.data;
    }
  }

  /// 用户删除实验室
  Future<Map<String, dynamic>> deleteExperiment(String token, Map paras) async {
    Map<String, dynamic> header = {
      "auth-token": token,
      'Content-Type': 'application/json'
    };
    Options options = Options(headers: header);
    var apiUrl = baseUrl + "/lab/delete/lab";
    try{
      print(paras);
      Response response = await Dio().post(apiUrl, data: paras, options: options);
      print('用户删除实验室：${response.data}');
      /// 获取到的是Map类型
      return response.data;
    }on DioError catch(e){  /// 异常捕获
      print('用户删除实验室：' + e.response.data);
      return e.response.data;
    }
  }
}
