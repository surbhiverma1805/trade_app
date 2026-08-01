import'package:trade_app/exports/exports.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Initialize the SizeConfig singleton
    SizeConfig.init(context);

    return MaterialApp(
      title: 'Trade App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.deepMidNightColor,
        primaryColor: AppColors.primary,
      ),
      initialRoute: AppRoutes.initialRoute,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}