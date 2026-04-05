import 'package:flutter/material.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.deepPurple.shade50,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade700],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.admin_panel_settings,
                      size: 35,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Admin Panel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'admin@education.com',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              Icons.dashboard,
              'Dashboard',
              () => Navigator.pushReplacementNamed(context, '/admin-dashboard'),
            ),
            _buildDrawerItem(
              Icons.school,
              'Courses',
              () => Navigator.pushReplacementNamed(context, '/admin-courses'),
            ),
            _buildDrawerItem(
              Icons.business,
              'Colleges',
              () {},
            ),
            _buildDrawerItem(
              Icons.menu_book,
              'Syllabus',
              () {},
            ),
            _buildDrawerItem(
              Icons.quiz,
              'Past Questions',
              () {},
            ),
            _buildDrawerItem(
              Icons.notifications,
              'Notifications',
              () => Navigator.pushReplacementNamed(context, '/admin-notifications'),
            ),
            const Divider(),
            _buildDrawerItem(
              Icons.settings,
              'Settings',
              () {},
            ),
            _buildDrawerItem(
              Icons.logout,
              'Logout',
              () {},
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap, {Color color = Colors.black}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color)),
      onTap: onTap,
    );
  }
}