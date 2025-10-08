import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:book_app/core/theme/app_colors.dart';
import 'package:book_app/presentation/routes/app_routes.dart';

class BottomNavigationWidget extends StatelessWidget {
  final int currentIndex;
  
  const BottomNavigationWidget({
    super.key,
    required this.currentIndex,
  });
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey[600],
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      onTap: (index) {
        switch (index) {
          case 0:
            Get.offAllNamed(AppRoutes.home);
            break;
          case 1:
            Get.toNamed(AppRoutes.search);
            break;
          case 2:
            Get.toNamed(AppRoutes.favorites);
            break;
          case 3:
            Get.toNamed(AppRoutes.profile);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Bosh sahifa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Qidiruv',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Saqlanganlar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }
}
