import 'package:trade_app/exports/exports.dart';

void showCreateDialog(BuildContext context) {
  final controller = TextEditingController();
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: Text(
        AppStrings.createNewWatchlist,
        style: TextStyle(color: AppColors.deepMidNightColor),
      ),
      content: TextField(
        controller: controller,
        style: TextStyle(color: AppColors.deepMidNightColor),
        decoration: InputDecoration(
          hintText: AppStrings.watchlistName,
          hintStyle: TextStyle(color: AppColors.greyColor),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.greyColor),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: Text(
            AppStrings.cancel,
            style: TextStyle(color: AppColors.greyColor),
          ),
        ),
        AppButton(
          title: AppStrings.create,
          onPressed: () {
            if (controller.text.isNotEmpty) {
              context.read<WatchlistBloc>().add(
                CreateWatchlistEvent(controller.text.trim()),
              );
              Navigator.pop(dialogContext);
            }
          },
        ),
      ],
    ),
  );
}
