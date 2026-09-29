import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/phone_login_screen.dart';
import 'state/registration_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RegistrationState(),
      child: const DojoWalkerRegistrationApp(),
    ),
  );
}

class DojoWalkerRegistrationApp extends StatelessWidget {
  const DojoWalkerRegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dojo Walker Registration',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE86100),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor:
            const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF171717),
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const RegistrationHomeScreen(),
    );
  }
}

class RegistrationHomeScreen extends StatelessWidget {
  const RegistrationHomeScreen({super.key});

  void _startRegistration(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const PhoneLoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dojo Walker',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Text(
                'Become a Dojo Walker',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF171717),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Register with Dojo Walk and start your walker onboarding journey.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xFF4B5563),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed: () {
                    _startRegistration(context);
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFE86100),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Start Registration',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Dojo Walker Registration',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
