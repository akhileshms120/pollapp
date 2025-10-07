import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pollapp/Presentation/Cubit/State/bottomNavState.dart';
import 'package:pollapp/Presentation/Cubit/cubit_files/bottonnav_cubit.dart';
import 'package:pollapp/Presentation/Widgets/custombottomnavbar.dart';

// --- Data Models for Contacts ---
class Contact {
  final String name;
  final String detail; // This could be location or phone number
  final String initials;
  final ContactType type;
  final Color color;

  Contact(this.name, this.detail, this.type)
    : initials = name.substring(0, 1).toUpperCase(),
      color = _getColorForInitial(name.substring(0, 1));

  static Color _getColorForInitial(String initial) {
    switch (initial.toUpperCase()) {
      case 'T':
        return const Color(0xFF1F3255);
      case 'M':
        return Colors.brown;
      case 'A':
        return Colors.teal;
      case 'D':
        return Colors.purple;
      case 'P':
        return Colors.deepOrange;
      case 'C':
        return Colors.blueGrey;
      case 'V':
        return Colors.green;
      case 'R':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }
}

enum ContactType { all, helpline, emergency } // New enum to categorize contacts

final List<Contact> allContacts = [
  Contact("Traffic Unit Kondotty", "Malappuram", ContactType.all),
  Contact("Tirurangadi PS", "Malappuram", ContactType.all),
  Contact("Thenjipalam PS", "Malappuram", ContactType.all),
  Contact("Trafficri PS", "Malappuram", ContactType.all),
  Contact("Traffic Unit", "Malappuram", ContactType.all),
  Contact("Areacode PS", "Malappuram", ContactType.all),
  Contact("DySP Tirur", "Malappuram", ContactType.all),
  Contact("Perinthalmanna PS", "Malappuram", ContactType.all),
];

final List<Contact> helplineContacts = [
  Contact("Police Emergency Helpline", "112", ContactType.helpline),
  Contact("Vanitha Helpline", "1091", ContactType.helpline),
  Contact("Police Chief Control Room", "04712722500", ContactType.helpline),
  Contact("Police Highway Alert", "9846100100", ContactType.helpline),
  Contact("Crime Stopper", "1090", ContactType.helpline),
  Contact("Child Help Line", "1098", ContactType.helpline),
  Contact("Pink Police Patrol", "1515", ContactType.helpline),
  Contact("Railway Alert", "9846200100", ContactType.helpline),
];

// --- Contacts Screen Widget ---
class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final newIndex = Get.arguments;

  late final BottomNavCubit bottomNavCubit;

  @override
  void initState() {
    super.initState();
    bottomNavCubit = BottomNavCubit();
    if (newIndex != null) {
      bottomNavCubit.selectTab(newIndex!);
    }
  }

  @override
  void dispose() {
    bottomNavCubit.close();
    super.dispose();
  }

  int _selectedFilterIndex = 1; // Default to 'Helpline' tab based on Image 1

  List<Contact> get _currentContacts {
    switch (_selectedFilterIndex) {
      case 0:
        return allContacts; // 'All' tab
      case 1:
        return helplineContacts; // 'Helpline' tab
      case 2:
        return []; // 'Emergency' tab is empty
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    bool showAddButton =
        _selectedFilterIndex == 2; // Only show add button on Emergency tab

    return BlocProvider<BottomNavCubit>.value(
      value: bottomNavCubit,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        bottomNavigationBar: SafeArea(
          child: BlocBuilder<BottomNavCubit, BottomNavState>(
            builder: (context, state) => CustomBottomNavigationBar(
              selectedIndex: state.selectedIndex,
              cubit: context.read<BottomNavCubit>(),
            ),
          ),
        ),
      ),
    );
  }

  // --- App Bar / Header Section ---
  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 90,
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person_pin_outlined, color: Color(0xFF1F3255)),
              SizedBox(width: 8),
              Text(
                'CONTACTS',
                style: TextStyle(
                  color: Color(0xFF1F3255),
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          Text(
            'Seamless Police Contact Directory',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(Icons.account_circle_outlined, size: 28),
        ),
      ],
    );
  }

  // --- Main Content Body Section ---
  Widget _buildBody() {
    return Column(
      children: [
        _buildSegmentedControl(),

        _selectedFilterIndex == 0
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: _SearchBar(),
              )
            : const SizedBox(
                height: 10,
              ), // Give some padding if search bar isn't there.

        _currentContacts.isEmpty ? _buildEmptyState() : _buildContactList(),
      ],
    );
  }

  // --- Segmented Control for Filtering (All, Helpline, Emergency) ---
  Widget _buildSegmentedControl() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSegment('All', 0),
          _buildSegment('Helpline', 1),
          _buildSegment('Emergency', 2),
        ],
      ),
    );
  }

  Widget _buildSegment(String text, int index) {
    bool isSelected = _selectedFilterIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilterIndex = index;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF1F3255) : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- Contact List View ---
  Widget _buildContactList() {
    return Expanded(
      child: ListView.separated(
        itemCount: _currentContacts.length,
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) =>
            const Divider(height: 1, indent: 80, endIndent: 16),
        itemBuilder: (context, index) {
          final contact = _currentContacts[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: contact.color,
              child: Text(
                contact.initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            title: Text(
              contact.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            subtitle: Text(
              contact.detail,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.call, size: 20, color: Color(0xFF1F3255)),
              onPressed: () {
                // Handle call action
              },
            ),
            onTap: () {
              // Handle tap to view contact details
            },
          );
        },
      ),
    );
  }

  // --- Empty State UI (for Emergency tab when no contacts) ---
  Widget _buildEmptyState() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for the cute illustration.
            // In a real app, you'd use an Image.asset('assets/nothing_found.png')
            // For now, I'll use a simple icon.
            const Icon(
              Icons.sentiment_dissatisfied_outlined,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            Text(
              'Nothing found!!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(
              height: 100,
            ), // Push the text up a bit to make room for FAB
          ],
        ),
      ),
    );
  }
}

// --- Search Bar Component (unchanged) ---
class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search among 1602 contacts',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            suffixIcon: Icon(
              Icons.tune,
              color: Color(0xFF1F3255),
            ), // Filter icon
            contentPadding: EdgeInsets.symmetric(vertical: 14),
          ),
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
