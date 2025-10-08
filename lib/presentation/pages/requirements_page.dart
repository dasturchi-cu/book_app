import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:book_app/core/theme/app_colors.dart';
import 'package:book_app/core/theme/app_text_styles.dart';
import 'package:book_app/presentation/widgets/main_app_bar.dart';

class RequirementsPage extends StatelessWidget {
  const RequirementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const MainAppBar(title: 'Talablar'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.secondary, AppColors.secondaryVariant],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Institut Talablari',
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.onSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Institut xodimlari uchun muhim talablar va qoidalar',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.onSecondary.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Requirements sections
            _buildRequirementSection(
              'Umumiy Talablar',
              Icons.rule,
              Colors.blue,
              [
                'Institut qoidalariga rioya qilish',
                'Ish vaqti: 8:00 - 17:00',
                'Haftalik hisobot taqdim etish',
                'Majburiyatlar va mas\'uliyatlar',
              ],
            ),
            
            const SizedBox(height: 20),
            
            _buildRequirementSection(
              'Texnik Talablar',
              Icons.computer,
              Colors.green,
              [
                'Kompyuter savodxonligi',
                'Ofis dasturlarini bilish',
                'Internet va elektron pochta',
                'Texnik vositalar bilan ishlash',
              ],
            ),
            
            const SizedBox(height: 20),
            
            _buildRequirementSection(
              'Pedagogik Talablar',
              Icons.school,
              Colors.orange,
              [
                'O\'qituvchilik tajribasi',
                'Fan sohasidagi bilimlar',
                'O\'quv materiallarini tayyorlash',
                'Talabalar bilan ishlash',
              ],
            ),
            
            const SizedBox(height: 20),
            
            _buildRequirementSection(
              'Ma\'muriy Talablar',
              Icons.admin_panel_settings,
              Colors.purple,
              [
                'Hujjatlarni to\'g\'ri rasmiylashtirish',
                'Hisobotlar va statistikalar',
                'Boshqaruv tizimi bilan ishlash',
                'Ichki tartib qoidalari',
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showComingSoon(),
                    icon: const Icon(Icons.download),
                    label: const Text('Talablarni Yuklab Olish'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showComingSoon(),
                    icon: const Icon(Icons.print),
                    label: const Text('Chop Etish'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementSection(
    String title,
    IconData icon,
    Color color,
    List<String> requirements,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...requirements.map((requirement) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: color,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      requirement,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.onSurface.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  void _showComingSoon() {
    Get.snackbar(
      'Tez orada',
      'Bu funksiya tez orada qo\'shiladi',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary,
      colorText: AppColors.onPrimary,
      duration: const Duration(seconds: 2),
    );
  }
}
