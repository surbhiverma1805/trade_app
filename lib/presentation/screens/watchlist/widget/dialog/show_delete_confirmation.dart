import 'package:trade_app/exports/exports.dart';

void showDeleteConfirmation(
  BuildContext context,
  Watchlist watchlist,
  int totalWatchlist,
) {
  if (totalWatchlist <= 1) {
    return; // Safety check to prevent deleting the last list
  }

  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: Text(
        AppStrings.deleteWatchlist,
        style: TextStyle(
          color: AppColors.deepMidNightColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        '${AppStrings.areYouSureYouWantToDelete} "${watchlist.name}"? ${AppStrings.thisActionCannotBeDone}',
        style: TextStyle(color: AppColors.semiBlackColor),
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
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.redColor),
          onPressed: () {
            context.read<WatchlistBloc>().add(
              DeleteWatchlistEvent(watchlist.id),
            );
            Navigator.pop(dialogContext);
          },
          child: Text(
            AppStrings.deleteWatchlist,
            style: TextStyle(color: AppColors.whiteColor),
          ),
        ),
      ],
    ),
  );
}
