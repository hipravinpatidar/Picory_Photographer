import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/language_provider.dart';
import '../controllers/theme_provider.dart';
import '../ui_helpers/app_theme.dart';
import 'create_event_screen.dart';
import 'event_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.royalPurple, AppTheme.accentPurple],
                ),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              ),
              child: const Icon(
                Icons.camera_alt_rounded,
                size: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Text(languageProvider.getText('app_name')),
          ],
        ),
        actions: [
          // Language Toggle
          Container(
            margin: const EdgeInsets.only(right: AppTheme.spacing8),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              border: Border.all(
                color: isDark ? const Color(0xFF2A2A3E) : Colors.grey.shade300,
              ),
            ),
            child: Row(
              children: [
                _buildLanguageButton(context, 'EN', !languageProvider.isHindi, () {
                  if (languageProvider.isHindi) languageProvider.toggleLanguage();
                }),
                _buildLanguageButton(context, 'हिं', languageProvider.isHindi, () {
                  if (!languageProvider.isHindi) languageProvider.toggleLanguage();
                }),
              ],
            ),
          ),

          // Theme Toggle
          Container(
            height: 42,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? const Color(0xFF1E1E2E) : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: isDark ? AppTheme.royalPurple.withOpacity(0.3) : Colors.grey.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: IconButton(
              onPressed: () => themeProvider.toggleTheme(),
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, anim) => RotationTransition(turns: anim, child: child),
                child: Icon(
                  isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  key: ValueKey(isDark), // Necessary for AnimatedSwitcher
                  color: isDark ? Colors.amber : AppTheme.royalPurple,
                  size: 22,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacing20),
        child: Consumer2<LanguageProvider, ThemeProvider>(
          builder: (context, languageProvider, themeProvider, _) {
            final isDark = themeProvider.isDarkMode;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                // Active Plan Card
                _buildPlanCard(context, languageProvider, isDark),
                const SizedBox(height: AppTheme.spacing20),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateEventScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add_rounded),
                        label: Text(languageProvider.getText('create_event')),
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
                        icon: const Icon(Icons.upgrade_rounded),
                        label: Text(languageProvider.getText('upgrade_plan')),
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

                // Events Header
                Text(
                  languageProvider.getText('events'),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppTheme.darkTextPrimary
                        : AppTheme.lightTextPrimary,
                  ),
                ),
                const SizedBox(height: AppTheme.spacing16),

                // Events Grid
                _buildEventsGrid(context, languageProvider, isDark),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLanguageButton(BuildContext context, String text, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing12,
          vertical: AppTheme.spacing8,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.royalPurple : Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : AppTheme.royalPurple,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, LanguageProvider languageProvider, bool isDark) {
    return Card(
      elevation: 4,
      shadowColor: AppTheme.royalPurple.withOpacity(0.2),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppTheme.royalPurple, AppTheme.deepBlue],
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        ),
        padding: const EdgeInsets.all(AppTheme.spacing20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  languageProvider.getText('active_plan'),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacing12,
                    vertical: AppTheme.spacing4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.successGreen,
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                  ),
                  child: const Text(
                    'Active',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing8),
            const Text(
              'Professional Plan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  color: Colors.white.withOpacity(0.8),
                  size: 16,
                ),
                const SizedBox(width: AppTheme.spacing8),
                Text(
                  '${languageProvider.getText('plan_expires')}: 31 Dec 2026',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventsGrid(BuildContext context, LanguageProvider languageProvider, bool isDark) {
    // Sample events data
    final events = [
      {
        'name': 'Wedding Photography',
        'date': '15 Feb 2026',
        'photos': 350,
        'thumbnails': 4,
      },
      {
        'name': 'Birthday Party',
        'date': '20 Feb 2026',
        'photos': 120,
        'thumbnails': 3,
      },
      {
        'name': 'Corporate Event',
        'date': '25 Feb 2026',
        'photos': 200,
        'thumbnails': 5,
      },
      {
        'name': 'Engagement Shoot',
        'date': '28 Feb 2026',
        'photos': 85,
        'thumbnails': 2,
      },
      {
        'name': 'Wedding Photography',
        'date': '15 Feb 2026',
        'photos': 350,
        'thumbnails': 4,
      },
      {
        'name': 'Birthday Party',
        'date': '20 Feb 2026',
        'photos': 120,
        'thumbnails': 3,
      },
      {
        'name': 'Corporate Event',
        'date': '25 Feb 2026',
        'photos': 200,
        'thumbnails': 5,
      },
      {
        'name': 'Engagement Shoot',
        'date': '28 Feb 2026',
        'photos': 85,
        'thumbnails': 2,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(), // Allow natural feel if needed
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppTheme.spacing16,
        mainAxisSpacing: AppTheme.spacing20,
        childAspectRatio: 0.78, // Slightly taller for a more cinematic look
      ),
      itemCount: events.length,
      itemBuilder: (context, index) {
        return _buildEventCard(context, events[index], languageProvider, isDark);
      },
    );
  }

  Widget _buildEventCard(BuildContext context, Map<String, dynamic> event, LanguageProvider languageProvider, bool isDark) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary; // Electric Teal

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radiusXLarge),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black54 : primaryColor.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.radiusXLarge),
        child: Stack(
          children: [
            // 1. Full Background Image / Placeholder
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor.withOpacity(0.2),
                      AppTheme.deepBlue,
                    ],
                  ),
                ),
                child: Opacity(
                  opacity: 0.5,
                  child: Icon(
                    Icons.collections_rounded,
                    size: 50,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
              ),
            ),

            // 2. Stylish Top Tag (Total Photos)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24, width: 0.5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.auto_awesome, size: 12, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      '${event['photos']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 3. Bottom Content with Blur/Gradient
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.9),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event['name'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Date Row
                        Row(
                          children: [
                            Icon(Icons.calendar_month_outlined,
                                size: 14, color: primaryColor),
                            const SizedBox(width: 5),
                            Text(
                              event['date'] as String,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        // "View" Button Style label
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.arrow_forward_ios_rounded,
                              size: 10, color: primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 4. InkWell for Tap Action
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: primaryColor.withOpacity(0.1),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailsScreen(
                            eventName: event['name'] as String
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}