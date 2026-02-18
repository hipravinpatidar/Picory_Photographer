import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/language_provider.dart';
import '../ui_helpers/app_theme.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _navigateToLogin();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..repeat(reverse: true); // Continuous smooth up-down

    // Vertical bounce (upar neeche)
    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: -20.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Slight breathing scale
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.05), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 50),
    ]).animate(_controller);
  }

  void _navigateToLogin() {
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.royalPurple,
              AppTheme.deepBlue,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLogo(),
              const SizedBox(height: AppTheme.spacing12),

              Consumer<LanguageProvider>(
                builder: (_, lang, __) {
                  return _buildAppName(lang);
                },
              ),

              const SizedBox(height: AppTheme.spacing12),

              Consumer<LanguageProvider>(
                builder: (_, lang, __) {
                  return _buildTagline(lang);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _bounceAnimation.value),
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(AppTheme.radiusXLarge),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 25,
                    spreadRadius: 3,
                    offset: Offset(
                      0,
                      15 + _bounceAnimation.value.abs(),
                    ), // shadow bhi move karega
                  ),
                ],
              ),
              child: const Icon(
                Icons.camera_alt_rounded,
                size: 60,
                color: AppTheme.royalPurple,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppName(LanguageProvider languageProvider) {
    return Text(
      languageProvider.getText('app_name'),
      style: const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildTagline(LanguageProvider languageProvider) {
    return Text(
      languageProvider.getText('tagline'),
      style: TextStyle(
        fontSize: 16,
        color: Colors.white.withOpacity(0.9),
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: 40,
      height: 40,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Colors.white.withOpacity(0.8),
        ),
        strokeWidth: 3,
      ),
    );
  }
}