import 'package:calendar/notification/notification_page.dart';
import 'package:calendar/searchpage.dart/search.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'calendar_page.dart'; // Ensure this page is implemented
import 'profilepage.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profileImage');
    if (imagePath != null) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  final List<Widget> _screens = [
    HomePage(),
    TaskScheduler(),
    NotificationsPage(), // Add NotificationPage here
    Search(), // Ensure this page is implemented
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _updateProfileImage(File? newImage) {
    setState(() {
      _profileImage = newImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color.fromARGB(255, 94, 72, 40),
        selectedItemColor: const Color.fromARGB(235, 36, 105, 62),
        unselectedItemColor: const Color.fromARGB(236, 115, 115, 121),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dashboardState = context.findAncestorStateOfType<_DashboardPageState>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 251, 251),
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        backgroundColor: Color.fromARGB(255, 254, 253, 253),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hello, Tony!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(
                          onProfileImageChanged: (File? newImage) {
                            dashboardState?._updateProfileImage(newImage);
                          },
                        ),
                      ),
                    ).then((_) {
                      dashboardState?._loadProfileImage();
                    });
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: dashboardState?._profileImage != null
                        ? FileImage(dashboardState!._profileImage!)
                        : AssetImage('assets/dash.png'), // Default image
                  ),
                ),
              ],
            ),
          ),
          DefaultTabController(
            length: 3,
            child: Expanded(
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: 'Pending'),
                      Tab(text: 'New'),
                      Tab(text: 'Completed'),
                    ],
                    labelStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                    unselectedLabelStyle: TextStyle(fontSize: 16),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildHorizontalTaskList('Pending'),
                        _buildHorizontalTaskList('New'),
                        _buildHorizontalTaskList('Completed'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Progress',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildProgressCard(),
        ],
      ),
    );
  }

  Widget _buildHorizontalTaskList(String status) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          _buildTaskBox('$status Task 1'),
          SizedBox(width: 16),
          _buildTaskBox('$status Task 2'),
          SizedBox(width: 16),
          _buildTaskBox('$status Task 3'),
        ],
      ),
    );
  }

  Widget _buildTaskBox(String title) {
    return Container(
      width: 120,
      height: 200,
      decoration: BoxDecoration(
        color: const Color.fromARGB(205, 42, 121, 72),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          LinearProgressIndicator(value: 0.5),
        ],
      ),
    );
  }
}
