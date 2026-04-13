import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../controllers/language_provider.dart';
import '../controllers/login_user_provider.dart';
import '../controllers/splash_controller.dart';
import '../ui_helpers/app_images.dart';
import '../ui_helpers/app_theme.dart';
import 'home_screen.dart';
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
  late SplashController _splashController;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _splashController = Provider.of<SplashController>(context, listen: false);
    _initialize();
  }

  // ANIMATION
  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: -20.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.05), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 50),
    ]).animate(_controller);
  }

  //  LOGIC START
  Future<void> _initialize() async {
    print("Initialized");
    await _splashController.initialize();
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      if (_splashController.hasInternet) {
        _checkAuthAndNavigate();
      } else {
        _splashController.addListener(_onConnectivityChanged);
      }
    }
  }

  void _onConnectivityChanged() {
    print("Connectivity Checking");
    if (_splashController.hasInternet) {
      _splashController.removeListener(_onConnectivityChanged);
      _checkAuthAndNavigate();
    }
  }

  Future<void> _checkAuthAndNavigate() async {
    print("Auth and Navigation");
    final authController = Provider.of<LoginController>(context, listen: false);
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;
    if (authController.isLoggedIn) {
      print("Navigate Home Screen");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _splashController.removeListener(_onConnectivityChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashController>(
      builder: (context, controller, child) {
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

                  ///  LOGO (UNCHANGED)
                  _buildLogo(),
                  const SizedBox(height: AppTheme.spacing12),

                  ///  NAME (UNCHANGED PICORY STYLE)
                  Consumer<LanguageProvider>(
                    builder: (_, lang, __) {
                      return _buildAppName(lang);
                    },
                  ),
                  const SizedBox(height: AppTheme.spacing12),

                  ///  TAGLINE (UNCHANGED)
                  Consumer<LanguageProvider>(
                    builder: (_, lang, __) {
                      return _buildTagline(lang);
                    },
                  ),

                  const SizedBox(height: 20),

                  ///  CONNECTION STATUS (NEW ADD)
                  _buildConnectionStatus(controller),
                ],
              ),
            ),
          ),
        );
      },
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
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(AppTheme.radiusXLarge),
              ),
              child: Image.asset(
                AppImages.appSplashLogo,
                fit: BoxFit.contain,
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
      style: GoogleFonts.poppins(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
        color: Colors.white,
      ),
    );
  }

  Widget _buildTagline(LanguageProvider languageProvider) {
    return Text(
      languageProvider.getText('tagline'),
      style: GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white.withOpacity(0.9),
        letterSpacing: 0.8,
      ),
    );
  }

  //  NEW (Mahakal se liya hua)
  Widget _buildConnectionStatus(SplashController controller) {
    if (controller.isLoading) {
      return const Padding(
        padding: EdgeInsets.only(top: 10),
        child: CircularProgressIndicator(color: Colors.white),
      );
    } else if (!controller.hasInternet) {
      return const Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          "No Internet Connection",
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          "Connected",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }
}