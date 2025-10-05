import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class KeralaPoliceScreen extends StatelessWidget {
  const KeralaPoliceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8EEF4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),

              // 🔹 Highlighted Logo & Title Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 25,
                      spreadRadius: 1,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: Column(
                  children: [
                    // Logo with soft glow
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.4),
                            blurRadius: 25,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 100,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Kerala Police Text - bold & clean
                    const Text(
                      "Kerala Police",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1B1E28),
                        letterSpacing: 0.5,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Soft in Temperament, Firm in Action
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          Color(0xFF004AAD),
                          Color(0xFF0A84FF),
                        ],
                      ).createShader(bounds),
                      child: const Text(
                        "Soft in Temperament, Firm in Action",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Action Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ActionButton(icon: Icons.public, label: "Website", onTap: () {}),
                  _ActionButton(icon: Icons.location_on, label: "Location", onTap: () {}),
                  _ActionButton(icon: Icons.mail_outline, label: "Mail", onTap: () {}),
                ],
              ),

              const SizedBox(height: 24),

              // Contact Cards
              _ContactCard(number: "04712721547", label: "Landline", onCallTap: () {}),
              const SizedBox(height: 12),
              _ContactCard(number: "9497900567", label: "Mobile", onCallTap: () {}),

              const SizedBox(height: 24),

              // Description
              const Text(
                "Kerala State Police is the law enforcement agency for the State of Kerala with its Headquarters at Thiruvananthapuram, the State Capital. Kerala Police has a reputation for being one of the best-managed state police forces in the country and is one of the top-ranking states in terms of maintenance of law and order. Kerala Police is also one of the first Police departments...",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 32),

              // Back Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ()=>Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1C2431),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 3,
                  ),
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// --------------------- Components ---------------------

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                ),
              ],
            ),
            padding: const EdgeInsets.all(14),
            child: Icon(icon, color: Colors.black87, size: 24),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}

class _ContactCard extends StatelessWidget {
  final String number;
  final String label;
  final VoidCallback onCallTap;

  const _ContactCard({
    required this.number,
    required this.label,
    required this.onCallTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(number,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
              Text(label,
                  style: const TextStyle(fontSize: 13, color: Colors.black54)),
            ],
          ),
          IconButton(
            onPressed: onCallTap,
            icon: const Icon(Icons.call, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
