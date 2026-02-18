import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picory_app/view/photos_screen.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/language_provider.dart';
import '../controllers/theme_provider.dart';
import '../ui_helpers/app_theme.dart';


class EventDetailsScreen extends StatefulWidget {
  final String eventName;
  final String? accessCode;

  const EventDetailsScreen({
    super.key,
    required this.eventName,
    this.accessCode,
  });

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late String _accessCode;
  bool _allowDownload = true;
  bool _allowShare = true;
  bool _allowScreenshot = false;
  bool _allowFaceScan = true;

  @override
  void initState() {
    super.initState();
    _accessCode = widget.accessCode ?? 'ABC123';
  }

  void _copyAccessCode() {
    Clipboard.setData(ClipboardData(text: _accessCode));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Access code copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _handleSubmit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Permissions updated successfully'),
        backgroundColor: AppTheme.successGreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageProvider, ThemeProvider>(
      builder: (context, languageProvider, themeProvider, _) {
        final isDark = themeProvider.isDarkMode;

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.eventName),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert_rounded),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacing20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                // Access Code & QR Card
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.spacing20),
                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  languageProvider.getText('access_code'),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isDark
                                        ? AppTheme.darkTextSecondary
                                        : AppTheme.lightTextSecondary,
                                  ),
                                ),
                                const SizedBox(height: AppTheme.spacing8),
                                Text(
                                  _accessCode,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 4,
                                    color: AppTheme.royalPurple,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: _copyAccessCode,
                              icon: const Icon(Icons.copy_rounded),
                              style: IconButton.styleFrom(
                                backgroundColor:
                                AppTheme.royalPurple.withOpacity(0.1),
                                foregroundColor: AppTheme.royalPurple,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppTheme.spacing24),

                        // QR Code
                        Container(
                          padding: const EdgeInsets.all(AppTheme.spacing16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(AppTheme.radiusMedium),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            children: [
                              QrImageView(
                                data: _accessCode,
                                version: QrVersions.auto,
                                size: 200,
                                backgroundColor: Colors.white,
                              ),
                              const SizedBox(height: AppTheme.spacing12),
                              Text(
                                languageProvider.getText('qr_code'),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacing20),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon:
                        const Icon(Icons.add_photo_alternate_rounded),
                        label: Text(
                          languageProvider.getText('add_photos'),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppTheme.spacing16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacing12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.attach_file_rounded),
                        label:
                        Text(languageProvider.getText('add_files')),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppTheme.spacing16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacing24),

                // Permissions
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.spacing20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          languageProvider.getText('permissions'),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: AppTheme.spacing16),

                        _buildPermissionSwitch(
                          languageProvider.getText('allow_download'),
                          Icons.download_rounded,
                          _allowDownload,
                              (v) => setState(() => _allowDownload = v),
                        ),

                        const Divider(height: AppTheme.spacing24),

                        _buildPermissionSwitch(
                          languageProvider.getText('allow_share'),
                          Icons.share_rounded,
                          _allowShare,
                              (v) => setState(() => _allowShare = v),
                        ),

                        const Divider(height: AppTheme.spacing24),

                        _buildPermissionSwitch(
                          languageProvider.getText('allow_screenshot'),
                          Icons.screenshot_rounded,
                          _allowScreenshot,
                              (v) => setState(() => _allowScreenshot = v),
                        ),

                        const Divider(height: AppTheme.spacing24),

                        _buildPermissionSwitch(
                          languageProvider.getText('allow_face_scan'),
                          Icons.face_rounded,
                          _allowFaceScan,
                              (v) => setState(() => _allowFaceScan = v),
                        ),

                        const SizedBox(height: AppTheme.spacing24),

                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _handleSubmit,
                            child: Text(
                              languageProvider.getText('submit'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacing20),

                // View Photos
                SizedBox(
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PhotosScreen(eventName: widget.eventName),
                        ),
                      );
                    },
                    icon:
                    const Icon(Icons.photo_library_rounded),
                    label: Text(
                      languageProvider.getText('view_photos'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPermissionSwitch(
      String title,
      IconData icon,
      bool value,
      Function(bool) onChanged,
      ) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.royalPurple.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
          ),
          child: Icon(
            icon,
            color: AppTheme.royalPurple,
            size: 20,
          ),
        ),
        const SizedBox(width: AppTheme.spacing12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppTheme.royalPurple,
        ),
      ],
    );
  }
}