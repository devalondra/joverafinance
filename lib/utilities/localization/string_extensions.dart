import 'package:jovera_finance/utilities/localization/app_localizations.dart';
import 'package:jovera_finance/utilities/navigation/app_context.dart';

extension LocalizationStringExtension on String {
  String get tr {
    final context = AppContext.context;
    if (context == null) return this;
    return AppLocalizations.of(context)?.tr(this) ?? this;
  }

  bool get isNum => num.tryParse(this) != null;
}
