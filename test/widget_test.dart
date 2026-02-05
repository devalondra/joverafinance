import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jovera_finance/utilities/localization/app_localizations.dart';

void main() {
  testWidgets('AppLocalizations delegate supports expected locales', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: [AppLocalizations.delegate],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: Text('ok')),
      ),
    );

    expect(
      AppLocalizations.delegate.isSupported(const Locale('en', 'US')),
      isTrue,
    );
    expect(
      AppLocalizations.delegate.isSupported(const Locale('ar', 'SA')),
      isTrue,
    );
    expect(
      AppLocalizations.delegate.isSupported(const Locale('es', 'ES')),
      isFalse,
    );
  });
}
