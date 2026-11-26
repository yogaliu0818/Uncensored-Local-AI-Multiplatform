import 'dart:io';

import 'package:flutter/material.dart';

/// Optional Android battery-optimization guidance.
///
/// The original third-party plugin is no longer compatible with the current
/// Android Gradle toolchain. Background downloads and inference remain
/// available; this service avoids blocking startup on that optional prompt.
class BackgroundOptimizerService {
  static Future<void> checkAndPrompt(BuildContext context) async {
    if (!Platform.isAndroid) return;
  }

  static Future<void> openBatterySettings() async {
    if (!Platform.isAndroid) return;
  }

  static Future<bool> isOptimizationDisabled() async => true;
}
