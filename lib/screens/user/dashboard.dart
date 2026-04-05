import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/socket_service.dart';
import '../../providers/notification_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with WidgetsBindingObserver {
  int _currentIndex = 0;
  
  // Socket and notification variables
  final SocketService _socketService = SocketService(serverUrl: '192.168.1.77');
  final List<Map<String, dynamic>> _realtimeNotifications = [];
  int _unreadCount = 0;
  
  // List of main categories with complete data
  final List<Map<String, dynamic>> categories = [
    {'name': 'Engineering', 'icon': Icons.engineering, 'color': Colors.blue},
    {'name': 'Medical', 'icon': Icons.medical_services, 'color': Colors.green},
    {'name': 'Law', 'icon': Icons.gavel, 'color': Colors.red},
    {'name': 'Teaching', 'icon': Icons.school, 'color': Colors.orange},
    {'name': 'Business', 'icon': Icons.business_center, 'color': Colors.purple},
    {'name': 'Arts', 'icon': Icons.palette, 'color': Colors.pink},
    {'name': 'Technology', 'icon': Icons.computer, 'color': Colors.cyan},
    {'name': 'Science', 'icon': Icons.science, 'color': Colors.teal},
  ];

  // Nepal-specific Engineering courses and colleges
  final Map<String, List<Map<String, dynamic>>> nepalEngineeringData = {
    'courses': [
      {'name': 'Civil Engineering', 'duration': '4 years', 'colleges': ['Pulchowk Campus', 'IOE Purwanchal Campus', 'Kathmandu University']},
      {'name': 'Computer Engineering', 'duration': '4 years', 'colleges': ['Pulchowk Campus', 'Kathmandu University', 'Pokhara University']},
      {'name': 'Electrical Engineering', 'duration': '4 years', 'colleges': ['Pulchowk Campus', 'IOE Purwanchal Campus', 'Nepal Engineering College']},
      {'name': 'Mechanical Engineering', 'duration': '4 years', 'colleges': ['Pulchowk Campus', 'Kathmandu University', 'Nepal Engineering College']},
      {'name': 'Electronics & Communication', 'duration': '4 years', 'colleges': ['Pulchowk Campus', 'Kathmandu University', 'Acme Engineering College']},
      {'name': 'Architecture', 'duration': '5 years', 'colleges': ['Pulchowk Campus', 'Kathmandu University', 'Nepal Engineering College']},
      {'name': 'Geomatics Engineering', 'duration': '4 years', 'colleges': ['Pulchowk Campus', 'Kathmandu University']},
      {'name': 'Aerospace Engineering', 'duration': '4 years', 'colleges': ['Pulchowk Campus']},
    ],
    'topColleges': [
      {'name': 'Pulchowk Campus (IOE)', 'location': 'Lalitpur', 'ranking': '1', 'fee': 'Rs. 3,00,000 - 5,00,000'},
      {'name': 'Kathmandu University', 'location': 'Dhulikhel', 'ranking': '2', 'fee': 'Rs. 4,00,000 - 6,00,000'},
      {'name': 'IOE Purwanchal Campus', 'location': 'Dharan', 'ranking': '3', 'fee': 'Rs. 2,50,000 - 4,00,000'},
      {'name': 'Pokhara University', 'location': 'Pokhara', 'ranking': '4', 'fee': 'Rs. 3,50,000 - 5,50,000'},
      {'name': 'Nepal Engineering College', 'location': 'Bhaktapur', 'ranking': '5', 'fee': 'Rs. 3,00,000 - 5,00,000'},
      {'name': 'Acme Engineering College', 'location': 'Kathmandu', 'ranking': '6', 'fee': 'Rs. 2,80,000 - 4,50,000'},
      {'name': 'Himalaya College of Engineering', 'location': 'Lalitpur', 'ranking': '7', 'fee': 'Rs. 2,70,000 - 4,20,000'},
      {'name': 'Khwopa Engineering College', 'location': 'Bhaktapur', 'ranking': '8', 'fee': 'Rs. 2,60,000 - 4,00,000'},
    ],
  };

  // Nepal-specific Medical data
  final Map<String, List<Map<String, dynamic>>> nepalMedicalData = {
    'courses': [
      {'name': 'MBBS', 'duration': '5.5 years', 'colleges': ['IOM Teaching Hospital', 'BPKIHS', 'Kathmandu Medical College']},
      {'name': 'BDS', 'duration': '5 years', 'colleges': ['BPKIHS', 'Kathmandu University', 'KIST Medical College']},
      {'name': 'BAMS', 'duration': '5.5 years', 'colleges': ['Nepal Ayurveda Campus', 'Rajarshi Gurukul']},
      {'name': 'B.Sc Nursing', 'duration': '4 years', 'colleges': ['IOM Nursing Campus', 'BPKIHS', 'National Academy']},
      {'name': 'B.Pharmacy', 'duration': '4 years', 'colleges': ['Kathmandu University', 'Purbanchal University']},
      {'name': 'MD/MS', 'duration': '3 years', 'colleges': ['IOM Teaching Hospital', 'BPKIHS', 'NMC']},
      {'name': 'BMLT', 'duration': '3 years', 'colleges': ['Purbanchal University', 'Kathmandu University']},
      {'name': 'BHMS', 'duration': '5.5 years', 'colleges': ['Homeopathic Medical College']},
    ],
    'topColleges': [
      {'name': 'IOM Teaching Hospital', 'location': 'Kathmandu', 'ranking': '1', 'fee': 'Rs. 45,00,000 - 60,00,000'},
      {'name': 'BP Koirala Institute of Health Sciences', 'location': 'Dharan', 'ranking': '2', 'fee': 'Rs. 40,00,000 - 55,00,000'},
      {'name': 'Kathmandu Medical College', 'location': 'Kathmandu', 'ranking': '3', 'fee': 'Rs. 50,00,000 - 65,00,000'},
      {'name': 'Nepal Medical College', 'location': 'Kathmandu', 'ranking': '4', 'fee': 'Rs. 45,00,000 - 60,00,000'},
      {'name': 'Manipal College of Medical Sciences', 'location': 'Pokhara', 'ranking': '5', 'fee': 'Rs. 55,00,000 - 70,00,000'},
      {'name': 'KIST Medical College', 'location': 'Lalitpur', 'ranking': '6', 'fee': 'Rs. 42,00,000 - 58,00,000'},
      {'name': 'National Medical College', 'location': 'Birgunj', 'ranking': '7', 'fee': 'Rs. 40,00,000 - 55,00,000'},
      {'name': 'Nepalgunj Medical College', 'location': 'Nepalgunj', 'ranking': '8', 'fee': 'Rs. 38,00,000 - 52,00,000'},
    ],
  };

  // Nepal-specific Law data
  final Map<String, List<Map<String, dynamic>>> nepalLawData = {
    'courses': [
      {'name': 'LLB', 'duration': '3 years', 'colleges': ['Nepal Law Campus', 'Kathmandu University']},
      {'name': 'LLM', 'duration': '2 years', 'colleges': ['Nepal Law Campus', 'Kathmandu University']},
      {'name': 'BA LLB', 'duration': '5 years', 'colleges': ['Kathmandu University', 'Purbanchal University']},
      {'name': 'BBA LLB', 'duration': '5 years', 'colleges': ['Kathmandu University']},
    ],
    'topColleges': [
      {'name': 'Nepal Law Campus', 'location': 'Kathmandu', 'ranking': '1', 'fee': 'Rs. 1,50,000 - 2,50,000'},
      {'name': 'Kathmandu University School of Law', 'location': 'Dhulikhel', 'ranking': '2', 'fee': 'Rs. 2,50,000 - 4,00,000'},
      {'name': 'Purbanchal University Law Campus', 'location': 'Biratnagar', 'ranking': '3', 'fee': 'Rs. 1,20,000 - 2,00,000'},
      {'name': 'Pokhara University Law Faculty', 'location': 'Pokhara', 'ranking': '4', 'fee': 'Rs. 1,80,000 - 3,00,000'},
    ],
  };

  // Nepal-specific Teaching/Education data
  final Map<String, List<Map<String, dynamic>>> nepalTeachingData = {
    'courses': [
      {'name': 'B.Ed', 'duration': '4 years', 'colleges': ['TU Faculty of Education', 'Kathmandu University']},
      {'name': 'M.Ed', 'duration': '2 years', 'colleges': ['TU Faculty of Education', 'Kathmandu University']},
      {'name': 'B.P.Ed', 'duration': '3 years', 'colleges': ['TU Faculty of Education']},
      {'name': 'PhD in Education', 'duration': '3-5 years', 'colleges': ['Kathmandu University']},
    ],
    'topColleges': [
      {'name': 'TU Faculty of Education', 'location': 'Kathmandu', 'ranking': '1', 'fee': 'Rs. 80,000 - 1,50,000'},
      {'name': 'Kathmandu University School of Education', 'location': 'Lalitpur', 'ranking': '2', 'fee': 'Rs. 1,50,000 - 2,50,000'},
      {'name': 'Pokhara University Faculty of Education', 'location': 'Pokhara', 'ranking': '3', 'fee': 'Rs. 1,00,000 - 1,80,000'},
      {'name': 'Mahendra Ratna Campus', 'location': 'Kathmandu', 'ranking': '4', 'fee': 'Rs. 60,000 - 1,20,000'},
    ],
  };

  // Nepal-specific Business data
  final Map<String, List<Map<String, dynamic>>> nepalBusinessData = {
    'courses': [
      {'name': 'BBA', 'duration': '4 years', 'colleges': ['Kathmandu University', 'Purbanchal University']},
      {'name': 'MBA', 'duration': '2 years', 'colleges': ['Kathmandu University', 'Pokhara University']},
      {'name': 'BBS', 'duration': '3 years', 'colleges': ['TU Faculty of Management']},
      {'name': 'MBS', 'duration': '2 years', 'colleges': ['TU Faculty of Management']},
    ],
    'topColleges': [
      {'name': 'Kathmandu University School of Management', 'location': 'Lalitpur', 'ranking': '1', 'fee': 'Rs. 3,00,000 - 5,00,000'},
      {'name': 'Pokhara University Faculty of Management', 'location': 'Pokhara', 'ranking': '2', 'fee': 'Rs. 2,50,000 - 4,00,000'},
      {'name': 'Purbanchal University Faculty of Management', 'location': 'Biratnagar', 'ranking': '3', 'fee': 'Rs. 2,00,000 - 3,50,000'},
      {'name': 'Nepal Commerce Campus', 'location': 'Kathmandu', 'ranking': '4', 'fee': 'Rs. 1,50,000 - 2,50,000'},
    ],
  };

  // Nepal-specific Arts data
  final Map<String, List<Map<String, dynamic>>> nepalArtsData = {
    'courses': [
      {'name': 'BA', 'duration': '3 years', 'colleges': ['TU Central Campus', 'Kathmandu University']},
      {'name': 'BFA', 'duration': '4 years', 'colleges': ['Lalitkala Campus', 'Kathmandu University']},
      {'name': 'MA', 'duration': '2 years', 'colleges': ['TU Central Campus', 'Kathmandu University']},
      {'name': 'MFA', 'duration': '2 years', 'colleges': ['Lalitkala Campus']},
    ],
    'topColleges': [
      {'name': 'TU Central Campus', 'location': 'Kathmandu', 'ranking': '1', 'fee': 'Rs. 50,000 - 1,00,000'},
      {'name': 'Kathmandu University School of Arts', 'location': 'Lalitpur', 'ranking': '2', 'fee': 'Rs. 1,50,000 - 2,50,000'},
      {'name': 'Lalitkala Campus', 'location': 'Kathmandu', 'ranking': '3', 'fee': 'Rs. 80,000 - 1,50,000'},
    ],
  };

  // Nepal-specific Technology data
  final Map<String, List<Map<String, dynamic>>> nepalTechnologyData = {
    'courses': [
      {'name': 'BSc CSIT', 'duration': '4 years', 'colleges': ['Pulchowk Campus', 'Kathmandu University']},
      {'name': 'BCA', 'duration': '4 years', 'colleges': ['Purbanchal University', 'Pokhara University']},
      {'name': 'BIT', 'duration': '4 years', 'colleges': ['Pokhara University', 'Purbanchal University']},
      {'name': 'MCA', 'duration': '2 years', 'colleges': ['Kathmandu University', 'Purbanchal University']},
    ],
    'topColleges': [
      {'name': 'Pulchowk Campus', 'location': 'Lalitpur', 'ranking': '1', 'fee': 'Rs. 2,50,000 - 4,00,000'},
      {'name': 'Kathmandu University', 'location': 'Dhulikhel', 'ranking': '2', 'fee': 'Rs. 3,00,000 - 5,00,000'},
      {'name': 'Pokhara University', 'location': 'Pokhara', 'ranking': '3', 'fee': 'Rs. 2,50,000 - 4,50,000'},
      {'name': 'Purbanchal University', 'location': 'Biratnagar', 'ranking': '4', 'fee': 'Rs. 2,00,000 - 3,50,000'},
    ],
  };

  // Nepal-specific Science data
  final Map<String, List<Map<String, dynamic>>> nepalScienceData = {
    'courses': [
      {'name': 'BSc', 'duration': '3 years', 'colleges': ['TU Central Campus', 'Kathmandu University']},
      {'name': 'MSc', 'duration': '2 years', 'colleges': ['TU Central Campus', 'Kathmandu University']},
      {'name': 'BSc Biotechnology', 'duration': '4 years', 'colleges': ['Kathmandu University', 'Purbanchal University']},
      {'name': 'BSc Microbiology', 'duration': '4 years', 'colleges': ['TU Central Campus', 'Kathmandu University']},
    ],
    'topColleges': [
      {'name': 'TU Central Campus', 'location': 'Kathmandu', 'ranking': '1', 'fee': 'Rs. 60,000 - 1,20,000'},
      {'name': 'Kathmandu University', 'location': 'Dhulikhel', 'ranking': '2', 'fee': 'Rs. 2,50,000 - 4,00,000'},
      {'name': 'Pokhara University', 'location': 'Pokhara', 'ranking': '3', 'fee': 'Rs. 2,00,000 - 3,50,000'},
      {'name': 'Purbanchal University', 'location': 'Biratnagar', 'ranking': '4', 'fee': 'Rs. 1,50,000 - 2,50,000'},
    ],
  };

  // Settings variables
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'English';
  bool _biometricEnabled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initSocket();
  }

  void _initSocket() {
    // IMPORTANT: Replace with your computer's IP address
    // On Windows: ipconfig
    // On Mac/Linux: ifconfig
    _socketService.serverUrl = 'http:192.168.1.77'; // Replace with your IP
    
    _socketService.onNewCourse = (course) {
      _showRealtimeNotification(
        '🎓 New Course Added',
        course['message'] ?? 'A new course is available!',
        Icons.school,
        Colors.green,
      );
    };
    
    _socketService.onNotification = (notification) {
      setState(() {
        _realtimeNotifications.insert(0, notification);
        _unreadCount++;
      });
      
      _showRealtimeNotification(
        notification['title'] ?? '📢 Notification',
        notification['message'] ?? 'You have a new notification',
        Icons.notifications,
        _getTypeColor(notification['type']),
      );
    };
    
    _socketService.onCourseDeleted = (data) {
      _showRealtimeNotification(
        '❌ Course Removed',
        data['message'] ?? 'A course has been removed',
        Icons.delete,
        Colors.red,
      );
    };
    
    _socketService.init();
  }

  void _showRealtimeNotification(String title, String body, IconData icon, Color color) {
    if (!_notificationsEnabled) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    body,
                    style: const TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.deepPurple.shade900,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'View',
          textColor: Colors.amber,
          onPressed: () {
            _showNotificationsDialog();
          },
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Color _getTypeColor(String? type) {
    switch (type) {
      case 'success':
        return Colors.green;
      case 'warning':
        return Colors.orange;
      case 'error':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  void _showNotificationsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.notifications, color: Colors.deepPurple),
            const SizedBox(width: 10),
            const Text('Notifications'),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: _realtimeNotifications.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications_off, size: 50, color: Colors.grey),
                      SizedBox(height: 10),
                      Text('No notifications yet'),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _realtimeNotifications.length,
                  itemBuilder: (context, index) {
                    final notif = _realtimeNotifications[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: _getTypeColor(notif['type']),
                          child: Icon(
                            notif['type'] == 'success' ? Icons.check_circle : Icons.notifications,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        title: Text(notif['title'] ?? 'Notification'),
                        subtitle: Text(notif['message'] ?? ''),
                        trailing: Text(
                          _getTimeAgo(notif['timestamp']),
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _unreadCount = 0;
              });
              Navigator.pop(context);
            },
            child: const Text('Clear All'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(String? timestamp) {
    if (timestamp == null) return 'Just now';
    // You can enhance this with intl package for better formatting
    return 'Just now';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: _getAppBarActions(),
      ),
      body: _getBody(),
      
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  // Helper method to get app bar title based on current tab
  String _getAppBarTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Search';
      case 2:
        return 'Favorites';
      case 3:
        return 'Settings';
      default:
        return 'Dashboard';
    }
  }

  // Helper method to get app bar actions based on current tab
  List<Widget> _getAppBarActions() {
    List<Widget> actions = [];
    
    // Add notification bell with badge to all tabs
    actions.add(
      Stack(
        children: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: _showNotificationsDialog,
          ),
          if (_unreadCount > 0)
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  '$_unreadCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
    
    // Add settings save button only in settings tab
    if (_currentIndex == 3) {
      actions.add(
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: () {
            _showSaveSettingsDialog();
          },
        ),
      );
    }
    
    // Add admin panel access
    actions.add(
      PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'admin') {
            Navigator.pushNamed(context, '/admin-login');
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'admin',
            child: ListTile(
              leading: Icon(Icons.admin_panel_settings, color: Colors.deepPurple),
              title: Text('Admin Panel'),
            ),
          ),
        ],
        icon: const Icon(Icons.more_vert),
      ),
    );
    
    return actions;
  }

  // Main body getter based on selected tab
  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return _buildDashboard();
      case 1:
        return _buildSearchTab();
      case 2:
        return _buildFavoritesTab();
      case 3:
        return _buildSettingsTab();
      default:
        return _buildDashboard();
    }
  }

  // Dashboard Tab
  Widget _buildDashboard() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            _buildProfileSection(),
            
            const SizedBox(height: 30),
            
            // Real-time status indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Live Updates Active',
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Welcome Text
            const Center(
              child: Text(
                'Welcome to the Dashboard!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            
            const SizedBox(height: 10),
            
            // Real-time notification hint
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.notifications_active, color: Colors.deepPurple.shade700),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'You will receive real-time notifications when admin adds new courses',
                      style: TextStyle(color: Colors.deepPurple.shade700),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Categories Section
            const Text(
              'Browse Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Categories Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () {
                    _showNepalCategoryDetails(category['name']);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: category['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: category['color'].withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          category['icon'],
                          size: 32,
                          color: category['color'],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category['name'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: category['color'],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 30),
            
            // Action Buttons
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showProfilePage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Go to Profile',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to show Nepal-specific category details with null safety
  void _showNepalCategoryDetails(String categoryName) {
    Map<String, List<Map<String, dynamic>>>? categoryData;
    Color categoryColor = Colors.blue;

    // Assign data based on category
    switch (categoryName) {
      case 'Engineering':
        categoryData = nepalEngineeringData;
        categoryColor = Colors.blue;
        break;
      case 'Medical':
        categoryData = nepalMedicalData;
        categoryColor = Colors.green;
        break;
      case 'Law':
        categoryData = nepalLawData;
        categoryColor = Colors.red;
        break;
      case 'Teaching':
        categoryData = nepalTeachingData;
        categoryColor = Colors.orange;
        break;
      case 'Business':
        categoryData = nepalBusinessData;
        categoryColor = Colors.purple;
        break;
      case 'Arts':
        categoryData = nepalArtsData;
        categoryColor = Colors.pink;
        break;
      case 'Technology':
        categoryData = nepalTechnologyData;
        categoryColor = Colors.cyan;
        break;
      case 'Science':
        categoryData = nepalScienceData;
        categoryColor = Colors.teal;
        break;
      default:
        _showSnackBar('Category not found');
        return;
    }

    // Add null check for categoryData
    if (categoryData == null) {
      _showSnackBar('No data available for $categoryName');
      return;
    }

    // Safely get courses and topColleges with null checks
    final courses = categoryData['courses'];
    final topColleges = categoryData['topColleges'];

    if (courses == null || courses.isEmpty) {
      _showSnackBar('No courses available for $categoryName');
      return;
    }

    if (topColleges == null || topColleges.isEmpty) {
      _showSnackBar('No college data available for $categoryName');
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.school, color: categoryColor),
                    const SizedBox(width: 8),
                    Text(
                      '$categoryName in Nepal',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Available courses and colleges in Nepal',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 20),
                
                // Courses Section
                const Text(
                  '📚 Available Courses',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];
                      final collegesList = course['colleges'] as List? ?? [];
                      
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: categoryColor.withOpacity(0.1),
                            child: Text('${index + 1}'),
                          ),
                          title: Text(
                            course['name'] ?? 'Unknown Course',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Duration: ${course['duration'] ?? 'N/A'}'),
                              Text('Popular Colleges: ${collegesList.take(2).join(', ')}...'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.favorite_border, color: categoryColor),
                            onPressed: () {
                              _addToFavorites('${course['name']} - $categoryName');
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Top Colleges Section
                const Text(
                  '🏛️ Top Colleges in Nepal',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: topColleges.length,
                    itemBuilder: (context, index) {
                      final college = topColleges[index];
                      
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: categoryColor,
                            child: Text(
                              college['ranking'] ?? 'N/A',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            college['name'] ?? 'Unknown College',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('📍 ${college['location'] ?? 'N/A'}'),
                              Text('💰 ${college['fee'] ?? 'N/A'}'),
                            ],
                          ),
                          isThreeLine: true,
                          trailing: IconButton(
                            icon: const Icon(Icons.info_outline),
                            onPressed: () {
                              _showCollegeDetails(college, categoryColor);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showCollegeDetails(Map<String, dynamic> college, Color color) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(college['name'] ?? 'College Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: color),
                  const SizedBox(width: 8),
                  Text('Location: ${college['location'] ?? 'N/A'}'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.star, color: color),
                  const SizedBox(width: 8),
                  Text('Ranking: #${college['ranking'] ?? 'N/A'} in Nepal'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.attach_money, color: color),
                  const SizedBox(width: 8),
                  Text('Fee: ${college['fee'] ?? 'N/A'}'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Admission Requirements:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text('• Minimum 50% in +2 Science'),
            const Text('• Entrance exam required'),
            const Text('• Interview process'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _addToFavorites(college['name'] ?? 'College');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
            ),
            child: const Text('Add to Favorites'),
          ),
        ],
      ),
    );
  }

  // Profile Section Widget
  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
              'https://via.placeholder.com/150',
            ),
            child: Icon(Icons.person, size: 40, color: Colors.deepPurple),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'john.doe@example.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    'Student',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              _showEditProfileDialog();
            },
          ),
        ],
      ),
    );
  }

  // Search Tab
  Widget _buildSearchTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search for categories, courses...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
            onSubmitted: (value) {
              _performSearch(value);
            },
          ),
          
          const SizedBox(height: 20),
          
          // Recent Searches
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Recent Searches',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          
          const SizedBox(height: 10),
          
          // Recent search items
          Expanded(
            child: ListView(
              children: [
                _buildSearchItem('Engineering courses in Nepal'),
                _buildSearchItem('Medical colleges in Kathmandu'),
                _buildSearchItem('Law programs in Nepal'),
                _buildSearchItem('Teaching certification in Nepal'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Search Item Widget
  Widget _buildSearchItem(String query) {
    return ListTile(
      leading: const Icon(Icons.history, color: Colors.deepPurple),
      title: Text(query),
      trailing: const Icon(Icons.arrow_forward, size: 16),
      onTap: () {
        _performSearch(query);
      },
    );
  }

  // Favorites Tab
  Widget _buildFavoritesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Your Favorite Categories',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        
        const SizedBox(height: 16),
        
        // Favorite items
        _buildFavoriteItem(
          'Engineering',
          Icons.engineering,
          Colors.blue,
          '8 courses available in Nepal',
        ),
        
        _buildFavoriteItem(
          'Medical',
          Icons.medical_services,
          Colors.green,
          '8 courses available in Nepal',
        ),
        
        _buildFavoriteItem(
          'Technology',
          Icons.computer,
          Colors.cyan,
          '4 courses available in Nepal',
        ),
        
        const SizedBox(height: 20),
        
        const Text(
          'Saved Courses',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        
        const SizedBox(height: 10),
        
        // Saved courses
        _buildSavedCourseItem(
          'Civil Engineering',
          'Pulchowk Campus',
          '4.5',
        ),
        
        _buildSavedCourseItem(
          'MBBS',
          'IOM Teaching Hospital',
          '4.8',
        ),
        
        _buildSavedCourseItem(
          'LLB',
          'Nepal Law Campus',
          '4.3',
        ),
      ],
    );
  }

  // Favorite Item Widget
  Widget _buildFavoriteItem(String name, IconData icon, Color color, String details) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(details),
        trailing: IconButton(
          icon: const Icon(Icons.favorite, color: Colors.red),
          onPressed: () {
            _removeFromFavorites(name);
          },
        ),
        onTap: () {
          _showNepalCategoryDetails(name);
        },
      ),
    );
  }

  // Saved Course Item Widget
  Widget _buildSavedCourseItem(String courseName, String college, String rating) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(courseName),
        subtitle: Text(college),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, size: 16, color: Colors.amber.shade700),
            const SizedBox(width: 4),
            Text(rating),
          ],
        ),
      ),
    );
  }

  // Settings Tab
  Widget _buildSettingsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Account Settings Section
        const Text(
          'Account Settings',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        
        const SizedBox(height: 10),
        
        // Change Password
        ListTile(
          leading: const Icon(Icons.lock, color: Colors.deepPurple),
          title: const Text('Change Password'),
          subtitle: const Text('Update your password'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            _showChangePasswordDialog();
          },
        ),
        
        // Email Settings
        ListTile(
          leading: const Icon(Icons.email, color: Colors.deepPurple),
          title: const Text('Email Settings'),
          subtitle: const Text('Manage email preferences'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            _showEmailSettingsDialog();
          },
        ),
        
        const Divider(height: 30),
        
        // Appearance Section
        const Text(
          'Appearance',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        
        const SizedBox(height: 10),
        
        // Dark Mode Switch
        SwitchListTile(
          secondary: const Icon(Icons.dark_mode, color: Colors.deepPurple),
          title: const Text('Dark Mode'),
          subtitle: const Text('Enable dark theme'),
          value: _isDarkMode,
          onChanged: (value) {
            setState(() {
              _isDarkMode = value;
            });
            _showSnackBar('Dark mode ${value ? 'enabled' : 'disabled'}');
          },
        ),
        
        // Language Selection
        ListTile(
          leading: const Icon(Icons.language, color: Colors.deepPurple),
          title: const Text('Language'),
          subtitle: Text(_selectedLanguage),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            _showLanguageDialog();
          },
        ),
        
        const Divider(height: 30),
        
        // Notifications Section
        const Text(
          'Notifications',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        
        const SizedBox(height: 10),
        
        // Push Notifications Switch
        SwitchListTile(
          secondary: const Icon(Icons.notifications, color: Colors.deepPurple),
          title: const Text('Push Notifications'),
          subtitle: const Text('Receive real-time notifications'),
          value: _notificationsEnabled,
          onChanged: (value) {
            setState(() {
              _notificationsEnabled = value;
            });
            _showSnackBar('Notifications ${value ? 'enabled' : 'disabled'}');
          },
        ),
        
        // Notification Sound
        ListTile(
          leading: const Icon(Icons.volume_up, color: Colors.deepPurple),
          title: const Text('Notification Sound'),
          subtitle: const Text('Default'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            _showSoundDialog();
          },
        ),
        
        const Divider(height: 30),
        
        // Privacy & Security
        const Text(
          'Privacy & Security',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        
        const SizedBox(height: 10),
        
        // Biometric Login
        SwitchListTile(
          secondary: const Icon(Icons.fingerprint, color: Colors.deepPurple),
          title: const Text('Biometric Login'),
          subtitle: const Text('Use fingerprint/face to login'),
          value: _biometricEnabled,
          onChanged: (value) {
            setState(() {
              _biometricEnabled = value;
            });
            _showSnackBar('Biometric login ${value ? 'enabled' : 'disabled'}');
          },
        ),
        
        // Privacy Policy
        ListTile(
          leading: const Icon(Icons.privacy_tip, color: Colors.deepPurple),
          title: const Text('Privacy Policy'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            _showPrivacyPolicy();
          },
        ),
        
        // Terms of Service
        ListTile(
          leading: const Icon(Icons.description, color: Colors.deepPurple),
          title: const Text('Terms of Service'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            _showTermsOfService();
          },
        ),
        
        const Divider(height: 30),
        
        // Danger Zone
        const Text(
          'Danger Zone',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
        ),
        
        const SizedBox(height: 10),
        
        // Logout Button
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text(
            'Logout',
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {
            _showLogoutDialog();
          },
        ),
        
        // Delete Account
        ListTile(
          leading: const Icon(Icons.delete_forever, color: Colors.red),
          title: const Text(
            'Delete Account',
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {
            _showDeleteAccountDialog();
          },
        ),
      ],
    );
  }

  // Dialog Methods
  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Current Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar('Password changed successfully');
            },
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }

  void _showEmailSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Email Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
              title: Text('Receive newsletter'),
              trailing: Icon(Icons.check_box),
            ),
            const ListTile(
              title: Text('Course recommendations'),
              trailing: Icon(Icons.check_box),
            ),
            const ListTile(
              title: Text('Promotional emails'),
              trailing: Icon(Icons.check_box_outline_blank),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              onTap: () {
                setState(() {
                  _selectedLanguage = 'English';
                });
                Navigator.pop(context);
                _showSnackBar('Language changed to English');
              },
            ),
            ListTile(
              title: const Text('Nepali'),
              onTap: () {
                setState(() {
                  _selectedLanguage = 'Nepali';
                });
                Navigator.pop(context);
                _showSnackBar('Language changed to Nepali');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSoundDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notification Sound'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Default'),
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Sound set to Default');
              },
            ),
            ListTile(
              title: const Text('Chime'),
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Sound set to Chime');
              },
            ),
            ListTile(
              title: const Text('Bell'),
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Sound set to Bell');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const SizedBox(
          width: double.maxFinite,
          child: Text(
            'This is a sample privacy policy. Your privacy is important to us. '
            'We collect and use your information to provide and improve our services. '
            'We do not share your personal information with third parties without your consent.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showTermsOfService() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms of Service'),
        content: const SizedBox(
          width: double.maxFinite,
          child: Text(
            'These are the terms of service. By using this application, '
            'you agree to comply with and be bound by these terms.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar('Logged out successfully');
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar('Account deleted');
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              value: 'Student',
              decoration: const InputDecoration(
                labelText: 'Role',
                border: OutlineInputBorder(),
              ),
              items: ['Student', 'Teacher', 'Professional'].map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar('Profile updated');
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showSaveSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Save Settings'),
        content: const Text('Do you want to save your settings?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar('Settings saved');
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showProfilePage() {
    setState(() {
      _currentIndex = 3; // Navigate to settings tab
    });
    _showSnackBar('Viewing profile settings');
  }

  void _showNotifications() {
    _showNotificationsDialog();
  }

  void _performSearch(String query) {
    _showSnackBar('Searching for: $query in Nepal');
  }

  void _removeFromFavorites(String item) {
    _showSnackBar('Removed from favorites: $item');
  }

  void _addToFavorites(String item) {
    _showSnackBar('Added to favorites: $item');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _socketService.dispose();
    super.dispose();
  }
}