import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/onboarding_screen.dart';
import 'screens/main_screen.dart';
import 'utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BoomApp());
}

class BoomApp extends StatefulWidget {
  const BoomApp({Key? key}) : super(key: key);

  @override
  State<BoomApp> createState() => _BoomAppState();
}

class _BoomAppState extends State<BoomApp> {
  ThemeMode _themeMode = ThemeMode.light;
  String _currentTheme = 'light';

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('appTheme') ?? 'light';
    setState(() {
      _currentTheme = savedTheme;
      _themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void updateTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('appTheme', theme);
    setState(() {
      _currentTheme = theme;
      _themeMode = theme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boom',
      debugShowCheckedModeBanner: false,
      theme: _currentTheme == 'sepia' 
          ? AppThemes.sepiaTheme 
          : AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: _themeMode,
      home: OnboardingWrapper(
        onThemeChanged: updateTheme,
        currentTheme: _currentTheme,
      ),
    );
  }
}

class OnboardingWrapper extends StatefulWidget {
  final Function(String) onThemeChanged;
  final String currentTheme;

  const OnboardingWrapper({
    Key? key,
    required this.onThemeChanged,
    required this.currentTheme,
  }) : super(key: key);

  @override
  State<OnboardingWrapper> createState() => _OnboardingWrapperState();
}

class _OnboardingWrapperState extends State<OnboardingWrapper> {
  bool _showOnboarding = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkOnboarding();
  }

  Future<void> _checkOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    setState(() {
      _showOnboarding = !hasSeenOnboarding;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_showOnboarding) {
      return OnboardingScreen(
        onComplete: () async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('hasSeenOnboarding', true);
          setState(() {
            _showOnboarding = false;
          });
        },
      );
    }

    return MainScreen(
      onThemeChanged: widget.onThemeChanged,
      currentTheme: widget.currentTheme,
    );
  }
}

class AppThemes {
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.lightBg,
        primaryColor: AppColors.accentRed,
        colorScheme: ColorScheme.light(
          primary: AppColors.accentRed,
          secondary: AppColors.lightSecondary,
          background: AppColors.lightBg,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.lightBg,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.darkText),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.darkText),
          bodyMedium: TextStyle(color: AppColors.darkText),
          titleLarge: TextStyle(color: AppColors.darkText),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBg,
        primaryColor: AppColors.accentRed,
        colorScheme: ColorScheme.dark(
          primary: AppColors.accentRed,
          secondary: AppColors.darkSecondary,
          background: AppColors.darkBg,
          surface: AppColors.darkSecondary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.darkBg,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.lightText),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.lightText),
          bodyMedium: TextStyle(color: AppColors.lightText),
          titleLarge: TextStyle(color: AppColors.lightText),
        ),
      );

  static ThemeData get sepiaTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.sepiaBg,
        primaryColor: AppColors.accentBurgundy,
        colorScheme: ColorScheme.light(
          primary: AppColors.accentBurgundy,
          secondary: AppColors.lightSecondary,
          background: AppColors.sepiaBg,
          surface: AppColors.lightSecondary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.sepiaBg,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.sepiaText),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.sepiaText),
          bodyMedium: TextStyle(color: AppColors.sepiaText),
          titleLarge: TextStyle(color: AppColors.sepiaText),
        ),
      );
}
