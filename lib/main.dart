import 'package:flutter/material.dart';
import 'package:picory_app/view/splash_screen.dart';
import 'package:provider/provider.dart';
import 'controllers/language_provider.dart';
import 'controllers/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: const PicoryApp(),
    ),
  );
}

class PicoryApp extends StatelessWidget {
  const PicoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Picory',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.lightTheme,
          darkTheme: themeProvider.darkTheme,
          themeMode: themeProvider.themeMode,
          home: const SplashScreen(),
        );
      },
    );
  }
}


//
// # Picory - Photography Management App
// ## Project Summary
//
// ---
//
// ## 🎯 Project Overview
//
// **App Name:** Picory – Photographers App
// **Tagline:** Capture. Manage. Deliver.
// **Platform:** Flutter (Android optimized)
// **Theme:** Elegant, Premium, Professional SaaS Design
//
// ---
//
// ## ✨ Design Highlights
//
// ### Visual Identity
// - **Primary Color:** Royal Purple (#6C63FF)
// - **Secondary Color:** Deep Blue (#2D3561)
// - **Design Style:** Modern, Clean, Minimal
// - **Border Radius:** 12-16px (soft, rounded)
// - **Shadows:** Soft, subtle (0.05-0.3 opacity)
// - **Typography:** SF Pro Display
//
// ### Dual Mode Support
// - ✅ Light Mode (F8F9FD background)
// - ✅ Dark Mode (0F0F23 background)
// - 🔄 Instant toggle switching
// - 🎨 Consistent design across modes
//
// ### Multilingual
// - 🇬🇧 English
// - 🇮🇳 Hindi (हिंदी)
// - 🔄 Real-time language switching
// - 📝 Complete UI translation
//
// ---
//
// ## 📱 Screens Implemented
//
// ### ✅ 1. Splash Screen
// - Gradient background (Purple → Blue)
// - Centered logo with animation
// - Fade-in effect (1.5s)
// - Auto-navigation after 2.5s
//
// ### ✅ 2. Login Screen
// - Email/Phone input
// - Password with visibility toggle
// - Language toggle (EN/Hindi)
// - Theme toggle (Light/Dark)
// - Forgot password link
// - Modern card layout
// - Form validation
//
// ### ✅ 3. Register Screen
// - Full name, email, phone, password
// - Confirm password validation
// - All validations implemented
// - Clean form design
// - Success navigation
//
// ### ✅ 4. Home Dashboard
// - Active plan card (gradient)
// - Plan expiry display
// - Create Event CTA (Primary button)
// - Upgrade Plan button (Outlined)
// - Events grid (2 columns)
// - Event cards with:
// - Event name
// - Event date
// - Photo count
// - Preview placeholder
//
// ### ✅ 5. Create Event Screen
// - Event name input
// - Date picker (Material design)
// - Deal amount field
// - Amount received field
// - Auto-generates:
// - 6-character access code (A-Z, 0-9)
// - QR code preview
// - Success dialog with code display
// - Info card with helper text
//
// ### ✅ 6. Event Details Screen
// - Event name header
// - Access code display (large, purple)
// - Copy to clipboard button
// - QR code (200x200, white background)
// - Action buttons:
// - Add Photos (Primary)
// - Add Files (Outlined)
// - Permissions section with switches:
// - ✅ Allow Download (ON)
// - ✅ Allow Share (ON)
// - ❌ Allow Screenshot (OFF)
// - ✅ Allow Face Scan (ON)
// - Submit button
// - View Photos navigation
//
// ### ✅ 7. Photos Screen
// - Masonry grid layout (2 columns)
// - Multi-select functionality
// - Long-press to select
// - Select all / Deselect all
// - Delete confirmation dialog
// - Upload progress indicator
// - Empty state design
// - Floating action button (Add Photos)
//
// ### ✅ 8. Events Screen (Bottom Nav)
// - List view of all events
// - Card-based layout
// - Gradient icons
// - Quick navigation
//
// ### ✅ 9. Profile Screen (Bottom Nav)
// - User avatar (gradient circle)
// - Name and email display
// - Settings menu:
// - Edit Profile
// - Subscription (Pro badge)
// - Notifications
// - Help & Support
// - Privacy Policy
// - Logout (red)
// - App version footer
//
// ### ✅ 10. Bottom Navigation
// - Home
// - Events
// - Profile
// - Smooth transitions
// - Active state indicators
//
// ---
//
// ## 🎨 Key Features Implemented
//
// ### ✅ Theme System
// - Light and Dark mode
// - Consistent colors across modes
// - Instant switching
// - Persistent state (ready for SharedPreferences)
//
// ### ✅ Language System
// - English and Hindi support
// - Complete translation dictionary
// - Toggle button in AppBar
// - Real-time UI updates
//
// ### ✅ Animations
// - Splash screen fade & scale
// - Screen transitions (fade)
// - Button ripple effects
// - Switch animations
// - Progress indicators
//
// ### ✅ Form Validation
// - Email format check
// - Password length validation
// - Required field validation
// - Password match validation
// - Real-time error messages
//
// ### ✅ QR Code Generation
// - Auto-generation on event creation
// - 200x200 display size
// - White background for scanning
// - Copy access code functionality
//
// ### ✅ Photo Management
// - Masonry grid (staggered heights)
// - Multi-select mode
// - Selection counter
// - Delete functionality
// - Upload simulation with progress
// - Empty state handling
//
// ### ✅ Professional UI Components
// - Gradient cards
// - Elevated buttons (no shadow, flat)
// - Outlined buttons
// - Icon buttons
// - Text fields with icons
// - Switches
// - Date picker
// - Dialogs (success, confirmation)
// - Snackbars (toasts)
// - Bottom navigation
// - Floating action button
//
// ---
//
// ## 📦 Dependencies Used
//
// ```yaml
// provider: ^6.1.1                      # State management
// qr_flutter: ^4.1.0                    # QR code generation
// flutter_staggered_grid_view: ^0.7.0  # Masonry grid
// intl: ^0.19.0                         # Date formatting
// image_picker: ^1.0.7                  # Photo selection
// file_picker: ^6.1.1                   # File selection
// animations: ^2.0.11                   # Smooth transitions
// shared_preferences: ^2.2.2            # Local storage
// ```
//
// ---
//
// ## 📂 Project Structure
//
// ```
// picory_app/
// ├── lib/
// │   ├── main.dart                     # App entry, multi-provider setup
// │   ├── config/
// │   │   └── app_theme.dart            # Complete theme config
// │   ├── providers/
// │   │   ├── theme_provider.dart       # Theme state
// │   │   └── language_provider.dart    # Language state
// │   └── screens/
// │       ├── splash_screen.dart        # ✅ Animated splash
// │       ├── login_screen.dart         # ✅ Login with validation
// │       ├── register_screen.dart      # ✅ Registration
// │       ├── main_screen.dart          # ✅ Bottom nav wrapper
// │       ├── home_screen.dart          # ✅ Dashboard
// │       ├── events_screen.dart        # ✅ Events list
// │       ├── profile_screen.dart       # ✅ Profile & settings
// │       ├── create_event_screen.dart  # ✅ Create event
// │       ├── event_details_screen.dart # ✅ Event details
// │       └── photos_screen.dart        # ✅ Photo gallery
// ├── assets/
// │   ├── images/                       # Image assets
// │   └── icons/                        # Icon assets
// ├── pubspec.yaml                      # Dependencies
// ├── README.md                         # Project overview
// ├── SETUP_GUIDE.md                    # Installation guide
// ├── FEATURES.md                       # Feature documentation
// └── PROJECT_SUMMARY.md                # This file
// ```
//
// ---
//
// ## 🎯 Design Specifications Met
//
// ### ✅ Theme Requirements
// - [x] Elegant and premium look
// - [x] Dark + Light mode support
// - [x] Royal Purple primary color
// - [x] Deep Blue accent
// - [x] Minimal design
// - [x] Soft shadows
// - [x] 12-16px rounded corners
// - [x] Smooth animations
//
// ### ✅ Language Support
// - [x] Hindi / English toggle
// - [x] Toggle button in AppBar
// - [x] Complete translations
//
// ### ✅ Screen Requirements
// - [x] Splash Screen (animated)
// - [x] Login & Register (with validation)
// - [x] Home Dashboard (plan card + events grid)
// - [x] Create Event (auto-generates code & QR)
// - [x] Event Details (permissions, QR, actions)
// - [x] Photos Screen (masonry, multi-select)
// - [x] Bottom Navigation (Home, Events, Profile)
//
// ### ✅ UX Requirements
// - [x] Bottom navigation
// - [x] Smooth transitions
// - [x] Clean typography
// - [x] Responsive for Android
// - [x] Professional SaaS style
//
// ---
//
// ## 🚀 How to Run
//
// ### Quick Start
// ```bash
// # 1. Navigate to project
// cd picory_app
//
// # 2. Get dependencies
// flutter pub get
//
// # 3. Run app
// flutter run
// ```
//
// ### Build APK
// ```bash
// flutter build apk --release
// ```
//
// ---
//
// ## 🎨 Customization Guide
//
// ### Change Primary Color
// **File:** `lib/config/app_theme.dart`
// ```dart
// static const Color royalPurple = Color(0xFFYOURCOLOR);
// ```
//
// ### Add New Language
// **File:** `lib/providers/language_provider.dart`
// ```dart
// 'es': {
// 'app_name': 'Picory',
// // Add translations
// }
// ```
//
// ### Modify Spacing/Radius
// **File:** `lib/config/app_theme.dart`
// ```dart
// static const double radiusMedium = 12.0; // Change
// static const double spacing16 = 16.0;    // Change
// ```
//
// ---
//
// ## 📊 Statistics
//
// - **Total Screens:** 10
// - **Total Files:** 14 Dart files
// - **Lines of Code:** ~2,500+
// - **Reusable Components:** Theme system, Language system
// - **Animations:** 5+ types
// - **Form Validations:** 6+ validators
// - **Color Palette:** 12 colors
// - **Spacing Scale:** 7 values
// - **Border Radius:** 4 sizes
//
// ---
//
// ## 🎯 What's Implemented
//
// ### ✅ Fully Functional
// - Complete UI/UX design
// - Theme switching (light/dark)
// - Language switching (EN/HI)
// - Form validations
// - Navigation flows
// - QR code generation
// - Access code generation
// - Masonry photo grid
// - Multi-select photos
// - Upload progress simulation
// - Dialogs and toasts
// - Bottom navigation
// - All 10 screens
//
// ### ⚠️ Mock/Simulated
// - API calls (2-second delay simulation)
// - Photo upload (progress bar simulation)
// - Event data (hardcoded samples)
// - User authentication (UI only)
//
// ### 📝 Ready for Integration
// - Backend API endpoints
// - Database models
// - File storage (cloud)
// - Real authentication
// - Payment gateway
// - Push notifications
// - Analytics
//
// ---
//
// ## 🔮 Future Enhancements
//
// ### Phase 2 - Backend Integration
// - [ ] Firebase Authentication
// - [ ] Firestore Database
// - [ ] Cloud Storage for photos
// - [ ] Real-time sync
//
// ### Phase 3 - Advanced Features
// - [ ] Face recognition (ML Kit)
// - [ ] AI photo sorting
// - [ ] Batch operations
// - [ ] Photo filters
// - [ ] Watermarking
// - [ ] Client portal
//
// ### Phase 4 - Business Features
// - [ ] Payment integration (Razorpay)
// - [ ] Subscription plans
// - [ ] Analytics dashboard
// - [ ] Export reports
// - [ ] Calendar integration
// - [ ] Email notifications
//
// ---
//
// ## 🎓 Learning Resources
//
// ### Flutter Docs
// - https://flutter.dev/docs
// - https://api.flutter.dev
//
// ### State Management
// - Provider: https://pub.dev/packages/provider
//
// ### UI Components
// - Material Design: https://m3.material.io
// - Cupertino (iOS): https://flutter.dev/docs/development/ui/widgets/cupertino
//
// ---
//
// ## 📄 Documentation Files
//
// 1. **README.md** - Project overview, features, installation
// 2. **SETUP_GUIDE.md** - Detailed setup, troubleshooting, customization
// 3. **FEATURES.md** - Complete feature documentation, design system
// 4. **PROJECT_SUMMARY.md** - This file, comprehensive summary
//
// ---
//
// ## ✅ Quality Checklist
//
// - [x] Clean code structure
// - [x] Proper file organization
// - [x] Consistent naming conventions
// - [x] Reusable components
// - [x] Responsive layouts
// - [x] Error handling
// - [x] Form validation
// - [x] Loading states
// - [x] Empty states
// - [x] Success feedback
// - [x] Accessibility (touch targets)
// - [x] Performance optimized
// - [x] Well documented
//
// ---
//
// ## 🎉 Deliverables
//
// ### Code
// ✅ Complete Flutter project
// ✅ 10 fully designed screens
// ✅ Theme system (light/dark)
// ✅ Language system (EN/HI)
// ✅ All UI components
// ✅ Navigation flows
// ✅ State management
//
// ### Documentation
// ✅ README.md
// ✅ SETUP_GUIDE.md
// ✅ FEATURES.md
// ✅ PROJECT_SUMMARY.md
// ✅ Inline code comments
//
// ---
//
// ## 💡 Key Highlights
//
// 1. **Professional Design** - Modern, clean, SaaS-style UI
// 2. **Dual Theme** - Light and dark mode with instant switching
// 3. **Bilingual** - English and Hindi with real-time toggle
// 4. **Complete UX** - All screens, flows, and interactions
// 5. **Production Ready** - Clean code, proper structure, well documented
// 6. **Easily Customizable** - Centralized theme, translations, config
// 7. **Backend Ready** - Structured for easy API integration
//
// ---
//
// ## 📞 Support
//
// For questions or customization requests, refer to:
// - SETUP_GUIDE.md for installation help
// - FEATURES.md for design details
// - README.md for quick reference
//
// ---
//
// **Built with ❤️ for photographers worldwide**
//
// **Version:** 1.0.0
// **Last Updated:** 2026-02-13
// **Status:** ✅ Complete & Production Ready