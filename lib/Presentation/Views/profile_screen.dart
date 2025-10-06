import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.red.shade700;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: 4,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_outlined), label: "Services"),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.red,
              child: Icon(Icons.sos, color: Colors.white),
            ),
            label: "SOS",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.contacts_outlined), label: "Contacts"),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "More"),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== TOP PROFILE SECTION =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "Hey",
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "User",
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.grey.shade200,
                          child: const Icon(Icons.person_outline,
                              size: 35, color: Colors.black54),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            "Logged via 9995666516",
                            style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // ===== MENU ITEMS =====
                    _buildMenuItem(Icons.person_outline, "Thuna Profile", "Manage thuna services"),
                    _buildDivider(),
                    _buildMenuItem(Icons.history, "Service History", "History of all services"),
                    _buildDivider(),
                    _buildMenuItem(Icons.contacts_outlined, "Emergency Contacts",
                        "Contacts for track my trip & SOS"),
                    _buildDivider(),
                    _buildMenuItem(Icons.notifications_outlined, "Alert Settings",
                        "Manage notifications"),
                    _buildDivider(),
                    _buildMenuItem(Icons.warning_amber_rounded, "Cyber Fraud List",
                        "View and confirm all fraud nos."),
                    _buildDivider(),
                    _buildMenuItem(Icons.support_agent_outlined, "Contact Us",
                        "Any queries, please reach out to us"),

                    const SizedBox(height: 25),
                    _buildLanguageTile(),
                    const SizedBox(height: 15),
                    _buildDarkModeTile(),
                  ],
                ),
              ),

              // ===== DARK SECTION (BOTTOM MENU) =====
              Container(
                width: double.infinity,
                color: const Color(0xFF2C2F36),
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  children: [
                    Wrap(
                      spacing: 25,
                      runSpacing: 25,
                      alignment: WrapAlignment.center,
                      children: [
                        _bottomIcon(Icons.new_releases_outlined, "What's New"),
                        _bottomIcon(Icons.star_border, "Rate the App"),
                        _bottomIcon(Icons.privacy_tip_outlined, "Privacy Policy"),
                        _bottomIcon(Icons.article_outlined, "Terms & Conditions"),
                        _bottomIcon(Icons.bloodtype_outlined, "Affidavit for Blood"),
                        _bottomIcon(Icons.info_outline, "About Us"),
                      ],
                    ),
                    const SizedBox(height: 35),
                    _logoutButton(),
                    const SizedBox(height: 8),
                    Text(
                      "App Version: 3.2.8",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: 28, color: Colors.black87),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey.shade600),
      ),
      onTap: () {},
    );
  }

  Widget _buildDivider() => Divider(color: Colors.grey.shade300, height: 5);

  Widget _buildLanguageTile() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.translate, color: Colors.black54),
              const SizedBox(width: 10),
              Text(
                "Use Malayalam as App language",
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
          Switch(value: false, onChanged: (v) {}),
        ],
      ),
    );
  }

  Widget _buildDarkModeTile() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.dark_mode_outlined, color: Colors.black54),
              const SizedBox(width: 10),
              Text(
                "Dark Mode",
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
          Switch(value: false, onChanged: (v) {}),
        ],
      ),
    );
  }

  Widget _bottomIcon(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white.withOpacity(0.1),
          child: Icon(icon, size: 26, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 13),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _logoutButton() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.logout, color: Colors.white),
      label: Text(
        "Logout",
        style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.shade600,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
