import 'package:flutter/material.dart';
import '../vital_track_colors.dart';

class VitalTrackSnackBars {
  VitalTrackSnackBars._();

  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: VitalTrackColors.errorBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: VitalTrackColors.errorBorder),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Error',
              style: TextStyle(
                color: VitalTrackColors.errorTitle,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              message,
              style: const TextStyle(
                color: VitalTrackColors.errorText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
