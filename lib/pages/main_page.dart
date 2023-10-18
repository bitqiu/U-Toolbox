import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main_controller.dart';

class MainPage extends GetView<MainController> {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => IndexedStack(
          index: controller.index.value,
          children: controller.pages,
        ),
      ),
      // bottomNavigationBar: Obx(
      //       () => NavigationBar(
      //     selectedIndex: controller.index.value,
      //     onDestinationSelected: controller.setIndex,
      //     height: 56,
      //     labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      //     destinations: controller.items
      //         .map(
      //           (item) => NavigationDestination(
      //         icon: Icon(item.iconData),
      //         label: item.title,
      //       ),
      //     )
      //         .toList(),
      //   ),
      // ),
    );
  }
}
