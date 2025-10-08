import 'package:flutter/material.dart';
import 'package:pollapp/Core/app_constants/app_constants.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final List<Color> gradientColors;
  final Color arrowColor;

  const InfoCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.gradientColors,
    required this.arrowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side text + arrow
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_right_alt,
                    color: arrowColor,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Image.asset(
            imagePath,
            height: 90,
            width: 90,
          ),
        ],
      ),
    );
  }
}



class InfoCardsCarousel extends StatelessWidget {
  const InfoCardsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = [
      {
        "title": "Woman Safety",
        "description": "Every woman has the right to feel safe and protected",
        "image": "assets/images/new/userManual/woman-safety.png",
        "colors": [const Color(0xFFDF007C), const Color(0xFFE942A0)],
        "arrowColor": Colors.pinkAccent,
      },
      {
        "title": "Pol-Blood",
        "description": "The gift of blood is a gift to someone's life!!",
        "image": "assets/images/new/userManual/blood-bank.png",
        "colors": [const Color(0xFF6A11CB), const Color(0xFF2575FC)],
        "arrowColor": Colors.blueAccent,
      },
      {
        "title": "Tourist Guide",
        "description": "Worlds is for you. We are always a freind in need ",
        "image": "assets/images/new/userManual/tourist-guide.png",
        "colors": [const Color(0xFFFF512F), const Color(0xFFF09819)],
        "arrowColor": Colors.deepOrange,
      },
      {
        "title": AppConstants.firdownload,
        "description": "Need FIR details.Download a copy!!",
        "image": "assets/images/new/userManual/fir.png",
        "colors": [const Color(0xFF00B09B), const Color(0xFF96C93D)],
        "arrowColor": Colors.green,
      },
      {
        "title": "Certificate of Non-Involvement in Offences",
        "description": "Official Confirmation of Lawful Conduct  ",
        "image": "assets/images/new/userManual/pcc.png",
        "colors": [const Color(0xFF654EA3), const Color(0xFFEAAFC8)],
        "arrowColor": Colors.purple,
      },
      {
        "title": "Report An Offence",
        "description": "Be vigilant. Report offense in seconds!!",
        "image": "assets/images/new/userManual/offence.png",
        "colors": [const Color(0xFF11998E), const Color(0xFF38EF7D)],
        "arrowColor": Colors.teal,
      },
      {
        "title": "User Manual",
        "description": "Simple steps.It`s easy to user our services!!",
        "image": "assets/images/new/userManual/user-manual.png",
        "colors": [const Color(0xFFFC5C7D), const Color(0xFF6A82FB)],
        "arrowColor": Colors.pink,
      },
    ];

    return 
      
    
         Padding(
          padding: const EdgeInsets.only(top: 20, left: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: cards.map((card) {
                return InfoCard(
                  title: card["title"] as String,
                  description: card["description"] as String,
                  imagePath: card["image"] as String,
                  gradientColors: (card["colors"] as List<Color>),
                  arrowColor: card["arrowColor"] as Color,
                );
              }).toList(),
            ),
          ),
        );
    
    
  }
}
