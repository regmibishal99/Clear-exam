import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class ApiService {
  static String? _token;
  
  static Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
  }
  
  static Future<Map<String, String>> get _headers async {
    await _loadToken();
    return {
      'Content-Type': 'application/json',
      if (_token != null) 'Authorization': 'Bearer $_token',
    };
  }
  
  // Admin Login
  static Future<Map<String, dynamic>> adminLogin(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password, 'role': 'admin'}),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', data['token']);
        _token = data['token'];
        return data;
      } else {
        throw Exception('Login failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  
  // Get all courses
  static Future<List<dynamic>> getCourses() async {
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.baseUrl}/admin/courses'),
        headers: await _headers,
      );
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  
  // Add course
  static Future<Map<String, dynamic>> addCourse(Map<String, dynamic> course) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}/admin/courses'),
        headers: await _headers,
        body: jsonEncode(course),
      );
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to add course');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  
  // Delete course
  static Future<void> deleteCourse(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('${AppConstants.baseUrl}/admin/courses/$id'),
        headers: await _headers,
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to delete course');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  
  // Send notification
  static Future<Map<String, dynamic>> sendNotification(Map<String, dynamic> notification) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}/admin/notifications'),
        headers: await _headers,
        body: jsonEncode(notification),
      );
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to send notification');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  
  // Get notifications
  static Future<List<dynamic>> getNotifications() async {
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.baseUrl}/admin/notifications'),
        headers: await _headers,
      );
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  
  // Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    _token = null;
  }
}