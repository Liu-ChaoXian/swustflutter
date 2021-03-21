import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import 'package:swustflutter/model/profile.dart';

import 'Global.dart';

class Swust {
  // 在网络请求过程中可能会需要使用当前的context信息，比如在请求失败时
  // 打开一个新路由，而打开新路由需要context信息。
  Swust([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext context;
  Options _options;
  static Dio dio = new Dio(BaseOptions(
    baseUrl: 'http://81.70.222.171:80',
  ));

  static void init() {
    // 设置用户token（可能为null，代表未登录）
    dio.options.headers['auth-token'] = Global.profile.token;
  }

  // 登录接口，登录成功后返回用户信息
  Future<Profile> login(String login, String pwd) async {
    String basic = 'Basic ' + base64.encode(utf8.encode('$login:$pwd'));
    var r = await dio.get(
      "/users/$login",
      options: _options.merge(headers: {
        HttpHeaders.authorizationHeader: basic
      }, extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );
    //登录成功后更新公共头（authorization），此后的所有请求都会带上用户身份信息
    dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    //清空所有缓存
    //更新profile中的token信息
    Global.profile.token = basic;
    return Profile.fromJson(r.data);
  }

//title:名字：随便取，尽量与接口功能对应
  Future<Profile> Get({
    String title,
    String router,
    String contentType,
  }) async {
    var r = await dio.get(
      router,
      options:
          _options.merge(headers: {HttpHeaders.contentTypeHeader: contentType}),
    );
    //登录成功后更新公共头（authorization），此后的所有请求都会带上用户身份信息
    dio.options.headers['token'] = 'basic';
    //清空所有缓存
    //更新profile中的token信息
    Global.profile.token = '';
    return Profile.fromJson(r.data);
  }

  // 获取用户项目列表
  // Future<List<Repo>> getRepos(
  //     {Map<String, dynamic> queryParameters, //query参数，用于接收分页信息
  //     refresh = false}) async {
  //   if (refresh) {
  //     // 列表下拉刷新，需要删除缓存（拦截器中会读取这些信息）
  //     _options.extra.addAll({"refresh": true, "list": true});
  //   }
  //   var r = await dio.get<List>(
  //     "user/repos",
  //     queryParameters: queryParameters,
  //     options: _options,
  //   );
  //   return r.data.map((e) => Repo.fromJson(e)).toList();
  // }
}
