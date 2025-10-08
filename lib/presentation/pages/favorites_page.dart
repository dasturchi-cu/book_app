import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:book_app/presentation/controllers/book_controller.dart';
import 'package:book_app/presentation/widgets/book_card.dart';
import 'package:book_app/presentation/routes/app_routes.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Books')),
      body: GetBuilder<BookController>(
        builder: (controller) => Obx(() {
          if (controller.favoriteBooks.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No favorite books yet'),
                  SizedBox(height: 8),
                  Text('Add books to your favorites to see them here'),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: controller.favoriteBooks.length,
            itemBuilder: (context, index) {
              final book = controller.favoriteBooks[index];
              return BookCard(
                book: book,
                onTap: () =>
                    Get.toNamed(AppRoutes.bookDetails, arguments: book),
                onFavorite: () => controller.toggleFavorite(book.id),
              );
            },
          );
        }),
      ),
    );
  }
}
