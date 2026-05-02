import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefUtils().init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          title: 'Hostel Hive',
          debugShowCheckedModeBanner: false,
          navigatorKey: NavigatorService.navigatorKey,
          scaffoldMessengerKey: NavigatorService.scaffoldMessengerKey,
          localizationsDelegates: const [
            AppLocalizationDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale(
              'en',
              '',
            ),
          ],
          initialRoute: AppRoutes.initialRoute,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
