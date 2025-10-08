import 'package:flutter/material.dart';
import 'package:book_app/domain/entities/category.dart';
import 'package:book_app/core/theme/app_colors.dart';
import 'package:book_app/core/theme/app_text_styles.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback? onTap;
  
  const CategoryCard({
    super.key,
    required this.category,
    this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: category.isInstitute 
                  ? [AppColors.instituteCategory.withOpacity(0.1), AppColors.instituteCategory.withOpacity(0.05)]
                  : [AppColors.generalCategory.withOpacity(0.1), AppColors.generalCategory.withOpacity(0.05)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: category.isInstitute 
                      ? AppColors.instituteCategory.withOpacity(0.2)
                      : AppColors.generalCategory.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  _getIconData(category.icon),
                  size: 16,
                  color: category.isInstitute 
                      ? AppColors.instituteCategory
                      : AppColors.generalCategory,
                ),
              ),
              
              const SizedBox(height: 6),
              
              // Title
              Text(
                category.name,
                style: AppTextStyles.headline3.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
  
  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'school':
        return Icons.school;
      case 'book':
        return Icons.book;
      case 'law':
        return Icons.gavel;
      case 'psychology':
        return Icons.psychology;
      case 'security':
        return Icons.security;
      case 'business':
        return Icons.business;
      case 'history':
        return Icons.history_edu;
      case 'science':
        return Icons.science;
      case 'motivation':
        return Icons.trending_up;
      default:
        return Icons.category;
    }
  }
}
