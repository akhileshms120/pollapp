import 'package:flutter/material.dart';

class SearchHighlightScreen extends StatefulWidget {
  const SearchHighlightScreen({super.key});

  @override
  State<SearchHighlightScreen> createState() => _SearchHighlightScreenState();
}

class _SearchHighlightScreenState extends State<SearchHighlightScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> _items = [
    {"title": "Blood Request", "subtitle": "Emergency", "icon": Icons.local_hospital},
    {"title": "Corest Season", "subtitle": "Medical Camp", "icon": Icons.spa},
    {"title": "Apraliant of", "subtitle": "Approval Needed", "icon": Icons.handshake},
    {"title": "Appointment With SHO", "subtitle": "Police Dept.", "icon": Icons.calendar_today},
    {"title": "Or rest Seaice", "subtitle": "Blood Donation", "icon": Icons.favorite},
  ];

  String searchText = "";

  @override
  Widget build(BuildContext context) {
    final filtered = _items.where((item) {
      return item["title"].toString().toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Search Request"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔍 Search Field
            TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search request...",
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 📋 Search Results
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(
                    scale: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
                child: ListView.builder(
                  key: ValueKey(searchText),
                  itemCount: filtered.isEmpty && searchText.isEmpty
                      ? _items.length
                      : filtered.length,
                  itemBuilder: (context, index) {
                    final item = (filtered.isEmpty && searchText.isEmpty)
                        ? _items[index]
                        : filtered[index];

                    final isHighlighted = searchText.isNotEmpty &&
                        item["title"]
                            .toString()
                            .toLowerCase()
                            .contains(searchText.toLowerCase());

                    return AnimatedContainer(
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 500),
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: isHighlighted
                            ? LinearGradient(
                                colors: [
                                  Colors.redAccent.shade100,
                                  Colors.redAccent.shade200
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : const LinearGradient(
                                colors: [Colors.white, Colors.white],
                              ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          if (isHighlighted)
                            BoxShadow(
                              color: Colors.redAccent.withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            )
                          else
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundColor:
                                isHighlighted ? Colors.white : Colors.grey.shade200,
                            child: Icon(
                              item["icon"],
                              size: 28,
                              color: isHighlighted ? Colors.redAccent : Colors.black54,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildHighlightedText(item["title"], searchText, isHighlighted),
                                const SizedBox(height: 4),
                                Text(
                                  item["subtitle"],
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isHighlighted
                                        ? Colors.white70
                                        : Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Highlight matching part of the title
  Widget _buildHighlightedText(String text, String query, bool highlighted) {
    if (query.isEmpty) {
      return Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: highlighted ? Colors.white : Colors.black,
        ),
      );
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();

    final start = lowerText.indexOf(lowerQuery);
    if (start == -1) {
      return Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: highlighted ? Colors.white : Colors.black,
        ),
      );
    }

    final end = start + query.length;

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text.substring(0, start),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: highlighted ? Colors.white : Colors.black,
            ),
          ),
          TextSpan(
            text: text.substring(start, end),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: highlighted ? Colors.yellow : Colors.redAccent,
            ),
          ),
          TextSpan(
            text: text.substring(end),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: highlighted ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
