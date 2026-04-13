import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/language_provider.dart';
import '../controllers/theme_provider.dart';
import '../ui_helpers/app_theme.dart';
import 'subsicription_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageProvider, ThemeProvider>(
      builder: (context, lp, themeProvider, child) {
        final isDark = themeProvider.isDarkMode;
        final primaryColor = Theme.of(context).colorScheme.primary;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              /// ===== Enhanced Sliver AppBar with Wave Effect =====
              SliverAppBar(
                expandedHeight: 320,
                pinned: true,
                backgroundColor: primaryColor,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      /// Gradient Background
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              primaryColor,
                              AppTheme.deepBlue,
                              AppTheme.royalPurple,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),

                      /// Decorative Circles
                      Positioned(
                        top: -50,
                        right: -50,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -30,
                        left: -30,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),

                      /// Profile Content
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 60),

                          /// Animated Profile Avatar with Glow
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.3),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3,
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Colors.white.withOpacity(0.8),
                                      ],
                                    ),
                                  ),
                                  child: const CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.person_rounded,
                                      size: 70,
                                      color: AppTheme.deepBlue,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          /// Profile Name with Badge
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                lp.getText('profile_name'),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'PRO',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          /// Email with Icon
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.email_outlined,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'john@photographer.com',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /// ===== Styled Curved Sections =====
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    /// Top Curved Container
                    ClipPath(
                      clipper: TopCurveClipper(),
                      child: Container(
                        height: 30,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacing20,
                      ),
                      child: Column(
                        children: [
                          /// ACCOUNT SECTION with Decorative Header
                          _buildStyledSection(
                            context,
                            title: 'ACCOUNT',
                            icon: Icons.account_circle_rounded,
                            children: [
                              _buildAnimatedTile(
                                Icons.person_outline,
                                lp.getText('edit_profile'),
                                primaryColor,
                                    () {},
                              ),
                              _buildAnimatedTile(
                                Icons.subscriptions_outlined,
                                lp.getText('subscription'),
                                primaryColor,
                                    () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const SubscriptionScreen(),
                                  ),
                                ),
                              ),
                              _buildAnimatedTile(
                                Icons.verified_outlined,
                                'Verification Status',
                                Colors.green,
                                    () {},
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'Verified',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          /// SETTINGS SECTION
                          _buildStyledSection(
                            context,
                            title: 'PREFERENCES',
                            icon: Icons.settings_rounded,
                            children: [
                              _buildAnimatedTile(
                                Icons.notifications_outlined,
                                lp.getText('notifications'),
                                primaryColor,
                                    () {},
                                trailing: Switch(
                                  value: true,
                                  onChanged: (value) {},
                                  activeColor: primaryColor,
                                ),
                              ),
                              _buildAnimatedTile(
                                Icons.language_outlined,
                                'Language',
                                primaryColor,
                                    () {},
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'English',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              _buildAnimatedTile(
                                Icons.dark_mode_outlined,
                                'Dark Mode',
                                primaryColor,
                                    () {},
                                trailing: Switch(
                                  value: isDark,
                                  onChanged: (value) {
                                    themeProvider.toggleTheme();
                                  },
                                  activeColor: primaryColor,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          /// SUPPORT SECTION
                          _buildStyledSection(
                            context,
                            title: 'SUPPORT',
                            icon: Icons.support_agent_rounded,
                            children: [
                              _buildAnimatedTile(
                                Icons.help_outline,
                                lp.getText('help_support'),
                                primaryColor,
                                    () => _showHelpSupport(context),
                              ),
                              _buildAnimatedTile(
                                Icons.privacy_tip_outlined,
                                lp.getText('privacy_policy'),
                                primaryColor,
                                    () {},
                              ),
                              _buildAnimatedTile(
                                Icons.rate_review_outlined,
                                'Rate Us',
                                Colors.amber,
                                    () {},
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          /// LOGOUT SECTION
                          _buildStyledSection(
                            context,
                            title: 'ACCOUNT ACTIONS',
                            icon: Icons.warning_rounded,
                            children: [
                              _buildAnimatedTile(
                                Icons.logout_rounded,
                                lp.getText('logout'),
                                AppTheme.errorRed,
                                    () => _showLogoutConfirm(context),
                                showChevron: false,
                              ),
                            ],
                          ),

                          const SizedBox(height: 40),

                          /// VERSION with Stats Card
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  primaryColor.withOpacity(0.1),
                                  AppTheme.royalPurple.withOpacity(0.1),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: primaryColor.withOpacity(0.2),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildStatItem(
                                  'Photos',
                                  '2.4K',
                                  primaryColor,
                                ),
                                Container(
                                  width: 1,
                                  height: 40,
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                                _buildStatItem(
                                  'Followers',
                                  '1.2K',
                                  primaryColor,
                                ),
                                Container(
                                  width: 1,
                                  height: 40,
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                                _buildStatItem(
                                  'Following',
                                  '345',
                                  primaryColor,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          /// Version Text
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 14,
                                color: Colors.grey.shade500,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${lp.getText('version')} 1.0.0',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Styled Section with Curved Header
  Widget _buildStyledSection(
      BuildContext context, {
        required String title,
        required IconData icon,
        required List<Widget> children,
      }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Section Header
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      AppTheme.royalPurple,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                  letterSpacing: 1.2,
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  margin: const EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        /// Section Content
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Column(
              children: children,
            ),
          ),
        ),
      ],
    );
  }

  /// Animated Tile with Hover Effect
  Widget _buildAnimatedTile(
      IconData icon,
      String title,
      Color color,
      VoidCallback onTap, {
        Widget? trailing,
        bool showChevron = true,
      }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              /// Icon Container with Gradient
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),

              /// Title
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),

              /// Trailing Widget
              if (trailing != null) trailing,

              /// Chevron
              if (showChevron && trailing == null)
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

/// Custom Clipper for Top Curve
class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 20,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// Bottom Curve Clipper (Optional for extra style)
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.quadraticBezierTo(
      size.width / 2,
      size.height * 0.3,
      size.width,
      0,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// Enhanced Help Support Bottom Sheet
void _showHelpSupport(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.65,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            /// Handle Bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(24),
                children: [
                  const Text(
                    "How can we help?",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "We're here to assist you 24/7",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _supportCard(
                    Icons.chat_bubble_outline,
                    "Live Chat",
                    "Talk to our team now",
                    Colors.blue,
                  ),
                  _supportCard(
                    Icons.email_outlined,
                    "Email Support",
                    "Get response in 24 hours",
                    Colors.orange,
                  ),
                  _supportCard(
                    Icons.menu_book_outlined,
                    "FAQs",
                    "Read our documentation",
                    Colors.purple,
                  ),
                  _supportCard(
                    Icons.phone_outlined,
                    "Call Support",
                    "Available 9AM - 6PM",
                    Colors.green,
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

Widget _supportCard(IconData icon, String title, String sub, Color color) {
  return Card(
    margin: const EdgeInsets.only(bottom: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 2,
    child: InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sub,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    ),
  );
}

/// Enhanced Logout Dialog
void _showLogoutConfirm(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.errorRed.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.logout_rounded,
                size: 48,
                color: AppTheme.errorRed,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Logout?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Are you sure you want to leave the magic?",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text("Stay"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.errorRed,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}