import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jovera_finance/utilities/localization/app_localizations.dart';

void main() {
  test('tr returns a localized value when available', () {
    final localizations = AppLocalizations(const Locale('en', 'US'));
    expect(localizations.tr('Low interest rates'), 'Low interest rates');
  });

  test('tr returns a non-key value for known Arabic translations', () {
    final localizations = AppLocalizations(const Locale('ar', 'SA'));
    const key = 'Low interest rates';
    expect(localizations.tr(key), isNot(key));
  });

  test('tr falls back to the key when missing', () {
    final localizations = AppLocalizations(const Locale('en', 'US'));
    expect(localizations.tr('missing_key'), 'missing_key');
  });
}
