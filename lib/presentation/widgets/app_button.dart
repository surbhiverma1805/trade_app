import 'package:trade_app/exports/exports.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.title, required this.onPressed});
  
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.deepMidNightColor,
        elevation: 0,
      ),
      onPressed: onPressed,
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(
        title,
        style: TextStyle(color: AppColors.whiteColor),
      ),
    );
  }
}
