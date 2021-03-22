import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:io';

class SwustAPIClient {
  List list = [];
  Map msg = {};
  String baseUrl = 'http://81.70.222.171:80';
  /// 注册新用户
  Future<String> createAccount(Map paras) async{
//    Map paras = {
//      'userPhone': '13500000030',
//      'userAccount': '5120173559',
//      'userName': 'LiuChaoXian',
//      'password': '201515'
//    };
    Options options = Options(headers: {"Content-Type": "application/json"});
    var apiUrl = baseUrl + "/account/create";
    try{
      Response response = await Dio().post(apiUrl, data: paras, options: options);
      print('注册结果：${response.data}');
      /// 获取到的是Map类型
      return response.data['msg'];
    }on DioError catch(e){  /// 异常捕获
        return e.response.data['msg'];
    }
  }
  /// 登录
  Future<Map<String,dynamic>> loginAccount(Map paras) async{
//    Map paras = {
//      'userAccount': '5120173552',
//      'password': '201515'
//    };
    Options options = Options(headers: {HttpHeaders.acceptHeader:"Content-Type: application/json"});
    var apiUrl = baseUrl + "/account/sign-in";
    try{
      Response response = await Dio().post(apiUrl, data: paras, options: options);
      print('登录结果：${response.data}');
      /// 获取到的是Map类型
      return response.data;
    }on DioError catch(e){  /// 异常捕获
      return e.response.data;
    }

  }

  /// 修改密码
  Future<Map<String,dynamic>> changePwd(Map paras, String token) async {
//    Map paras = {
//      "newPwd": "1.2.3-",
//    };
    Map<String, dynamic> header = {
      "auth-token": token,
      'Content-Type': 'application/json'
    };
    Options options = Options(headers: header);
    var apiUrl = baseUrl + "/user/alter/pwd";
    try{
      Response response = await Dio().post(apiUrl, data: paras, options: options);
      print('修改密码结果：${response.data}');
      /// 获取到的是Map类型
      return response.data;
    }on DioError catch(e){  /// 异常捕获
      print('修改密码错误结果：${e.response.data}');
      return e.response.data;
    }
  }

  /// 获取实验室列表
  getExperimentList(String token) async{
    Map<String, dynamic> header = {
      "auth-token": token,
    };
    Options options = Options(headers: header);
    var apiUrl = baseUrl + "/lab/default_list";
    try{
      Response response = await Dio().get(apiUrl, options: options);
      print('获取实验室列表结果：${response.data}');
      /// 获取到的是Map类型
      return response.data;
    }on DioError catch(e){  /// 异常捕获
      print('获取实验室列表结果：${e.response.data}');
      return e.response.data;
    }
  }
  /// 用户注销账号
  Future<Map<String,dynamic>> logoffAccount(String token) async{
    Map<String, dynamic> header = {
      "auth-token": token,
      'Content-Type': 'application/json'
    };
    Options options = Options(headers: header);
    var apiUrl = baseUrl + "/user/logoff";
    try{
      Response response = await Dio().post(apiUrl, options: options);
      print('注销结果：${response.data}');
      /// 获取到的是Map类型
      return response.data;
    }on DioError catch(e){  /// 异常捕获
      print('注销账号：' + e.response.data);
      return e.response.data;
    }
  }

  /// 创建实验室
  Future<Map<String,dynamic>> createExperiment(Map paras, String token) async{
    Map<String, dynamic> header = {
      "auth-token": token,
      'Content-Type': 'application/json'
    };
    Options options = Options(headers: header);
    var apiUrl = baseUrl + "/lab/create";
    try{
      Response response = await Dio().post(apiUrl,data: paras, options: options);
      print('创建实验室结果：${response.data}');
      /// 获取到的是Map类型
      return response.data;
    }on DioError catch(e){  /// 异常捕获
      print('创建实验室：' + e.response.data);
      return e.response.data;
    }
  }

  /// 获取用户信息
  Future<Map<String, dynamic>> getUserInfo(String token) async {
    Map<String, dynamic> header = {
      "auth-token": token,
    };
    Options options = Options(headers: header);
    var apiUrl = baseUrl + "/user/info";
    try{
      Response response = await Dio().get(apiUrl, options: options);
      print('获取用户信息：${response.data}');
      /// 获取到的是Map类型
      return response.data;
    }on DioError catch(e){  /// 异常捕获
      print('获取用户信息：' + e.response.data);
      return e.response.data;
    }
  }


//  getDetail
}