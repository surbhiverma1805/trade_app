import 'package:trade_app/exports/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate initialization delay
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepMidNightColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              // Logo Container
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B), // Dark Slate surface
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.trending_up_rounded,
                  size: 64.w,
                  color: AppColors.primary,
                ),
              ),
              25.toSpace(),

              // App Title
              Text(
                AppStrings.tradePulse,
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: AppColors.whiteColor,
                ),
              ),
              8.toSpace(),

              // Subtitle
              Text(
                AppStrings.realTimeMarketSimulation,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.slateGreyColor,
                  letterSpacing: 0.5,
                ),
              ),
              48.toSpace(),

              // Loading Indicator
              Loader(),

              10.toSpace(),
              // Footer Version Info
              Padding(
                padding: EdgeInsets.only(bottom: 24.w),
                child: Text(
                  AppStrings.version,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.slateGreyColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
