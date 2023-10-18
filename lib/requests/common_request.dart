import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/version_model.dart';

/// 通用的请求
class CommonRequest {
  Future<VersionModel> checkUpdate() async {
    try {
      return await checkUpdateGitMirror();
    } catch (e) {
      return await checkUpdateJsDelivr();
    }
  }

  /// 检查更新
  Future<VersionModel> checkUpdateGitMirror() async {
    var result = await Dio().get(
      "https://raw.gitmirror.com/xiaoyaocz/dart_simple_live/master/assets/app_version.json",
      queryParameters: {
        "ts": DateTime.now().millisecondsSinceEpoch,
      },
      options: Options(
        responseType: ResponseType.json,
      ),
    );
    if (result.data is Map) {
      return VersionModel.fromJson(result.data);
    }
    return VersionModel.fromJson(json.decode(result.data));
  }

  /// 检查更新
  Future<VersionModel> checkUpdateJsDelivr() async {
    var result = await Dio().get(
      "https://cdn.jsdelivr.net/gh/xiaoyaocz/dart_simple_live@master/assets/app_version.json",
      queryParameters: {
        "ts": DateTime.now().millisecondsSinceEpoch,
      },
      options: Options(
        responseType: ResponseType.json,
      ),
    );
    if (result.data is Map) {
      return VersionModel.fromJson(result.data);
    }
    return VersionModel.fromJson(json.decode(result.data));
  }
}
