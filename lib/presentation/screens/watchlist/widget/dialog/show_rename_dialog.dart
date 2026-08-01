import 'package:trade_app/exports/exports.dart';

void showRenameDialog(BuildContext context, Watchlist watchlist) {
  final controller = TextEditingController(text: watchlist.name);

  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: Text(
        AppStrings.renameWatchlist,
        style: TextStyle(
          color: AppColors.deepMidNightColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: TextField(
        controller: controller,
        style: TextStyle(color: AppColors.deepMidNightColor),
        decoration: InputDecoration(
          hintText: AppStrings.enterNewName,
          hintStyle: TextStyle(
            color: AppColors.semiBlackColor.withValues(alpha: 0.5),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.semiBlackColor.withValues(alpha: 0.3),
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.deepMidNightColor,
              width: 2,
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: Text(
            AppStrings.cancel,
            style: TextStyle(color: AppColors.semiBlackColor),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.deepMidNightColor,
          ),
          onPressed: () {
            if (controller.text.trim().isNotEmpty) {
              context.read<WatchlistBloc>().add(
                RenameWatchlistEvent(watchlist.id, controller.text.trim()),
              );
              Navigator.pop(dialogContext);
            }
          },
          child: Text(
            AppStrings.save,
            style: TextStyle(color: AppColors.whiteColor),
          ),
        ),
      ],
    ),
  );
}
