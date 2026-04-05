import 'package:flutter/material.dart';

class AppConstants {
  // API Base URL - Change this to your computer's IP for real device testing
  static const String baseUrl = 'http://localhost:3000/api';
  // For real device, use: 'http://YOUR_IP_ADDRESS:3000/api'
  
  // Categories
  static const List<String> categories = [
    'Engineering',
    'Medical',
    'Law',
    'Teaching',
    'Business',
    'Arts',
    'Technology',
    'Science',
  ];
  
  // Category Colors
  static const Map<String, Color> categoryColors = {
    'Engineering': Colors.blue,
    'Medical': Colors.green,
    'Law': Colors.red,
    'Teaching': Colors.orange,
    'Business': Colors.purple,
    'Arts': Colors.pink,
    'Technology': Colors.cyan,
    'Science': Colors.teal,
  };
  
  // Category Icons
  static const Map<String, IconData> categoryIcons = {
    'Engineering': Icons.engineering,
    'Medical': Icons.medical_services,
    'Law': Icons.gavel,
    'Teaching': Icons.school,
    'Business': Icons.business_center,
    'Arts': Icons.palette,
    'Technology': Icons.computer,
    'Science': Icons.science,
  };
}

// Add AppStrings class
class AppStrings {
  // App Title
  static const String appName = 'Clear Exam';
  
  // Authentication
  static const String login = 'Login';
  static const String signup = 'Sign Up';
  static const String logout = 'Logout';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String forgotPassword = 'Forgot Password?';
  static const String createAccount = 'Create your account';
  static const String alreadyHaveAccount = 'Already have an account?';
  static const String dontHaveAccount = "Don't have an account?";
  static const String rememberMe = 'Remember Me';
  
  // User Profile
  static const String fullName = 'Full Name';
  static const String phoneNumber = 'Phone Number';
  static const String gender = 'Gender';
  static const String dateOfBirth = 'Date of Birth';
  static const String address = 'Address';
  static const String profile = 'Profile';
  static const String editProfile = 'Edit Profile';
  
  // Dashboard
  static const String dashboard = 'Dashboard';
  static const String home = 'Home';
  static const String search = 'Search';
  static const String favorites = 'Favorites';
  static const String settings = 'Settings';
  static const String notifications = 'Notifications';
  static const String welcome = 'Welcome';
  static const String welcomeBack = 'Welcome Back!';
  static const String browseCategories = 'Browse Categories';
  
  // Courses
  static const String courses = 'Courses';
  static const String myCourses = 'My Courses';
  static const String popularCourses = 'Popular Courses';
  static const String recommendedCourses = 'Recommended for You';
  static const String duration = 'Duration';
  static const String fee = 'Fee';
  static const String eligibility = 'Eligibility';
  static const String syllabus = 'Syllabus';
  static const String pastQuestions = 'Past Questions';
  
  // Colleges
  static const String colleges = 'Colleges';
  static const String topColleges = 'Top Colleges';
  static const String location = 'Location';
  static const String ranking = 'Ranking';
  static const String website = 'Website';
  
  // Messages
  static const String success = 'Success';
  static const String error = 'Error';
  static const String warning = 'Warning';
  static const String info = 'Info';
  static const String loading = 'Loading...';
  static const String noData = 'No data available';
  static const String tryAgain = 'Try Again';
  static const String cancel = 'Cancel';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String update = 'Update';
  static const String confirm = 'Confirm';
  
  // Validation Messages
  static const String fieldRequired = 'This field is required';
  static const String validEmail = 'Please enter a valid email';
  static const String validPhone = 'Please enter a valid phone number';
  static const String passwordLength = 'Password must be at least 6 characters';
  static const String passwordMatch = 'Passwords do not match';
  static const String agreeTerms = 'Please agree to the terms and conditions';
  
  // Success Messages
  static const String loginSuccess = 'Login successful!';
  static const String signupSuccess = 'Account created successfully!';
  static const String profileUpdated = 'Profile updated successfully!';
  static const String passwordChanged = 'Password changed successfully!';
  
  // Error Messages
  static const String loginFailed = 'Login failed. Please try again.';
  static const String signupFailed = 'Signup failed. Please try again.';
  static const String networkError = 'Network error. Please check your connection.';
  static const String serverError = 'Server error. Please try again later.';
  
  // Terms
  static const String termsOfService = 'Terms of Service';
  static const String privacyPolicy = 'Privacy Policy';
  static const String agreeToTerms = 'I agree to the ';
  static const String and = ' and ';
  
  // Buttons
  static const String submit = 'Submit';
  static const String continue_text = 'Continue';
  static const String skip = 'Skip';
  static const String done = 'Done';
  static const String back = 'Back';
  static const String next = 'Next';
  
  // Categories
  static const String engineering = 'Engineering';
  static const String medical = 'Medical';
  static const String law = 'Law';
  static const String teaching = 'Teaching';
  static const String business = 'Business';
  static const String arts = 'Arts';
  static const String technology = 'Technology';
  static const String science = 'Science';
}

// Add AppColors class
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6A1B9A); // Deep Purple 800
  static const Color primaryLight = Color(0xFF9C4DFF); // Deep Purple 400
  static const Color primaryDark = Color(0xFF38006B); // Deep Purple 900
  
  // Secondary Colors
  static const Color secondary = Color(0xFF00ACC1); // Cyan 600
  static const Color secondaryLight = Color(0xFF62EFFF); // Cyan 200
  static const Color secondaryDark = Color(0xFF007C91); // Cyan 800
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color greyLight = Color(0xFFF5F5F5);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color greyDark = Color(0xFF616161);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  
  // Background Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textLight = Color(0xFFFFFFFF);
  
  // Border Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);
  
  // Category Colors
  static const Color engineering = Colors.blue;
  static const Color medical = Colors.green;
  static const Color law = Colors.red;
  static const Color teaching = Colors.orange;
  static const Color business = Colors.purple;
  static const Color arts = Colors.pink;
  static const Color technology = Colors.cyan;
  static const Color science = Colors.teal;
}

// Add AppSizes class
class AppSizes {
  // Padding
  static const double paddingExtraSmall = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingExtraLarge = 32.0;
  
  // Margin
  static const double marginSmall = 8.0;
  static const double marginMedium = 16.0;
  static const double marginLarge = 24.0;
  
  // Border Radius
  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 8.0;
  static const double borderRadiusLarge = 16.0;
  static const double borderRadiusExtraLarge = 24.0;
  static const double borderRadiusCircle = 100.0;
  
  // Font Sizes
  static const double fontSizeExtraSmall = 10.0;
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 14.0;
  static const double fontSizeLarge = 16.0;
  static const double fontSizeExtraLarge = 18.0;
  static const double fontSizeHeading1 = 24.0;
  static const double fontSizeHeading2 = 22.0;
  static const double fontSizeHeading3 = 20.0;
  static const double fontSizeTitle = 28.0;
  
  // Icon Sizes
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeExtraLarge = 48.0;
  
  // Button Sizes
  static const double buttonHeight = 48.0;
  static const double buttonWidth = 200.0;
  static const double buttonRadius = 8.0;
  
  // Card Sizes
  static const double cardElevation = 4.0;
  static const double cardRadius = 12.0;
  
  // Image Sizes
  static const double imageThumbnail = 50.0;
  static const double imageSmall = 100.0;
  static const double imageMedium = 150.0;
  static const double imageLarge = 200.0;
  
  // Height
  static const double heightSmall = 10.0;
  static const double heightMedium = 20.0;
  static const double heightLarge = 30.0;
  
  // Width
  static const double widthSmall = 10.0;
  static const double widthMedium = 20.0;
  static const double widthLarge = 30.0;
  
  // Elevation
  static const double elevationNone = 0.0;
  static const double elevationSmall = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationLarge = 8.0;
  
  // Opacity
  static const double opacityLight = 0.1;
  static const double opacityMedium = 0.5;
  static const double opacityHeavy = 0.8;
  
  // Animation Duration
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 500);
  static const Duration animationSlow = Duration(milliseconds: 800);
}

// Add AppTextStyles class (optional but useful)
class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: AppSizes.fontSizeHeading1,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: AppSizes.fontSizeHeading2,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle heading3 = TextStyle(
    fontSize: AppSizes.fontSizeHeading3,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle title = TextStyle(
    fontSize: AppSizes.fontSizeTitle,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle body = TextStyle(
    fontSize: AppSizes.fontSizeMedium,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: AppSizes.fontSizeSmall,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: AppSizes.fontSizeExtraSmall,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle button = TextStyle(
    fontSize: AppSizes.fontSizeLarge,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  
  static const TextStyle link = TextStyle(
    fontSize: AppSizes.fontSizeMedium,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
  );
}