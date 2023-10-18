import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:utoolbox/pages/home/home_controller.dart';
import 'package:utoolbox/pages/home/home_view.dart';

import '../app/constant.dart';
import '../app/event_bus.dart';

class MainController extends GetxController {
  RxList<HomePageItem> items = RxList<HomePageItem>([]);

  var index = 0.obs;
  RxList<Widget> pages = RxList<Widget>([
    const SizedBox(),
    const SizedBox(),
    const SizedBox(),
    const SizedBox(),
  ]);

  void setIndex(int i) {
    if (pages[i] is SizedBox) {
      switch (items[i].index) {
        case 0:
          Get.put(HomeController());
          pages[i] = const HomePage();
          break;
        // case 1:
        //   Get.put(FollowUserController());
        //   pages[i] = const FollowUserPage();
        //   break;
        // case 2:
        //   Get.put(CategoryController());
        //   pages[i] = const CategoryPage();
        //   break;
        // case 3:
        //   pages[i] = const UserPage();
        //   break;
        default:
      }
    } else {
      if (index.value == i) {
        EventBus.instance
            .emit<int>(EventBus.kBottomNavigationBarClicked, items[i].index);
      }
    }

    index.value = i;
  }

  @override
  void onInit() {
    // Future.delayed(Duration.zero, showFirstRun);
    // items.value = AppSettingsController.instance.homeSort
    //     .map((key) => Constant.allHomePages[key]!)
    //     .toList();
    // setIndex(0);
    super.onInit();
  }

  void showFirstRun() async {

  }
}
