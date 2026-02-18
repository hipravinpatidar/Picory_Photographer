import 'package:flutter/material.dart';
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
  final _eventNameController = TextEditingController();
  final _dealAmountController = TextEditingController();
  final _amountReceivedController = TextEditingController();
  DateTime? _selectedDate;
  bool _isLoading = false;

  @override
  void dispose() {
    _eventNameController.dispose();
    _dealAmountController.dispose();
    _amountReceivedController.dispose();
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
                      eventName: _eventNameController.text,
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Consumer<LanguageProvider>(builder: (_, lang , __) {
          return Text(lang.getText('create_event'));
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

                          // Event Name
                          TextFormField(
                            controller: _eventNameController,
                            decoration: InputDecoration(
                              labelText: languageProvider.getText('event_name'),
                              prefixIcon: const Icon(Icons.event_rounded),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return languageProvider.getText('event_name_required');
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: AppTheme.spacing20),

                          // Event Date
                          InkWell(
                            onTap: () => _selectDate(context),
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: languageProvider.getText('event_date'),
                                prefixIcon: const Icon(Icons.calendar_today_rounded),
                              ),
                              child: Text(
                                _selectedDate != null
                                    ? DateFormat('dd MMM yyyy').format(_selectedDate!)
                                    : languageProvider.getText('select_date'),
                                style: TextStyle(
                                  color: _selectedDate != null
                                      ? (isDark
                                      ? AppTheme.darkTextPrimary
                                      : AppTheme.lightTextPrimary)
                                      : (isDark
                                      ? AppTheme.darkTextSecondary
                                      : AppTheme.lightTextSecondary),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: AppTheme.spacing20),

                          // Deal Amount
                          TextFormField(
                            controller: _dealAmountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: languageProvider.getText('deal_amount'),
                              prefixIcon: const Icon(Icons.currency_rupee_rounded),
                              hintText: languageProvider.getText('amount_hint'),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return languageProvider.getText('deal_amount_required');
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: AppTheme.spacing20),

                          // Amount Received
                          TextFormField(
                            controller: _amountReceivedController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: languageProvider.getText('amount_received'),
                              prefixIcon: const Icon(Icons.payments_rounded),
                              hintText: languageProvider.getText('amount_hint'),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return languageProvider.getText('amount_received_required');
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: AppTheme.spacing32),

                          // Create Button
                          SizedBox(
                            height: 50,
                            child: ElevatedButton.icon(
                              onPressed: _isLoading ? null : _handleCreateEvent,
                              icon: _isLoading
                                  ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                                  : const Icon(Icons.add_circle_rounded),
                              label: Text(languageProvider.getText('create_event')),
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