import 'package:flutter/material.dart';

class LatestNewsCarousel extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.0, // Match the card height for precise bounding
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsData.length, // Use the actual data length
        itemBuilder: (context, index) {
          // **CRUCIAL:** Pass the specific data model to the NewsCard
          return NewsCard(
            item: newsData[index],
          );
        },
      ),
    );
  }
}
// The individual card widget
 



  class NewCardModel {
  final String title;
  final String imageUrl;
  NewCardModel({required this.title, required this.imageUrl});


// Global/static list of data to be used by the Carousel

 }
final List<NewCardModel> newsData = [
  NewCardModel(title: "കേരളാ പോലീസ് തമിഴ്നാട് അതിർത്തിയിൽ റെയ്ഡ് നടത്തി...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", imageUrl: "assets/images/logo.png"),
  NewCardModel(title: "44 കിലോ കഞ്ചാവ് പിടികൂടി; രണ്ട് പേർ അറസ്റ്റിൽ. ഇത് വളരെ നീണ്ട വാർത്താ തലക്കെട്ടാണ്.", imageUrl: "assets/images/logo.png"),
  NewCardModel(title: "സേവനങ്ങൾ എളുപ്പമാക്കാൻ പുതിയ മൊബൈൽ ആപ്പ് പുറത്തിറക്കി.", imageUrl: "assets/images/logo.png"),
  NewCardModel(title: "സംസ്ഥാനത്ത് സൈബർ കുറ്റകൃത്യങ്ങൾ തടയാൻ പുതിയ മാർഗ്ഗനിർദ്ദേശങ്ങൾ വന്നു.", imageUrl: "assets/images/logo.png"),
  NewCardModel(title: "അടുത്ത ദിവസം സംസ്ഥാന വ്യാപകമായി വാഹന പരിശോധനകൾ നടക്കും.", imageUrl: "assets/images/logo.png"),
];
 class NewsCard extends StatelessWidget {
  // 💡 Change: The card now requires the NewCardModel item
  final NewCardModel item;

  const NewsCard({required this.item, super.key});

  // 🗑️ Removed: The unnecessary default title/imageUrl properties and the internal newsDate list.

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Define card and image dimensions
    const double cardHeight = 90.0; 
    const double imageSize = cardHeight; // Image is a square matching the card's height

    return Container(
      width: screenWidth * 0.85, 
      height: cardHeight, 
      margin: const EdgeInsets.only(right: 16),
      
      child: Card(
        elevation: 2, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.antiAlias,
        
        child: InkWell(
          onTap: () { /* Action to view full article */ },
          
          child: Row( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 1. Image (Small Square on the Left - Fixed Size)
              Container(
                width: imageSize, // Fixed width
                height: imageSize, // Fixed height
                child: Image.asset(
                  item.imageUrl, // 💡 Use item.imageUrl
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: const Center(child: Icon(Icons.article, color: Colors.grey)),
                  ),
                ),
              ),

              // 2. Headline (Takes the remaining space - Text Overflow controlled by maxLines)
              Expanded( 
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item.title, // 💡 Use item.title
                    maxLines: 4, // Text will overflow with '...' after 4 lines
                    overflow: TextOverflow.ellipsis, // Ensures the "..." appears
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

 