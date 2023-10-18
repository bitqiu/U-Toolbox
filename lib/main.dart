import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:media_kit/media_kit.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:get/get.dart';
import 'package:utoolbox/widgets/status/app_loadding_widget.dart';

import 'app/app_style.dart';
import 'app/log.dart';
import 'app/utils.dart';
import 'common/core_log.dart';
import 'models/db/follow_user.dart';
import 'models/db/history.dart';
import 'services/db_service.dart';
import 'services/local_storage_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await Hive.initFlutter();
  //初始化服务
  await initServices();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  //设置状态栏为透明
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  runApp(const MyApp());
}

Future initServices() async {
  //日志信息
  CoreLog.enableLog = !kReleaseMode;
  CoreLog.onPrintLog = (level, msg) {
    switch (level) {
      case Level.debug:
        Log.d(msg);
        break;
      case Level.error:
        Log.e(msg, StackTrace.current);
        break;
      case Level.info:
        Log.i(msg);
        break;
      case Level.warning:
        Log.w(msg);
        break;
      default:
        Log.logPrint(msg);
    }
  };

  Hive.registerAdapter(FollowUserAdapter());
  Hive.registerAdapter(HistoryAdapter());

  //包信息
  Utils.packageInfo = await PackageInfo.fromPlatform();
  //本地存储
  Log.d("Init LocalStorage Service");
  await Get.put(LocalStorageService()).init();
  await Get.put(DBService()).init();
  // //初始化设置控制器
  // Get.put(AppSettingsController());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: AppStyle.lightTheme,
      darkTheme: AppStyle.darkTheme,
      // themeMode: ThemeMode.values[Get.find<AppSettingsController>().themeMode.value],
      builder: FlutterSmartDialog.init(
        loadingBuilder: ((msg) => const AppLoaddingWidget()),
        //字体大小不跟随系统变化
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Stack(
            children: [
              child!,
              //查看DEBUG日志按钮
              //只在Debug、Profile模式显示
              Visibility(
                visible: !kReleaseMode,
                child: Positioned(
                  right: 12,
                  bottom: 100 + context.mediaQueryViewPadding.bottom,
                  child: Opacity(
                    opacity: 0.4,
                    child: ElevatedButton(
                      child: const Text("DEBUG LOG"),
                      onPressed: () {
                        // Get.bottomSheet(
                        //   // const DebugLogPage(),
                        // );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
