import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qtec_task/config/injection.dart';
import 'package:qtec_task/config/theme/custome_theme.dart';
import 'package:qtec_task/core/services/navigation_service.dart';
import 'package:qtec_task/core/utils/helper_methods.dart';
import 'package:qtec_task/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  diSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    rotation();
    setInitValue();

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, result) async {
        showMaterialDialog(context,
            title: 'Do you want to exit the app?',
            btnName1: 'No',
            btnName2: 'Yes', onTapbutton1: () {
          Navigator.of(context).pop(false);
        }, onTapbutton2: () {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        });
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return const AdaptiveScreen();
        },
      ),
    );
  }
}

class AdaptiveScreen extends StatelessWidget {
  const AdaptiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Mobile Layout
        return const MobileLayout();
      },
    );
  }
}

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, context) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: CustomTheme.kToDark,
              useMaterial3: false,
              scaffoldBackgroundColor: Colors.white,
            ),
            debugShowCheckedModeBanner: false,
            builder: (context, widget) {
              return MediaQuery(data: MediaQuery.of(context), child: widget!);
            },
            navigatorKey: NavigationService.navigatorKey,
            home: Loading(),
          );
        });
  }
}
