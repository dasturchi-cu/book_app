import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:book_app/core/theme/app_colors.dart';
import 'package:book_app/core/theme/app_text_styles.dart';
import 'package:book_app/presentation/widgets/main_app_bar.dart';
import 'package:book_app/data/datasources/institute_api_services.dart';

class VideoLessonsPage extends StatefulWidget {
  const VideoLessonsPage({super.key});

  @override
  State<VideoLessonsPage> createState() => _VideoLessonsPageState();
}

class _VideoLessonsPageState extends State<VideoLessonsPage> {
  final VideoLessonsApiService _apiService = VideoLessonsApiService();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<Map<String, dynamic>> videoLessons = <Map<String, dynamic>>[].obs;

  @override
  void initState() {
    super.initState();
    _loadVideoLessons();
  }

  Future<void> _loadVideoLessons() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final lessons = await _apiService.getAllVideoLessons();
      videoLessons.value = lessons;
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Xatolik',
        'Video darslarni yuklashda xatolik: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const MainAppBar(title: 'Video Darslar'),
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
                  colors: [AppColors.primary, AppColors.primaryVariant],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Video Darslar',
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Institut xodimlari uchun maxsus video darslar',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.onPrimary.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Categories section
            Text(
              'Kategoriyalar',
              style: AppTextStyles.headlineSmall.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            
            // Video categories grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildVideoCategoryCard(
                  'Texnik Fanlar',
                  Icons.engineering,
                  Colors.blue,
                  () => _showComingSoon(),
                ),
                _buildVideoCategoryCard(
                  'Ijtimoiy Fanlar',
                  Icons.people,
                  Colors.green,
                  () => _showComingSoon(),
                ),
                _buildVideoCategoryCard(
                  'Tabiiy Fanlar',
                  Icons.science,
                  Colors.orange,
                  () => _showComingSoon(),
                ),
                _buildVideoCategoryCard(
                  'Til va Adabiyot',
                  Icons.menu_book,
                  Colors.purple,
                  () => _showComingSoon(),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Recent videos section
            Text(
              'So\'nggi Video Darslar',
              style: AppTextStyles.headlineSmall.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            
            // Video list from API
            Obx(() {
              if (isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              }
              
              if (errorMessage.value.isNotEmpty) {
                return Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        errorMessage.value,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadVideoLessons,
                        child: const Text('Qayta Urinish'),
                      ),
                    ],
                  ),
                );
              }
              
              if (videoLessons.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.video_library_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Video darslar topilmadi',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }
              
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: videoLessons.length,
                itemBuilder: (context, index) {
                  final lesson = videoLessons[index];
                  return _buildVideoItem(
                    lesson['title'] ?? 'Video Dars ${index + 1}',
                    lesson['description'] ?? 'Bu video darsda muhim mavzular ko\'rib chiqiladi',
                    lesson['duration'] ?? '45:30',
                    lesson['createdAt'] ?? '2 kun oldin',
                    lesson['videoUrl'],
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoCategoryCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: color,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoItem(
    String title,
    String description,
    String duration,
    String date,
    String? videoUrl,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => _showComingSoon(),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Video thumbnail placeholder
              Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.play_circle_outline,
                  size: 30,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 16),
              // Video info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.onSurface.withOpacity(0.7),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: AppColors.onSurface.withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          duration,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.onSurface.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: AppColors.onSurface.withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          date,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoon() {
    Get.snackbar(
      'Tez orada',
      'Video darslar tez orada qo\'shiladi',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary,
      colorText: AppColors.onPrimary,
      duration: const Duration(seconds: 2),
    );
  }
}
