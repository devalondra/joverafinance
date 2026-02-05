import 'package:flutter_test/flutter_test.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';

void main() {
  test('isNum detects numeric strings', () {
    expect('123'.isNum, isTrue);
    expect('12.5'.isNum, isTrue);
    expect('-7'.isNum, isTrue);
    expect('abc'.isNum, isFalse);
    expect('12a'.isNum, isFalse);
  });

  test('tr returns the key when there is no context', () {
    expect('Hello'.tr, 'Hello');
  });
}
