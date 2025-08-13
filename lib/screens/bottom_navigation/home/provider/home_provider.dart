import 'package:jovera_finance/utilities/api/api_abstract.dart';
import 'package:jovera_finance/utilities/constants/app_enums.dart';

class HomeProvider {
  Future<void> visaByOrderNumber({
    Function()? beforeSend,
    Function(dynamic response)? onSuccess,
    Function(dynamic error)? onError,
    required String orderNumber,
  }) async {
    await ApiAbstract(
      apiName: '/api/visa-application/by-order-number',
      data: {"orderNumber": "ORD-1750234588487-9644"},
    ).get(
      optionsEnum: OptionsEnum.auth,
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (response) => {if (onSuccess != null) onSuccess(response)},
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}
