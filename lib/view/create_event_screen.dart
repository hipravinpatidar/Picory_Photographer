import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import '../controllers/language_provider.dart';
import '../controllers/theme_provider.dart';
import '../ui_helpers/app_theme.dart';
import 'event_details_screen.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  DateTime? _selectedDate;
  File? _thumbnail;

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  String _generateAccessCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(6, (index) => chars[random.nextInt(chars.length)]).join();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.royalPurple,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _handleCreateEvent() async {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      setState(() => _isLoading = true);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      final accessCode = _generateAccessCode();

      if (mounted) {
        setState(() => _isLoading = false);

        // Show success dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => _buildSuccessDialog(context, accessCode),
        );
      }
    } else if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select event date')),
      );
    }
  }

  Widget _buildSuccessDialog(BuildContext context, String accessCode) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.successGreen.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: AppTheme.successGreen,
              size: 50,
            ),
          ),
          const SizedBox(height: AppTheme.spacing20),
          const Text(
            'Event Created Successfully!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacing16),
          Text(
            '${languageProvider.getText('access_code')}:',
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.lightTextSecondary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacing20,
              vertical: AppTheme.spacing12,
            ),
            decoration: BoxDecoration(
              color: AppTheme.royalPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              border: Border.all(color: AppTheme.royalPurple),
            ),
            child: Text(
              accessCode,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
                color: AppTheme.royalPurple,
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacing24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Go back to home
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetailsScreen(
                      eventName: _titleController.text,
                      accessCode: accessCode,
                    ),
                  ),
                );
              },
              child: const Text('View Event Details'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _thumbnail = File(pickedFile.path);
      });
    }
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: Consumer<LanguageProvider>(builder: (_, lang , __) {
          return Text(lang.getText('create_event'),style: TextStyle(fontSize: 24),);
        },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacing20),
        child: Consumer2<LanguageProvider, ThemeProvider>(
          builder: (context, languageProvider, themeProvider, _) {
            final isDark = themeProvider.isDarkMode;

            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.spacing20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [

                          /// TITLE
                          TextFormField(
                            controller: _titleController,
                            decoration: _inputDecoration("Title", Icons.title),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Title is required";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          /// DESCRIPTION (Optional)
                          TextFormField(
                            controller: _descriptionController,
                            decoration: _inputDecoration("Description", Icons.description),
                            maxLines: 3,
                          ),

                          const SizedBox(height: 20),

                          /// LOCATION (Optional)
                          TextFormField(
                            controller: _locationController,
                            decoration: _inputDecoration("Location", Icons.location_on),
                          ),

                          const SizedBox(height: 20),

                          /// DATE
                          InkWell(
                            onTap: () => _selectDate(context),
                            child: InputDecorator(
                              decoration: _inputDecoration("Event Date", Icons.calendar_today),
                              child: Text(
                                _selectedDate != null
                                    ? DateFormat('dd-MM-yyyy').format(_selectedDate!)
                                    : "Select Date",
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          /// THUMBNAIL PICKER
                          GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: _thumbnail != null
                                  ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  _thumbnail!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              )
                                  : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image, size: 40, color: Colors.grey),
                                  SizedBox(height: 8),
                                  Text("Pick Thumbnail (Optional)"),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          /// BUTTON
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _handleCreateEvent,
                              child: Text("Create Event"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing20),

                  // Info Card
                  Card(
                    color: AppTheme.royalPurple.withOpacity(0.1),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.spacing16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: AppTheme.royalPurple,
                          ),
                          const SizedBox(width: AppTheme.spacing12),
                          Expanded(
                            child: Text(
                              languageProvider.getText('event_info_note'),
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? AppTheme.darkTextSecondary
                                    : AppTheme.lightTextSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ),
    );
  }
}