import 'dart:async';
import 'package:flutter/material.dart';
import '../ui_helpers/app_theme.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  late Timer _timer;
  bool _isYearly = false;

  final List<Map<String, dynamic>> _plans = [
    {
      'name': 'Starter',
      'priceMonthly': '99',
      'priceYearly': '990',
      'color': const Color(0xFF00B4D8),
      'gradient': [const Color(0xFF00B4D8), const Color(0xFF0096C7)],
      'icon': Icons.rocket_launch_rounded,
      'features': [
        '📸 500 Photos Storage',
        '🎬 1 Event per month',
        '🔗 Standard Sharing',
        '⬇️ Bulk Download',
        '📱 Mobile App Access',
      ],
      'badge': null,
    },
    {
      'name': 'Professional',
      'priceMonthly': '299',
      'priceYearly': '2990',
      'color': const Color(0xFF6C63FF),
      'gradient': [const Color(0xFF6C63FF), const Color(0xFF5A52D9)],
      'icon': Icons.workspace_premium_rounded,
      'isPopular': true,
      'features': [
        '📸 5,000 Photos Storage',
        '🎬 5 Events per month',
        '⬇️ Bulk Download',
        '👤 Face Recognition',
        '🤝 Client Share Portal',
        '🎨 Advanced Editing Tools',
        '📊 Analytics Dashboard',
      ],
      'badge': 'MOST POPULAR',
    },
    {
      'name': 'Studio Elite',
      'priceMonthly': '599',
      'priceYearly': '5990',
      'color': const Color(0xFF03045E),
      'gradient': [const Color(0xFF03045E), const Color(0xFF023E8A)],
      'icon': Icons.auto_awesome_rounded,
      'features': [
        '♾️ Unlimited Photos',
        '♾️ Unlimited Events',
        '🤖 Priority Face AI',
        '🌐 Custom Domain',
        '📁 Raw File Support',
        '👥 Team Collaboration',
        '📦 Priority Support',
        '🎯 Advanced Analytics',
      ],
      'badge': 'BEST VALUE',
    },
    {
      'name': 'Enterprise',
      'priceMonthly': '999',
      'priceYearly': '9990',
      'color': const Color(0xFF1A1A1A),
      'gradient': [const Color(0xFF1A1A1A), const Color(0xFF2D2D2D)],
      'icon': Icons.business_center_rounded,
      'features': [
        '🏷️ White Labeling',
        '🔌 API Access',
        '🕐 24/7 Priority Support',
        '📝 Custom Contracts',
        '👥 Unlimited Team Members',
        '🔐 Advanced Security',
        '📊 Custom Reports',
        '🎓 Dedicated Account Manager',
      ],
      'badge': null,
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < _plans.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          /// ===== Premium Gradient Header =====
          SliverAppBar(
            expandedHeight: 250,
            automaticallyImplyLeading: true, // Enable back button
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            pinned: false,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primaryColor,
                      AppTheme.royalPurple,
                      AppTheme.deepBlue,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
                child: Stack(
                  children: [
                    /// Animated Background Particles
                    ...List.generate(20, (index) {
                      return Positioned(
                        left: (index * 37) % MediaQuery.of(context).size.width,
                        top: (index * 23) % 320,
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: Duration(milliseconds: 1500 + (index * 100)),
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value * 0.3,
                              child: Container(
                                width: 2,
                                height: 2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),

                    /// Main Content - Properly Centered
                    SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(flex: 1),

                          /// Animated Icon
                          TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0, end: 1),
                            duration: const Duration(milliseconds: 800),
                            builder: (context, value, child) {
                              return Transform.scale(
                                scale: value,
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withOpacity(0.3),
                                        Colors.white.withOpacity(0.1),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.3),
                                        blurRadius: 30,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.workspace_premium_rounded,
                                    size: 55,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 5),

                          /// Title
                          const Text(
                            "Choose Your Perfect Plan",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),

                          const SizedBox(height: 5),

                          /// Subtitle
                          Text(
                            "Upgrade to unlock premium features & grow your business",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                            ),
                          ),

                          const SizedBox(height: 10),

                          /// Billing Toggle - Centered
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildToggleButton('Monthly', !_isYearly),
                                  const SizedBox(width: 4),
                                  _buildToggleButton('Yearly', _isYearly),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // /// Savings Badge - Centered
                          // if (_isYearly)
                          //   Center(
                          //     child: Container(
                          //       padding: const EdgeInsets.symmetric(
                          //         horizontal: 16,
                          //         vertical: 6,
                          //       ),
                          //       decoration: BoxDecoration(
                          //         color: Colors.amber.withOpacity(0.2),
                          //         borderRadius: BorderRadius.circular(20),
                          //         border: Border.all(
                          //           color: Colors.amber,
                          //           width: 1,
                          //         ),
                          //       ),
                          //       child: Row(
                          //         mainAxisSize: MainAxisSize.min,
                          //         children: [
                          //           const Icon(
                          //             Icons.savings_rounded,
                          //             size: 16,
                          //             color: Colors.amber,
                          //           ),
                          //           const SizedBox(width: 8),
                          //           Text(
                          //             "Save up to 20% with yearly billing",
                          //             style: TextStyle(
                          //               color: Colors.white,
                          //               fontSize: 12,
                          //               fontWeight: FontWeight.w500,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),

                          const Spacer(flex: 1),
                        ],
                      ),
                    ),

                    /// Bottom Curve
                    // Positioned(
                    //   bottom: -1,
                    //   left: 0,
                    //   right: 0,
                    //   child: ClipPath(
                    //     clipper: PremiumCurveClipper(),
                    //     child: Container(
                    //       height: 50,
                    //       color: isDark ? Colors.black : Colors.grey.shade50,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),

          /// ===== Plans Carousel =====
          SliverToBoxAdapter(
            child: Column(
              children: [

                /// Premium Plan Cards
                SizedBox(
                  height: 540,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _plans.length,
                    onPageChanged: (index) => setState(() => _currentPage = index),
                    itemBuilder: (context, index) => _buildPremiumPlanCard(
                      _plans[index],
                      index,
                      isDark,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                /// Custom Page Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_plans.length, (index) => _buildPremiumDot(index)),
                ),

                const SizedBox(height: 20),

                /// Continue Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    child: ElevatedButton(
                      onPressed: () {
                        _showSubscriptionDialog(_plans[_currentPage]);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _plans[_currentPage]['color'],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 8,
                        shadowColor: _plans[_currentPage]['color'].withOpacity(0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Get ${_plans[_currentPage]['name']} Plan",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                /// Money Back Guarantee
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: Container(
                //     padding: const EdgeInsets.all(12),
                //     decoration: BoxDecoration(
                //       color: isDark ? Colors.grey.shade900 : Colors.white,
                //       borderRadius: BorderRadius.circular(15),
                //       border: Border.all(
                //         color: primaryColor.withOpacity(0.3),
                //       ),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(
                //           Icons.security_rounded,
                //           size: 20,
                //           color: primaryColor,
                //         ),
                //         const SizedBox(width: 10),
                //         Text(
                //           "30-day money-back guarantee • Cancel anytime",
                //           style: TextStyle(
                //             fontSize: 12,
                //             color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                //
                // const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isYearly = !_isYearly;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
            colors: [
              Colors.white,
              Colors.grey.shade50,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.5),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, -1),
            ),
          ]
              : [],
        ),
        child: Stack(
          children: [
            /// Animated Ripple Effect
            if (isSelected)
              Positioned.fill(
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 600),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: (1 - value) * 0.5,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Colors.white.withOpacity(0.8),
                              Colors.transparent,
                            ],
                            stops: [0, value],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

            /// Text with Icon
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (text == 'Yearly' && isSelected)
                  const Icon(
                    Icons.rocket_launch_rounded,
                    size: 16,
                    color: Colors.amber,
                  )
                else if (text == 'Monthly' && isSelected)
                  const Icon(
                    Icons.calendar_today_rounded,
                    size: 14,
                    color: Colors.blue,
                  ),
                if ((text == 'Yearly' && isSelected) || (text == 'Monthly' && isSelected))
                  const SizedBox(width: 8),
                Text(
                  text,
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    fontSize: 15,
                    letterSpacing: 0.5,
                  ),
                ),
                if (text == 'Yearly' && !isSelected)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "-20%",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumPlanCard(Map<String, dynamic> plan, int index, bool isDark) {
    final price = _isYearly ? plan['priceYearly'] : plan['priceMonthly'];
    final monthlyPrice = _isYearly
        ? (int.parse(plan['priceYearly']) / 12).toStringAsFixed(0)
        : plan['priceMonthly'];

    return AnimatedScale(
      scale: _currentPage == index ? 1.0 : 0.92,
      duration: const Duration(milliseconds: 400),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Stack(
          children: [
            /// Glow Effect
            if (_currentPage == index)
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                bottom: 20,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [
                        plan['color'].withOpacity(0.3),
                        plan['color'].withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ),

            /// Main Card
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: plan['gradient'],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Badge
                  if (plan['badge'] != null)
                    Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withOpacity(0.3),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Text(
                        plan['badge']!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Plan Icon
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                plan['icon'],
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            const SizedBox(height: 10),
                        
                            /// Plan Name
                            Text(
                              plan['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 5),
                        
                            /// Price
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  "₹$price",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -1,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _isYearly ? "/year" : "/month",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                        
                            if (_isYearly)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  "₹$monthlyPrice/month",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                        
                            const SizedBox(height: 10),
                        
                            /// Divider
                            Container(
                              height: 2,
                              width: 50,
                              color: Colors.white.withOpacity(0.3),
                            ),
                        
                            const SizedBox(height: 10),
                        
                            /// Features
                            Text(
                              "What's included:",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 15),
                        
                            /// Features List - Fixed layout
                            ...List.generate(plan['features'].length, (i) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check_rounded,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        plan['features'][i],
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                        
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: _currentPage == index ? 30 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? _plans[_currentPage]['color']
            : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  void _showSubscriptionDialog(Map<String, dynamic> plan) {
    final price = _isYearly ? plan['priceYearly'] : plan['priceMonthly'];

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
          initialChildSize: 0.7,
          expand: false,
          builder: (context, scrollController) => SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  /// Handle Bar
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Icon
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: plan['color'].withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      plan['icon'],
                      size: 40,
                      color: plan['color'],
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Title
                  Text(
                    "Confirm Subscription",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: plan['color'],
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    "You're about to subscribe to the ${plan['name']} plan",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Price Summary
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          plan['color'].withOpacity(0.1),
                          plan['color'].withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Plan",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              plan['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Billing Cycle",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              _isYearly ? "Yearly" : "Monthly",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "₹$price/${_isYearly ? 'year' : 'month'}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: plan['color'],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text("Cancel"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _showSuccessDialog(plan);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: plan['color'],
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            "Subscribe Now",
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
        ),
      ),
    );
  }

  void _showSuccessDialog(Map<String, dynamic> plan) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  size: 60,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Subscription Successful!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "You've successfully subscribed to the ${plan['name']} plan",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: plan['color'],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "Get Started",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ===== Premium Curve Clipper =====
class PremiumCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 20,
      size.width,
      size.height,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../ui_helpers/app_theme.dart';
// import '../controllers/theme_provider.dart';
//
// class SubscriptionScreen extends StatefulWidget {
//   const SubscriptionScreen({super.key});
//
//   @override
//   State<SubscriptionScreen> createState() => _SubscriptionScreenState();
// }
//
// class _SubscriptionScreenState extends State<SubscriptionScreen> {
//   final PageController _pageController = PageController(viewportFraction: 0.85);
//   int _currentPage = 0;
//   late Timer _timer;
//   bool _isYearly = false;
//
//   final List<Map<String, dynamic>> _plans = [
//     {
//       'name': 'Starter',
//       'priceMonthly': '99',
//       'priceYearly': '990',
//       'color': const Color(0xFF00B4D8),
//       'gradient': [const Color(0xFF00B4D8), const Color(0xFF0096C7)],
//       'icon': Icons.rocket_launch_rounded,
//       'features': [
//         '📸 500 Photos Storage',
//         '🎬 1 Event per month',
//         '🔗 Standard Sharing',
//         '⬇️ Bulk Download',
//         '📱 Mobile App Access',
//       ],
//       'badge': null,
//     },
//     {
//       'name': 'Professional',
//       'priceMonthly': '299',
//       'priceYearly': '2990',
//       'color': const Color(0xFF6C63FF),
//       'gradient': [const Color(0xFF6C63FF), const Color(0xFF5A52D9)],
//       'icon': Icons.workspace_premium_rounded,
//       'isPopular': true,
//       'features': [
//         '📸 5,000 Photos Storage',
//         '🎬 5 Events per month',
//         '⬇️ Bulk Download',
//         '👤 Face Recognition',
//         '🤝 Client Share Portal',
//         '🎨 Advanced Editing Tools',
//         '📊 Analytics Dashboard',
//       ],
//       'badge': 'MOST POPULAR',
//     },
//     {
//       'name': 'Studio Elite',
//       'priceMonthly': '599',
//       'priceYearly': '5990',
//       'color': const Color(0xFF03045E),
//       'gradient': [const Color(0xFF03045E), const Color(0xFF023E8A)],
//       'icon': Icons.auto_awesome_rounded,
//       'features': [
//         '♾️ Unlimited Photos',
//         '♾️ Unlimited Events',
//         '🤖 Priority Face AI',
//         '🌐 Custom Domain',
//         '📁 Raw File Support',
//         '👥 Team Collaboration',
//         '📦 Priority Support',
//         '🎯 Advanced Analytics',
//       ],
//       'badge': 'BEST VALUE',
//     },
//     {
//       'name': 'Enterprise',
//       'priceMonthly': '999',
//       'priceYearly': '9990',
//       'color': const Color(0xFF1A1A1A),
//       'gradient': [const Color(0xFF1A1A1A), const Color(0xFF2D2D2D)],
//       'icon': Icons.business_center_rounded,
//       'features': [
//         '🏷️ White Labeling',
//         '🔌 API Access',
//         '🕐 24/7 Priority Support',
//         '📝 Custom Contracts',
//         '👥 Unlimited Team Members',
//         '🔐 Advanced Security',
//         '📊 Custom Reports',
//         '🎓 Dedicated Account Manager',
//       ],
//       'badge': null,
//     },
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _startAutoScroll();
//   }
//
//   void _startAutoScroll() {
//     _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       if (_currentPage < _plans.length - 1) {
//         _currentPage++;
//       } else {
//         _currentPage = 0;
//       }
//       if (_pageController.hasClients) {
//         _pageController.animateToPage(
//           _currentPage,
//           duration: const Duration(milliseconds: 800),
//           curve: Curves.easeInOutCubic,
//         );
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final primaryColor = Theme.of(context).colorScheme.primary;
//
//     return Scaffold(
//       backgroundColor: isDark ? Colors.black : Colors.grey.shade50,
//       body: CustomScrollView(
//         slivers: [
//           /// ===== Premium Gradient Header =====
//           SliverAppBar(
//             expandedHeight: 280,
//             pinned: true,
//             backgroundColor: Colors.transparent,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       primaryColor,
//                       AppTheme.royalPurple,
//                       AppTheme.deepBlue,
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     stops: const [0.0, 0.5, 1.0],
//                   ),
//                 ),
//                 child: Stack(
//                   children: [
//                     /// Animated Background Particles
//                     ...List.generate(20, (index) {
//                       return Positioned(
//                         left: (index * 37) % MediaQuery.of(context).size.width,
//                         top: (index * 23) % 280,
//                         child: TweenAnimationBuilder(
//                           tween: Tween<double>(begin: 0, end: 1),
//                           duration: Duration(milliseconds: 1500 + (index * 100)),
//                           builder: (context, value, child) {
//                             return Opacity(
//                               opacity: value * 0.3,
//                               child: Container(
//                                 width: 2,
//                                 height: 2,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(1),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     }),
//
//                     /// Main Content
//                     SafeArea(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Spacer(),
//                           /// Animated Icon
//                           TweenAnimationBuilder(
//                             tween: Tween<double>(begin: 0, end: 1),
//                             duration: const Duration(milliseconds: 800),
//                             builder: (context, value, child) {
//                               return Transform.scale(
//                                 scale: value,
//                                 child: Container(
//                                   padding: const EdgeInsets.all(16),
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         Colors.white.withOpacity(0.3),
//                                         Colors.white.withOpacity(0.1),
//                                       ],
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.white.withOpacity(0.3),
//                                         blurRadius: 30,
//                                         spreadRadius: 5,
//                                       ),
//                                     ],
//                                   ),
//                                   child: const Icon(
//                                     Icons.workspace_premium_rounded,
//                                     size: 50,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                           const SizedBox(height: 20),
//
//                           /// Title
//                           const Text(
//                             "Choose Your Perfect Plan",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 28,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 1.2,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//
//                           /// Subtitle
//                           Text(
//                             "Upgrade to unlock premium features & grow your business",
//                             style: TextStyle(
//                               color: Colors.white.withOpacity(0.9),
//                               fontSize: 14,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           const SizedBox(height: 30),
//
//                           /// Billing Toggle
//                           Container(
//                             padding: const EdgeInsets.all(4),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.2),
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 _buildToggleButton('Monthly', !_isYearly),
//                                 _buildToggleButton('Yearly', _isYearly),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//
//                           /// Savings Badge
//                           if (_isYearly)
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 6,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.amber.withOpacity(0.2),
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(
//                                   color: Colors.amber,
//                                   width: 1,
//                                 ),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   const Icon(
//                                     Icons.savings_rounded,
//                                     size: 16,
//                                     color: Colors.amber,
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     "Save up to 20% with yearly billing",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           const Spacer(),
//                         ],
//                       ),
//                     ),
//
//                     /// Bottom Curve
//                     Positioned(
//                       bottom: -1,
//                       left: 0,
//                       right: 0,
//                       child: ClipPath(
//                         clipper: PremiumCurveClipper(),
//                         child: Container(
//                           height: 50,
//                           color: isDark ? Colors.black : Colors.grey.shade50,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           /// ===== Plans Carousel =====
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 const SizedBox(height: 20),
//
//                 /// Premium Plan Cards
//                 SizedBox(
//                   height: 540,
//                   child: PageView.builder(
//                     controller: _pageController,
//                     itemCount: _plans.length,
//                     onPageChanged: (index) => setState(() => _currentPage = index),
//                     itemBuilder: (context, index) => _buildPremiumPlanCard(
//                       _plans[index],
//                       index,
//                       isDark,
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 /// Custom Page Indicator
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(_plans.length, (index) => _buildPremiumDot(index)),
//                 ),
//
//                 const SizedBox(height: 30),
//
//                 /// Continue Button
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 300),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         _showSubscriptionDialog(_plans[_currentPage]);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: _plans[_currentPage]['color'],
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         elevation: 8,
//                         shadowColor: _plans[_currentPage]['color'].withOpacity(0.5),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Get ${_plans[_currentPage]['name']} Plan",
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           const Icon(
//                             Icons.arrow_forward_rounded,
//                             color: Colors.white,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 /// Money Back Guarantee
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: isDark ? Colors.grey.shade900 : Colors.white,
//                       borderRadius: BorderRadius.circular(15),
//                       border: Border.all(
//                         color: primaryColor.withOpacity(0.3),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.security_rounded,
//                           size: 20,
//                           color: primaryColor,
//                         ),
//                         const SizedBox(width: 10),
//                         Text(
//                           "30-day money-back guarantee • Cancel anytime",
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 40),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildToggleButton(String text, bool isSelected) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _isYearly = !_isYearly;
//         });
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.white : Colors.transparent,
//           borderRadius: BorderRadius.circular(30),
//           boxShadow: isSelected
//               ? [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//             ),
//           ]
//               : null,
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             color: isSelected ? Colors.black : Colors.white,
//             fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPremiumPlanCard(Map<String, dynamic> plan, int index, bool isDark) {
//     final isPopular = plan['isPopular'] ?? false;
//     final price = _isYearly ? plan['priceYearly'] : plan['priceMonthly'];
//     final monthlyPrice = _isYearly
//         ? (int.parse(plan['priceYearly']) / 12).toStringAsFixed(0)
//         : plan['priceMonthly'];
//
//     return AnimatedScale(
//       scale: _currentPage == index ? 1.0 : 0.92,
//       duration: const Duration(milliseconds: 400),
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//         child: Stack(
//           children: [
//             /// Glow Effect
//             if (_currentPage == index)
//               Positioned(
//                 top: -10,
//                 left: -10,
//                 right: -10,
//                 bottom: -10,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(35),
//                     gradient: LinearGradient(
//                       colors: [
//                         plan['color'].withOpacity(0.3),
//                         plan['color'].withOpacity(0.1),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//
//             /// Main Card
//             Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: plan['gradient'],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(30),
//                 boxShadow: [
//                   BoxShadow(
//                     color: plan['color'].withOpacity(0.4),
//                     blurRadius: 30,
//                     offset: const Offset(0, 15),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   /// Badge
//                   if (plan['badge'] != null)
//                     Container(
//                       margin: const EdgeInsets.all(20),
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.amber,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.amber.withOpacity(0.3),
//                             blurRadius: 10,
//                           ),
//                         ],
//                       ),
//                       child: Text(
//                         plan['badge']!,
//                         style: const TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//
//                   Padding(
//                     padding: const EdgeInsets.all(24),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         /// Plan Icon
//                         Container(
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Icon(
//                             plan['icon'],
//                             color: Colors.white,
//                             size: 32,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//
//                         /// Plan Name
//                         Text(
//                           plan['name'],
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 1,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//
//                         /// Price
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.baseline,
//                           textBaseline: TextBaseline.alphabetic,
//                           children: [
//                             Text(
//                               "₹$price",
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 48,
//                                 fontWeight: FontWeight.w900,
//                                 letterSpacing: -1,
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             Text(
//                               _isYearly ? "/year" : "/month",
//                               style: TextStyle(
//                                 color: Colors.white.withOpacity(0.7),
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//
//                         if (_isYearly)
//                           Padding(
//                             padding: const EdgeInsets.only(top: 4),
//                             child: Text(
//                               "₹monthly99/month",
//                               style: TextStyle(
//                                 color: Colors.white.withOpacity(0.6),
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ),
//
//                         const SizedBox(height: 20),
//
//                         /// Divider
//                         Container(
//                           height: 2,
//                           width: 50,
//                           color: Colors.white.withOpacity(0.3),
//                         ),
//
//                         const SizedBox(height: 20),
//
//                         /// Features
//                         Text(
//                           "What's included:",
//                           style: TextStyle(
//                             color: Colors.white.withOpacity(0.9),
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const SizedBox(height: 15),
//
//                         Expanded(
//                           child: ListView.builder(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: plan['features'].length,
//                             itemBuilder: (context, i) => Padding(
//                               padding: const EdgeInsets.only(bottom: 12),
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.all(4),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white.withOpacity(0.2),
//                                       shape: BoxShape.circle,
//                                     ),
//                                     child: const Icon(
//                                       Icons.check_rounded,
//                                       color: Colors.white,
//                                       size: 14,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 12),
//                                   Expanded(
//                                     child: Text(
//                                       plan['features'][i],
//                                       style: TextStyle(
//                                         color: Colors.white.withOpacity(0.9),
//                                         fontSize: 13,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPremiumDot(int index) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       height: 8,
//       width: _currentPage == index ? 30 : 8,
//       decoration: BoxDecoration(
//         color: _currentPage == index
//             ? _plans[_currentPage]['color']
//             : Colors.grey.shade300,
//         borderRadius: BorderRadius.circular(10),
//       ),
//     );
//   }
//
//   void _showSubscriptionDialog(Map<String, dynamic> plan) {
//     final price = _isYearly ? plan['priceYearly'] : plan['priceMonthly'];
//     final billingCycle = _isYearly ? "yearly" : "monthly";
//
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//         ),
//         child: DraggableScrollableSheet(
//           initialChildSize: 0.7,
//           expand: false,
//           builder: (context, scrollController) => Padding(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               children: [
//                 /// Handle Bar
//                 Container(
//                   width: 40,
//                   height: 4,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade300,
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//
//                 /// Icon
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: plan['color'].withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     plan['icon'],
//                     size: 40,
//                     color: plan['color'],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//
//                 /// Title
//                 Text(
//                   "Confirm Subscription",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: plan['color'],
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//
//                 Text(
//                   "You're about to subscribe to the ${plan['name']} plan",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//
//                 /// Price Summary
//                 Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         plan['color'].withOpacity(0.1),
//                         plan['color'].withOpacity(0.05),
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Plan",
//                             style: TextStyle(
//                               color: Colors.grey.shade600,
//                             ),
//                           ),
//                           Text(
//                             plan['name'],
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Billing Cycle",
//                             style: TextStyle(
//                               color: Colors.grey.shade600,
//                             ),
//                           ),
//                           Text(
//                             _isYearly ? "Yearly" : "Monthly",
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Divider(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             "Total",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             "₹$price/${_isYearly ? 'year' : 'month'}",
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: plan['color'],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//
//                 /// Buttons
//                 Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () => Navigator.pop(context),
//                         style: OutlinedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                         ),
//                         child: const Text("Cancel"),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                           // Proceed with subscription
//                           _showSuccessDialog(plan);
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: plan['color'],
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                         ),
//                         child: const Text(
//                           "Subscribe Now",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showSuccessDialog(Map<String, dynamic> plan) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.green.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.check_circle_rounded,
//                   size: 60,
//                   color: Colors.green,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 "Subscription Successful!",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 "You've successfully subscribed to the ${plan['name']} plan",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.grey.shade600,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   Navigator.pop(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: plan['color'],
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 40,
//                     vertical: 14,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 child: const Text(
//                   "Get Started",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// /// ===== Premium Curve Clipper =====
// class PremiumCurveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.lineTo(0, 0);
//     path.quadraticBezierTo(
//       size.width / 2,
//       size.height,
//       size.width,
//       0,
//     );
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }