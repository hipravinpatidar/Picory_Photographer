import 'dart:async';
import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  late Timer _timer;

  final List<Map<String, dynamic>> _plans = [
    {
      'name': 'Starter',
      'price': '99',
      'color': const Color(0xFF00B4D8),
      'features': ['500 Photos', '1 Event', 'Standard Sharing', 'Bulk Download'],
    },
    {
      'name': 'Professional',
      'price': '299',
      'color': const Color(0xFF6C63FF),
      'isPopular': true,
      'features': ['5000 Photos', '5 Events', 'Bulk Download', 'Face Recognition', 'Client Share'],
    },
    {
      'name': 'Studio Elite',
      'price': '599',
      'color': const Color(0xFF03045E),
      'features': ['Unlimited Photos', 'Unlimited Events', 'Priority Face AI', 'Custom Domain', 'Raw File Support'],
    },
    {
      'name': 'Enterprise',
      'price': '999',
      'color': const Color(0xFF1A1A1A),
      'features': ['White Labeling', 'API Access', '24/7 Support', 'Custom Contracts'],
    },
  ];

  @override
  void initState() {
    super.initState();
    // Auto-scroll logic every 4 seconds
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < _plans.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutQuart,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Your Plan"),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Upgrade to unlock premium features",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 30),

          // Auto Scrolling Cards
          SizedBox(
            height: 450,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _plans.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, index) {
                return _buildPlanCard(_plans[index]);
              },
            ),
          ),

          const SizedBox(height: 30),
          // Page Indicator Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_plans.length, (index) => _buildDot(index)),
          ),

          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _plans[_currentPage]['color'],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: Text("Continue with ${_plans[_currentPage]['name']}"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(Map<String, dynamic> plan) {
    bool isPopular = plan['isPopular'] ?? false;
    Color planColor = plan['color'];

    return AnimatedScale(
      scale: _currentPage == _plans.indexOf(plan) ? 1.0 : 0.9,
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: planColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: planColor.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            if (isPopular)
              Positioned(
                top: 20,
                right: -20,
                child: Transform.rotate(
                  angle: 0.5,
                  child: Container(
                    color: Colors.amber,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    child: const Text("POPULAR", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(plan['name'], style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text("₹${plan['price']}", style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900)),
                      const Text("/month", style: TextStyle(color: Colors.white70, fontSize: 16)),
                    ],
                  ),
                  const Divider(color: Colors.white24, height: 40),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: plan['features'].length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle, color: Colors.white, size: 18),
                              const SizedBox(width: 10),
                              Text(plan['features'][i], style: const TextStyle(color: Colors.white, fontSize: 14)),
                            ],
                          ),
                        );
                      },
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

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? _plans[_currentPage]['color'] : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}