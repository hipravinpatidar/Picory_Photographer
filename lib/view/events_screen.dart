import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/language_provider.dart';
import '../ui_helpers/app_theme.dart';
import 'event_details_screen.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<LanguageProvider>(
          builder: (context, lp, _) {
            return Text(lp.getText('events'));
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buildEventListItem(context, index);
        },
      ),
    );
  }

  Widget _buildEventListItem(BuildContext context, int index) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;

    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing16),
      decoration: BoxDecoration(
        // 🔥 LIGHT = WHITE | DARK = GRADIENT
        color: isDark ? null : Colors.white,
        gradient: isDark
            ? const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.darkSurface,
            AppTheme.deepBlue,
          ],
        )
            : null,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.45)
                : Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  EventDetailsScreen(eventName: 'Event ${index + 1}'),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing12),
          child: Row(
            children: [
              // ================= DATE BLOCK =================
              Container(
                width: 60,
                height: 70,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.08)
                      : primaryColor.withOpacity(0.08),
                  borderRadius:
                  BorderRadius.circular(AppTheme.radiusMedium),
                  border: Border.all(
                    color: primaryColor.withOpacity(0.25),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "15",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "FEB",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: AppTheme.spacing16),

              // ================= INFO =================
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Event ${index + 1}',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 14,
                          color: isDark
                              ? AppTheme.darkTextSecondary
                              : AppTheme.lightTextSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Mumbai, India',
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark
                                ? AppTheme.darkTextSecondary
                                : AppTheme.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ================= ARROW =================
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.08)
                      : Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
