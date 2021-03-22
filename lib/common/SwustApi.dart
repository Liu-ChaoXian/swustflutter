import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import 'package:swustflutter/config/constant.dart';
import 'package:swustflutter/model/profile.dart';

class SwustApi {
  // 在网络请求过程中可能会需要使用当前的context信息，比如在请求失败时
  // 打开一个新路由，而打开新路由需要context信息。
  SwustApi([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext context;
  Options _options;
  static Dio dio = new Dio(BaseOptions(
    baseUrl: 'http://81.70.222.171:80',
  ));

  static void init() {
    // 设置用户token（可能为null，代表未登录）
    dio.options.headers['auth-token'] = Constant.userConfigInfo.authtoken;
  }

  Future<Map<String, dynamic>> Get(String title, String path,
      {Map params}) async {
    Response response;
    if (params != null) {
      response = await dio.get(path, queryParameters: params);
    } else {
      response = await dio.get(path);
    }
    return response == null ? {"msg": "出错了"} : response.data;
  }

  Future<Map<String, dynamic>> Post(String title, String path,
      {Map json, FormData formData}) async {
    Response response =
        await dio.post(path, data: json == null ? formData : json);

    return response == null ? {"msg": "出错了"} : response.data;
    //更新profile中的token信息
  }
}
