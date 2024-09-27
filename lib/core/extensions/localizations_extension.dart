import 'package:dummy_json_app/src/l10n/app_localization.dart';
import 'package:flutter/material.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalization get l10n => AppLocalization.of(this)!;
}
