import 'package:flutter_test/flutter_test.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/model/visa_application_model.dart';

void main() {
  test('fromJson maps expected fields', () {
    final model = VisaApplicationModel.fromJson({
      'leadId': 'lead-123',
      'orderNumber': 'order-999',
      'reject': true,
      'status': 'approved',
      'salesPerson': 'Sam',
      'type_of_loan': 'mortgage',
      'submissionDate': '2024-01-01',
      'description': 'Test description',
    });

    expect(model.id, 'lead-123');
    expect(model.orderNumber, 'order-999');
    expect(model.isRejected, isTrue);
    expect(model.status, 'approved');
    expect(model.salesPerson, 'Sam');
    expect(model.typeOfLoan, 'mortgage');
    expect(model.submittedAt, '2024-01-01');
    expect(model.description, 'Test description');
  });
}
