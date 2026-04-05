import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';

class SocketService {
  late IO.Socket socket;
  late String serverUrl;
  bool isConnected = false;
  
  // Callbacks
  Function(Map<String, dynamic>)? onNewCourse;
  Function(Map<String, dynamic>)? onCourseUpdated;
  Function(Map<String, dynamic>)? onCourseDeleted;
  Function(Map<String, dynamic>)? onNotification;
  Function()? onConnect;
  Function()? onDisconnect;
  
  SocketService({required this.serverUrl});
  
  void init() {
    print('🔌 Connecting to socket at: $serverUrl');
    
    socket = IO.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'reconnection': true,
      'reconnectionAttempts': 10,
      'reconnectionDelay': 1000,
    });
    
    socket.onConnect((_) {
      print('✅ Connected to server: ${socket.id}');
      isConnected = true;
      socket.emit('join-user');
      if (onConnect != null) onConnect!();
    });
    
    socket.onConnectError((error) {
      print('❌ Connection error: $error');
      isConnected = false;
    });
    
    socket.on('new-course', (data) {
      print('📚 New course received: $data');
      if (onNewCourse != null) {
        onNewCourse!(data);
      }
    });
    
    socket.on('course-updated', (data) {
      print('✏️ Course updated: $data');
      if (onCourseUpdated != null) {
        onCourseUpdated!(data);
      }
    });
    
    socket.on('course-deleted', (data) {
      print('🗑️ Course deleted: $data');
      if (onCourseDeleted != null) {
        onCourseDeleted!(data);
      }
    });
    
    socket.on('notification', (data) {
      print('🔔 Notification received: $data');
      if (onNotification != null) {
        onNotification!(data);
      }
    });
    
    socket.onDisconnect((_) {
      print('🔌 Disconnected from server');
      isConnected = false;
      if (onDisconnect != null) onDisconnect!();
    });
    
    socket.onError((error) {
      print('⚠️ Socket error: $error');
      isConnected = false;
    });
  }
  
  void dispose() {
    socket.disconnect();
    socket.dispose();
  }
}