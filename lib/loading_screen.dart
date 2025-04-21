import 'package:flutter/material.dart';
import 'package:qtec_task/core/utils/helper_methods.dart';
import 'package:qtec_task/features/home/presentations/home_screen.dart';
import 'welcome_screen.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isLoading = true;

  @override
  void initState() {
    loadInitialData();
    super.initState();
  }

  loadInitialData() async {
    await Future.delayed(Durations.extralong2);
    await setInitValue();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const WelcomeScreen();
    } else {
      return HomeScreen();
    }
  }
}
