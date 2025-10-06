// stepper_widget.dart
import 'package:flutter/material.dart';

class ModernStepper extends StatelessWidget {
  final List<String> steps;
  final int currentStep;

  const ModernStepper({
    Key? key,
    required this.steps,
    required this.currentStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: Offset(0, 3),
            color: Colors.black12,
          ),
        ],
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              steps.length,
              (index) {
                bool isCompleted = index < currentStep;
                bool isCurrent = index == currentStep;

                return Expanded(
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isCompleted
                              ? const Color(0xFF2E3192)
                              : isCurrent
                                  ? const Color(0xFF2E3192)
                                  : Colors.grey.shade300,
                          shape: BoxShape.circle,
                          boxShadow: isCurrent
                              ? [
                                  BoxShadow(
                                    color: Colors.indigo.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  )
                                ]
                              : [],
                        ),
                        child: Center(
                          child: Icon(
                            isCompleted
                                ? Icons.check_rounded
                                : isCurrent
                                    ? Icons.circle
                                    : Icons.circle_outlined,
                            size: isCompleted ? 18 : 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        steps[index],
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight:
                              isCurrent ? FontWeight.w700 : FontWeight.w500,
                          color: isCurrent
                              ? const Color(0xFF2E3192)
                              : Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          // Progress Bar
          Stack(
            children: [
              Container(
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                height: 4,
                width:
                    (MediaQuery.of(context).size.width - 64) * (currentStep / (steps.length - 1)),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E3192),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
