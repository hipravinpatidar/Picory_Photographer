import 'package:flutter/material.dart';
import 'package:picory_app/view/subsicription_screen.dart';
import 'package:provider/provider.dart';
import '../controllers/language_provider.dart';
import '../controllers/theme_provider.dart';
import '../ui_helpers/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer2<LanguageProvider, ThemeProvider>(
      builder: (context, lp, themeProvider, child) {
        final isDark = themeProvider.isDarkMode;
        final primaryColor = theme.colorScheme.primary;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              // ===== Sliver AppBar =====
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [primaryColor, AppTheme.deepBlue],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white24, width: 8),
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person_rounded,
                              size: 60,
                              color: AppTheme.deepBlue,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          lp.getText('profile_name'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'john@photographer.com',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ===== Settings =====
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacing20),
                  child: Column(
                    children: [
                      _buildSectionCard(theme, [
                        _buildTile(
                          Icons.person_outline,
                          lp.getText('edit_profile'),
                          primaryColor,
                              () {},
                        ),
                        _buildTile(
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
                      ]),

                      const SizedBox(height: 20),

                      _buildSectionCard(theme, [
                        _buildTile(
                          Icons.notifications_outlined,
                          lp.getText('notifications'),
                          primaryColor,
                              () {},
                        ),
                        _buildTile(
                          Icons.help_outline,
                          lp.getText('help_support'),
                          primaryColor,
                              () => _showHelpSupport(context),
                        ),
                        _buildTile(
                          Icons.privacy_tip_outlined,
                          lp.getText('privacy_policy'),
                          primaryColor,
                              () {},
                        ),
                      ]),

                      const SizedBox(height: 20),

                      _buildSectionCard(theme, [
                        _buildTile(
                          Icons.logout_rounded,
                          lp.getText('logout'),
                          AppTheme.errorRed,
                              () => _showLogoutConfirm(context),
                        ),
                      ]),

                      const SizedBox(height: 40),
                      Text(
                        '${lp.getText('version')} 1.0.0',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Section Wrapper for Tiles
  Widget _buildSectionCard(ThemeData theme, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildTile(IconData icon, String title, Color color, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right_rounded, size: 20),
      onTap: onTap,
    );
  }
}

void _showHelpSupport(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.6,
      expand: false,
      builder: (context, scrollController) => ListView(
        controller: scrollController,
        padding: const EdgeInsets.all(24),
        children: [
          const Text("How can we help?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _supportCard(Icons.chat_bubble_outline, "Live Chat", "Talk to our team now"),
          _supportCard(Icons.email_outlined, "Email Support", "Get response in 24 hours"),
          _supportCard(Icons.menu_book_outlined, "FAQs", "Read our documentation"),
        ],
      ),
    ),
  );
}

Widget _supportCard(IconData icon, String title, String sub) {
  return Card(
    margin: const EdgeInsets.only(bottom: 15),
    child: ListTile(
      leading: Icon(icon, color: AppTheme.royalPurple),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(sub),
      onTap: () {},
    ),
  );
}

void _showLogoutConfirm(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text("Logout?"),
      content: const Text("Are you sure you want to leave the magic?"),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Stay")),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.errorRed),
          onPressed: () {},
          child: const Text("Logout"),
        ),
      ],
    ),
  );
}