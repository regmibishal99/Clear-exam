import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/course_model.dart';

class CourseProvider extends ChangeNotifier {
  List<CourseModel> _courses = [];
  bool _isLoading = false;
  String? _error;
  
  List<CourseModel> get courses => _courses;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  Future<void> fetchCourses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final data = await ApiService.getCourses();
      _courses = data.map((json) => CourseModel.fromJson(json)).toList();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<bool> addCourse(CourseModel course) async {
    try {
      await ApiService.addCourse(course.toJson());
      await fetchCourses();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
  
  Future<bool> deleteCourse(int id) async {
    try {
      await ApiService.deleteCourse(id);
      await fetchCourses();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}