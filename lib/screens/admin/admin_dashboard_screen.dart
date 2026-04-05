import 'package:clear_exam/screens/admin/%20admin_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/course_provider.dart';
import '../../widgets/admin/stat_card.dart';
// ignore: unused_import
import "../../widgets/admin/admin_drawer.dart";

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final Map<String, dynamic> _stats = {
    'users': 1250,
    'courses': 0,
    'colleges': 32,
    'notifications': 0,
  };

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    await courseProvider.fetchCourses();
    
    setState(() {
      _stats['courses'] = courseProvider.courses.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminDrawer(),
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/admin-notifications');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final auth = Provider.of<AuthProvider>(context, listen: false);
              await auth.logout();
              if (mounted) {
                Navigator.pushReplacementNamed(context, '/admin-login');
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome back, Admin!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Manage your education platform',
                      style: TextStyle(color: Colors.white.withOpacity(0.9)),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Stats Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  StatCard(
                    title: 'Total Users',
                    value: '${_stats['users']}',
                    icon: Icons.people,
                    color: Colors.blue,
                  ),
                  StatCard(
                    title: 'Courses',
                    value: '${_stats['courses']}',
                    icon: Icons.school,
                    color: Colors.green,
                    onTap: () => Navigator.pushNamed(context, '/admin-courses'),
                  ),
                  StatCard(
                    title: 'Colleges',
                    value: '${_stats['colleges']}',
                    icon: Icons.business,
                    color: Colors.orange,
                  ),
                  StatCard(
                    title: 'Notifications',
                    value: '${_stats['notifications']}',
                    icon: Icons.notifications,
                    color: Colors.red,
                    onTap: () => Navigator.pushNamed(context, '/admin-notifications'),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Quick Actions
              const Text(
                'Quick Actions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: _buildActionCard(
                      'Add Course',
                      Icons.add_circle,
                      Colors.blue,
                      () => Navigator.pushNamed(context, '/admin-courses'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildActionCard(
                      'Send Notification',
                      Icons.notifications_active,
                      Colors.green,
                      () => Navigator.pushNamed(context, '/admin-notifications'),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              Row(
                children: [
                  Expanded(
                    child: _buildActionCard(
                      'Add Syllabus',
                      Icons.menu_book,
                      Colors.orange,
                      () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildActionCard(
                      'Add Past Question',
                      Icons.quiz,
                      Colors.purple,
                      () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(String label, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(color: color, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Remove this custom Provider class and use the Provider from the 'provider' package.
// import 'package:provider/provider.dart'; should be uncommented at the top of the file.