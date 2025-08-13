// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class BottomBarWidget extends StatelessWidget {
//   const BottomBarWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       BottomNavigationBarController bottomNavBarController = Get.find();
//       return BottomNavigationBar(
//         currentIndex: bottomNavBarController.selectedIndex.value,
//         backgroundColor: AppColors.black2,
//         showUnselectedLabels: true,
//         showSelectedLabels: true,
//         useLegacyColorScheme: true,
//         unselectedItemColor: AppColors.textGrey,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: "Home",
//             backgroundColor: AppColors.black2,
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: AppColors.black2,
//             icon: Icon(Icons.search),
//             label: "Search",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: "Visa",
//             backgroundColor: AppColors.black2,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat),
//             label: "Chat",
//             backgroundColor: AppColors.black2,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: "Profile",
//             backgroundColor: AppColors.black2,
//           ),
//         ],
//         // index: controller.selectedIndex.value,
//         onTap: (index) {
//           bottomNavBarController.onItemTapped(index);
//         },
//       );
//     });
//   }
// }
