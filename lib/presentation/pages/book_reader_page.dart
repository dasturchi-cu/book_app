import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:book_app/domain/entities/book.dart';
import 'package:book_app/core/theme/app_colors.dart';
import 'package:book_app/core/theme/app_text_styles.dart';

class BookReaderPage extends StatefulWidget {
  final Book book;

  const BookReaderPage({
    super.key,
    required this.book,
  });

  @override
  State<BookReaderPage> createState() => _BookReaderPageState();
}

class _BookReaderPageState extends State<BookReaderPage> {
  late TextEditingController _pageController;
  int _currentPage = 1;
  int _totalPages = 0;
  bool _isLoading = true;
  String? _errorMessage;
  PDFViewController? _pdfViewController;

  @override
  void initState() {
    super.initState();
    _pageController = TextEditingController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => Get.back(),
        ),
        title: Text(
          widget.book.title,
          style: AppTextStyles.headline3.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          // Page navigation
          if (_totalPages > 0) ...[
            IconButton(
              icon: const Icon(Icons.first_page, color: AppColors.onSurface),
              onPressed: _currentPage > 1 ? _goToFirstPage : null,
            ),
            IconButton(
              icon: const Icon(Icons.navigate_before, color: AppColors.onSurface),
              onPressed: _currentPage > 1 ? _goToPreviousPage : null,
            ),
            Container(
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                controller: _pageController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: AppTextStyles.bodyMedium,
                decoration: InputDecoration(
                  hintText: '$_currentPage',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.onSurface.withOpacity(0.3)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
                onSubmitted: _goToPage,
              ),
            ),
            Text(
              '/ $_totalPages',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onSurface.withOpacity(0.7),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.navigate_next, color: AppColors.onSurface),
              onPressed: _currentPage < _totalPages ? _goToNextPage : null,
            ),
            IconButton(
              icon: const Icon(Icons.last_page, color: AppColors.onSurface),
              onPressed: _currentPage < _totalPages ? _goToLastPage : null,
            ),
          ],
          // Settings
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppColors.onSurface),
            onSelected: _onMenuSelected,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'bookmark',
                child: Row(
                  children: [
                    Icon(Icons.bookmark_border),
                    SizedBox(width: 8),
                    Text('Bookmark'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'search',
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 8),
                    Text('Search'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'zoom',
                child: Row(
                  children: [
                    Icon(Icons.zoom_in),
                    SizedBox(width: 8),
                    Text('Zoom'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading PDF',
              style: AppTextStyles.headline3.copyWith(
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage!,
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _errorMessage = null;
                  _isLoading = true;
                });
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading PDF...'),
          ],
        ),
      );
    }

    // Check if book has PDF content
    if (widget.book.content == null || widget.book.content!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.book_outlined,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'No PDF available',
              style: AppTextStyles.headline3.copyWith(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This book does not have a PDF version available.',
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return PDFView(
      filePath: widget.book.content!,
      enableSwipe: true,
      swipeHorizontal: false,
      autoSpacing: false,
      pageFling: true,
      pageSnap: true,
      onRender: (pages) {
        setState(() {
          _isLoading = false;
          _totalPages = pages ?? 0;
          _currentPage = 1;
          _pageController.text = '1';
        });
      },
      onViewCreated: (PDFViewController controller) {
        _pdfViewController = controller;
      },
      onPageChanged: (page, total) {
        setState(() {
          _currentPage = page! + 1;
          _pageController.text = _currentPage.toString();
        });
      },
      onError: (error) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to load PDF: $error';
        });
      },
    );
  }

  void _goToFirstPage() {
    _pdfViewController?.setPage(0);
  }

  void _goToPreviousPage() {
    if (_currentPage > 1) {
      _pdfViewController?.setPage(_currentPage - 2);
    }
  }

  void _goToNextPage() {
    if (_currentPage < _totalPages) {
      _pdfViewController?.setPage(_currentPage);
    }
  }

  void _goToLastPage() {
    _pdfViewController?.setPage(_totalPages - 1);
  }

  void _goToPage(String pageText) {
    final pageNumber = int.tryParse(pageText);
    if (pageNumber != null && pageNumber >= 1 && pageNumber <= _totalPages) {
      _pdfViewController?.setPage(pageNumber - 1);
    } else {
      _pageController.text = '$_currentPage';
    }
  }

  void _onMenuSelected(String value) {
    switch (value) {
      case 'bookmark':
        _showBookmarkDialog();
        break;
      case 'search':
        _showSearchDialog();
        break;
      case 'zoom':
        _showZoomDialog();
        break;
    }
  }

  void _showBookmarkDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Bookmark'),
        content: const Text('Bookmark functionality will be implemented in future updates.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search in PDF'),
        content: const Text('Search functionality will be implemented in future updates.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showZoomDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Zoom Options'),
        content: const Text('Zoom functionality will be implemented in future updates.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}