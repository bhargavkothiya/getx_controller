import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/bottom_nav_controller.dart';

class BottomNavScreen extends StatelessWidget {
  BottomNavScreen({super.key});

  final BottomNavController bottomNavController = Get.put(
    BottomNavController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          children: [
            bottomNavController.screen[bottomNavController.currentIndex.value],
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        final currentIndex = bottomNavController.currentIndex.value;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              currentIndex == 0
                  ? SizedBox.shrink()
                  : Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          bottomNavController.previousScreen();
                        },
                        child: Text("Previous"),
                      ),
                    ),

              currentIndex == bottomNavController.screen.length - 1
                  ? SizedBox.shrink()
                  : Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          bottomNavController.nextScreen();
                        },
                        child: Text("Next"),
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }
}
