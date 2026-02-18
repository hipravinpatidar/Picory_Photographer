import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../controllers/language_provider.dart';
import '../controllers/theme_provider.dart';
import '../ui_helpers/app_theme.dart';

class PhotosScreen extends StatefulWidget {
  final String eventName;

  const PhotosScreen({super.key, required this.eventName});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  final Set<int> _selectedPhotos = {};
  bool _isSelectionMode = false;
  bool _isUploading = false;
  double _uploadProgress = 0.0;

  // Sample photo data
  final List<Map<String, dynamic>> _photos = List.generate(
    20,
        (index) => {
      'id': index,
      'height': 150.0 + (index % 3) * 50,
    },
  );

  void _toggleSelection(int photoId) {
    setState(() {
      if (_selectedPhotos.contains(photoId)) {
        _selectedPhotos.remove(photoId);
        if (_selectedPhotos.isEmpty) {
          _isSelectionMode = false;
        }
      } else {
        _selectedPhotos.add(photoId);
        _isSelectionMode = true;
      }
    });
  }

  void _selectAll() {
    setState(() {
      if (_selectedPhotos.length == _photos.length) {
        _selectedPhotos.clear();
        _isSelectionMode = false;
      } else {
        _selectedPhotos.addAll(_photos.map((p) => p['id'] as int));
        _isSelectionMode = true;
      }
    });
  }

  void _deleteSelected() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Photos'),
        content: Text('Are you sure you want to delete ${_selectedPhotos.length} photos?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _photos.removeWhere((photo) => _selectedPhotos.contains(photo['id']));
                _selectedPhotos.clear();
                _isSelectionMode = false;
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.errorRed),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _uploadPhotos() async {
    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
    });

    // Simulate upload progress
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(const Duration(milliseconds: 200));
      if (mounted) {
        setState(() {
          _uploadProgress = i / 100;
        });
      }
    }

    if (mounted) {
      setState(() {
        _isUploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Photos uploaded successfully'),
          backgroundColor: AppTheme.successGreen,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageProvider, ThemeProvider>(
      builder: (context, languageProvider, themeProvider, _) {
        final isDark = themeProvider.isDarkMode;

        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.eventName),
                Text(
                  '${_photos.length} ${languageProvider.getText('total_photos')}',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? AppTheme.darkTextSecondary
                        : AppTheme.lightTextSecondary,
                  ),
                ),
              ],
            ),
            actions: [
              if (_isSelectionMode)
                IconButton(
                  onPressed: _selectAll,
                  icon: Icon(
                    _selectedPhotos.length == _photos.length
                        ? Icons.deselect_rounded
                        : Icons.select_all_rounded,
                  ),
                ),
              if (_isSelectionMode)
                IconButton(
                  onPressed: _deleteSelected,
                  icon: const Icon(Icons.delete_rounded),
                  color: AppTheme.errorRed,
                ),
            ],
          ),

          body: Column(
            children: [

              // Upload Progress
              if (_isUploading)
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacing16),
                  color: isDark
                      ? AppTheme.darkSurface
                      : AppTheme.lightSurface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            languageProvider.getText('uploading_photos'),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${(_uploadProgress * 100).toInt()}%',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.royalPurple,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.spacing8),
                      LinearProgressIndicator(
                        value: _uploadProgress,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppTheme.royalPurple,
                        ),
                      ),
                    ],
                  ),
                ),

              // Selection Info
              if (_isSelectionMode)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacing16,
                    vertical: AppTheme.spacing12,
                  ),
                  color: AppTheme.royalPurple.withOpacity(0.1),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        color: AppTheme.royalPurple,
                        size: 20,
                      ),
                      const SizedBox(width: AppTheme.spacing8),
                      Text(
                        '${_selectedPhotos.length} ${languageProvider.getText('selected')}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.royalPurple,
                        ),
                      ),
                    ],
                  ),
                ),

              // Photos Grid
              Expanded(
                child: _photos.isEmpty
                    ? _buildEmptyState(languageProvider)
                    : MasonryGridView.count(
                  padding:
                  const EdgeInsets.all(AppTheme.spacing12),
                  crossAxisCount: 2,
                  mainAxisSpacing: AppTheme.spacing12,
                  crossAxisSpacing:
                  AppTheme.spacing12,
                  itemCount: _photos.length,
                  itemBuilder: (context, index) {
                    final photo = _photos[index];
                    final photoId =
                    photo['id'] as int;
                    final isSelected =
                    _selectedPhotos.contains(photoId);

                    return GestureDetector(
                      onTap: () {
                        if (_isSelectionMode) {
                          _toggleSelection(photoId);
                        }
                      },
                      onLongPress: () {
                        _toggleSelection(photoId);
                      },
                      child: _buildPhotoCard(
                        photo,
                        isSelected,
                        isDark,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          floatingActionButton:
          FloatingActionButton.extended(
            onPressed: _uploadPhotos,
            backgroundColor: AppTheme.royalPurple,
            icon: const Icon(
                Icons.add_photo_alternate_rounded),
            label: Text(
              languageProvider.getText('add_photos'),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhotoCard(Map<String, dynamic> photo, bool isSelected, bool isDark) {
    return Stack(
      children: [
        Container(
          height: photo['height'] as double,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.royalPurple.withOpacity(0.3),
                AppTheme.accentPurple.withOpacity(0.3),
              ],
            ),
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            border: Border.all(
              color: isSelected ? AppTheme.royalPurple : Colors.transparent,
              width: 3,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Icon(
                  Icons.image_rounded,
                  size: 50,
                  color: AppTheme.royalPurple.withOpacity(0.4),
                ),
                if (isSelected)
                  Container(
                    color: AppTheme.royalPurple.withOpacity(0.3),
                  ),
              ],
            ),
          ),
        ),
        if (isSelected)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: AppTheme.royalPurple,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyState(LanguageProvider languageProvider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppTheme.royalPurple.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.photo_library_rounded,
              size: 50,
              color: AppTheme.royalPurple.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: AppTheme.spacing20),
          const Text(
            'No Photos Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          Text(
            'Upload photos to get started',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}