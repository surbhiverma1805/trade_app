import 'package:trade_app/exports/exports.dart';

class WatchlistItem extends StatelessWidget {
  const WatchlistItem({
    super.key,
    required this.isSelected,
    required this.watchlist,
    required this.watchListLen,
  });

  final bool isSelected;
  final Watchlist watchlist;
  final int watchListLen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.deepMidNightColor
            : AppColors.semiWhiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.deepMidNightColor, width: 1),
      ),
      child: Row(
        children: [
          Text(
            watchlist.name,
            style: TextStyle(
              color: isSelected
                  ? AppColors.whiteColor
                  : AppColors.semiBlackColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          // Three dots options menu per chip
          if (isSelected) ...[
            5.toSpace(vertically: false),
            PopupMenuButton<String>(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: 0,
              color: AppColors.semiWhiteColor,
              onSelected: (value) {
                if (value == 'rename') {
                  showRenameDialog(context, watchlist);
                } else if (value == 'delete') {
                  showDeleteConfirmation(context, watchlist, watchListLen);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'rename',
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: AppColors.deepMidNightColor,
                        size: 15.sp,
                      ),
                      15.toSpace(vertically: false),
                      Text(
                        AppStrings.rename,
                        style: TextStyle(color: AppColors.deepMidNightColor),
                      ),
                    ],
                  ),
                ),
                if (watchListLen > 1)
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outline,
                          color: AppColors.deepMidNightColor,
                          size: 15.sp,
                        ),
                        15.toSpace(vertically: false),
                        Text(
                          AppStrings.delete,
                          style: TextStyle(color: AppColors.deepMidNightColor),
                        ),
                      ],
                    ),
                  ),
              ],
              child: Icon(
                Icons.more_vert,
                size: 16.sp,
                color: isSelected
                    ? AppColors.whiteColor
                    : AppColors.semiBlackColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
