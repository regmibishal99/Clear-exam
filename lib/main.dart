import 'package:clear_exam/screens/user/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/course_provider.dart';
import 'providers/notification_provider.dart';
import 'screens/user/splash_screen.dart';  // You have splash_screen.dart
import 'screens/user/login.dart';           // You have login.dart
import 'screens/user/dashboard.dart';       // You have dashboard.dart
import 'screens/admin/admin_login_screen.dart';
import 'screens/admin/admin_dashboard_screen.dart';
import 'screens/admin/admin_courses_screen.dart';
import 'screens/admin/admin_notifications_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<CourseProvider>(create: (_) => CourseProvider()),
        ChangeNotifierProvider<NotificationProvider>(create: (_) => NotificationProvider()),
      ],
      child: MaterialApp(
        title: 'Exam App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        initialRoute: '/',
        routes: {
          // User routes
          '/': (context) => const SplashScreen(),  // Use your splash screen as initial
          '/login': (context) => const Login(),     // Your login screen
          '/signup': (context) => const SignupPage(), // From your previous code
          '/dashboard': (context) => const Dashboard(), // Your dashboard
          
          // Admin routes
          '/admin-login': (context) => const AdminLoginScreen(),
          '/admin-dashboard': (context) => const AdminDashboardScreen(),
          '/admin-courses': (context) => const AdminCoursesScreen(),
          '/admin-notifications': (context) => const AdminNotificationsScreen(),
        },
      ),
    );
  }
}