import 'package:bagwan/home.dart';
import 'package:flutter/material.dart';

import 'models/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _onboardingPages = [
    const OnboardingPage(
      image: 'assets/onboard 1.png', 
      title: 'Welcome to Bagwan \nCargo and Logistics \n      Limited ',
      description: 'Efficient and reliable logistics services.',
    ),
    const OnboardingPage(
      image: 'assets/onboard 2.png', // Replace with your image asset
      title: 'Easy Booking',
      description: 'Book your shipments hassle-free.',
    ),
    const OnboardingPage(
      image: 'assets/onboard 3.png', // Replace with your image asset
      title: 'Track Your Shipments',
      description: 'Real-time tracking of your shipments.',
    ),
    const OnboardingPage(
      image: 'assets/onboard4.png', // Replace with your image asset
      title: 'Express delivery',
      description: 'Guaranteed delivery time within schedule',
    ),
    
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _onboardingPages.length,
            itemBuilder: (context, index) {
              return _onboardingPages[index];
            },
          ),
          Positioned(
            bottom: 30.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _onboardingPages.length,
                (index) => _buildPageIndicator(index),
              ),
            ),
          ),
          if (_currentPage == _onboardingPages.length - 1)
            Positioned(
              bottom: 80.0,
              left: 20.0,
              right: 20.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home()));
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 4, 28, 104),),
                child: const Text('Get Started', style: TextStyle(color: Colors.white, fontFamily: "Times New Roman",),),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      width: _currentPage == index ? 16.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}

