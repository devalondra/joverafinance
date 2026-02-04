import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jovera_finance/utilities/localization/app_localizations.dart';

class LocaleController extends StateNotifier<Locale> {
  LocaleController(this._storage) : super(_loadInitialLocale(_storage));

  static const _storageKey = 'language';
  final GetStorage _storage;

  static Locale _loadInitialLocale(GetStorage storage) {
    final String? currentLocale = storage.read(_storageKey);
    if (currentLocale == 'en_US') return const Locale('en', 'US');
    if (currentLocale == 'ar_SA') return const Locale('ar', 'SA');
    return AppLocalizations.supportedLocales.first;
  }

  Future<void> setLocale(String langCode) async {
    if (langCode == 'en_US') {
      state = const Locale('en', 'US');
      await _storage.write(_storageKey, 'en_US');
    } else if (langCode == 'ar_SA') {
      state = const Locale('ar', 'SA');
      await _storage.write(_storageKey, 'ar_SA');
    }
  }
}

final localeControllerProvider =
    StateNotifierProvider<LocaleController, Locale>((ref) {
  return LocaleController(GetStorage());
});
