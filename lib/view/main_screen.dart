import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/language_provider.dart';
import 'home_screen.dart';
import 'events_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late final List<AnimationController> _rippleControllers;

  final List<Widget> _screens = const [
    HomeScreen(),
    EventsScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _rippleControllers = List.generate(3, (index) => AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    ));
  }

  @override
  void dispose() {
    for (var controller in _rippleControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_currentIndex == index) return;

    setState(() {
      _currentIndex = index;
    });

    // Trigger ripple animation
    _rippleControllers[index].forward(from: 0);
  }

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final surfaceColor = theme.colorScheme.surface;

    return Consumer<LanguageProvider>(
      builder: (context, lp, _) {
        return Scaffold(
          extendBody: true,
          body: IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
          bottomNavigationBar: Container(
            height: 80,
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  0,
                  Icons.grid_view_rounded,
                  lp.getText('home'),
                  primaryColor,
                ),
                _buildNavItem(
                  1,
                  Icons.auto_awesome_rounded,
                  lp.getText('events'),
                  primaryColor,
                ),
                _buildNavItem(
                  2,
                  Icons.person_rounded,
                  lp.getText('profile'),
                  primaryColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, Color primaryColor) {
    bool isSelected = _currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        behavior: HitTestBehavior.opaque,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Ripple effect background
            AnimatedBuilder(
              animation: _rippleControllers[index],
              builder: (context, child) {
                return Container(
                  width: 100 * _rippleControllers[index].value,
                  height: 100 * _rippleControllers[index].value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor.withOpacity(0.15 * (1 - _rippleControllers[index].value)),
                  ),
                );
              },
            ),

            // Main content
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Indicator line - Simple container without animation
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  height: 3,
                  width: isSelected ? 30 : 0,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 4),

                // Icon and label container
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withOpacity(0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        icon,
                        color: isSelected ? primaryColor : Colors.grey.shade500,
                        size: 26,
                      ),
                      if (isSelected) ...[
                        const SizedBox(width: 6),
                        Text(
                          label,
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}