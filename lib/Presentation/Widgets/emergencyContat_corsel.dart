import 'dart:async';

import 'package:flutter/material.dart';

class EmergencyContactsCarousel extends StatefulWidget {
  const EmergencyContactsCarousel({Key? key}) : super(key: key);

  @override
  State<EmergencyContactsCarousel> createState() =>
      _EmergencyContactsCarouselState();
}

class _EmergencyContactsCarouselState extends State<EmergencyContactsCarousel> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  final List<EmergencyContact> contacts = [
    EmergencyContact(
      name: 'Aparajitha',
      number: '9497996992',
      gradientColors: [Colors.red.shade400, Colors.red.shade600],
    ),
    EmergencyContact(
      name: 'Police',
      number: '100',
      gradientColors: [Colors.blue.shade400, Colors.blue.shade600],
    ),
    EmergencyContact(
      name: 'Ambulance',
      number: '108',
      gradientColors: [Colors.green.shade400, Colors.green.shade600],
    ),
    EmergencyContact(
      name: 'Fire Service',
      number: '101',
      gradientColors: [Colors.orange.shade400, Colors.orange.shade600],
    ),
    EmergencyContact(
      name: 'Women Helpline',
      number: '1091',
      gradientColors: [Colors.purple.shade400, Colors.purple.shade600],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < contacts.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 140,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.lightBlue.shade200,
                Colors.teal.shade200,
                Colors.lightGreen.shade200,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return _buildContactCard(contacts[index]);
            },
          ),
        ),
        const SizedBox(height: 12),
        _buildPageIndicator(),
      ],
    );
  }

  Widget _buildContactCard(EmergencyContact contact) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          // Phone Icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: contact.gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.phone,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Contact Details
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    contact.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: contact.gradientColors,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    contact.number,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        contacts.length,
        (index) => GestureDetector(
          onTap: () {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: _currentPage == index ? 32 : 12,
            height: 12,
            decoration: BoxDecoration(
              color: _currentPage == index ? Colors.red : Colors.grey,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ),
    );
  }
}

class EmergencyContact {
  final String name;
  final String number;
  final List<Color> gradientColors;

  EmergencyContact({
    required this.name,
    required this.number,
    required this.gradientColors,
  });
}