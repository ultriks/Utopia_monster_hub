import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data/supabase_service.dart';
import 'screens/home_screen.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.instance.initialize();
  runApp(const UtopiaMonsterHubApp());
}

class UtopiaMonsterHubApp extends StatelessWidget {
  const UtopiaMonsterHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Utopia Monster Hub',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        cardColor: AppColors.surface,
        dividerColor: AppColors.divider,
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.surface,
          titleTextStyle: GoogleFonts.cinzel(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary),
        ),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          surface: AppColors.surface,
          error: AppColors.error,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
