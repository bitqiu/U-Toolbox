// ignore_for_file: prefer_inlined_adds
import 'package:get/get.dart';
import 'package:utoolbox/pages/main_controller.dart';
import 'package:utoolbox/pages/main_page.dart';
import 'route_path.dart';

class AppPages {
  AppPages._();
  static final routes = [
    // 入口
    GetPage(
      name: RoutePath.kMain,
      page: () => const MainPage(),
      bindings: [
        BindingsBuilder.put(() => MainController()),
        //BindingsBuilder.put(() => HomeController()),
      ],
    ),

  ];
}
