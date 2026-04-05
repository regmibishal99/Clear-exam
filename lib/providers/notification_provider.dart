import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _notifications = [];
  bool _isLoading = false;
  String? _error;

  List<Map<String, dynamic>> get notifications => _notifications;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchNotifications() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    _notifications = [
      {
        'id': 1,
        'title': 'New Course Added',
        'message': 'Civil Engineering course now available',
        'type': 'info',
        'created_at': DateTime.now().toIso8601String(),
      },
      {
        'id': 2,
        'title': 'Admission Open',
        'message': 'MBBS admissions open at IOM',
        'type': 'success',
        'created_at': DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
      },
    ];
    
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addNotification(Map<String, dynamic> notification) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      notification['id'] = DateTime.now().millisecondsSinceEpoch;
      notification['created_at'] = DateTime.now().toIso8601String();
      _notifications.insert(0, notification);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteNotification(int id) async {
    try {
      _notifications.removeWhere((n) => n['id'] == id);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}