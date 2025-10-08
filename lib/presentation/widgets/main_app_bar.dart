import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:book_app/core/theme/app_colors.dart';
import 'package:book_app/core/theme/app_text_styles.dart';
import 'package:book_app/presentation/controllers/auth_controller.dart';
import 'package:book_app/presentation/routes/app_routes.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showDrawer;

  const MainAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showDrawer = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
      elevation: 0,
      title: Text(
        title,
        style: AppTextStyles.headline3.copyWith(
          color: AppColors.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
      leading: showDrawer
          ? Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    
    return Drawer(
      child: Column(
        children: [
          // Header
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.primaryVariant],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'IIV MOI',
                      style: AppTextStyles.headline2.copyWith(
                        color: AppColors.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Kitoblar Platformasi',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.onPrimary.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                      final user = authController.currentUser;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?['fullName'] ?? 'Foydalanuvchi',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            user?['email'] ?? '',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.onPrimary.withOpacity(0.8),
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          
          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // Books Section
                _buildSectionHeader('Kitoblar'),
                _buildDrawerItem(
                  icon: Icons.book_outlined,
                  title: 'Barcha Kitoblar',
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(AppRoutes.home);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.school_outlined,
                  title: 'Talabalar Darsliklari',
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(AppRoutes.home, arguments: {'category': 'student_textbooks'});
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.favorite_outline,
                  title: 'Saqlangan Kitoblar',
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(AppRoutes.favorites);
                  },
                ),
                
                const Divider(),
                
                // Other Sections
                _buildSectionHeader('Boshqa'),
                _buildDrawerItem(
                  icon: Icons.search,
                  title: 'Qidirish',
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(AppRoutes.search);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.event_outlined,
                  title: 'Tadbirler',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to events page
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.person_outline,
                  title: 'Profil',
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(AppRoutes.profile);
                  },
                ),
                
                const Divider(),
                
                // Settings and Logout
                _buildDrawerItem(
                  icon: Icons.settings_outlined,
                  title: 'Sozlamalar',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to settings page
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.logout,
                  title: 'Chiqish',
                  onTap: () {
                    Navigator.pop(context);
                    _showLogoutDialog(context, authController);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.onSurface.withOpacity(0.6),
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.onSurface.withOpacity(0.8),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.onSurface,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthController authController) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chiqish'),
        content: const Text('Haqiqatan ham chiqmoqchimisiz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Bekor qilish'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              authController.logout();
            },
            child: const Text(
              'Chiqish',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
