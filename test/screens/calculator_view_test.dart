import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jovera_finance/screens/bottom_navigation/calculator/controller/calculator_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/calculator/view/calculator_view.dart';
import 'package:jovera_finance/screens/bottom_navigation/home/model/main_service_model.dart';
import 'package:jovera_finance/screens/main_drawer/notification/controller/notification_controller.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';

class TestNotificationController extends NotificationController {
  TestNotificationController(Ref ref) : super(ref);

  @override
  Future<void> getNotifications() async {}
}

class TestCalculatorController extends CalculatorController {
  TestCalculatorController(this.tapped, Ref ref) : super(ref) {
    state = state.copyWith(
      servicesList: <MainServiceModel>[
        MainServiceModel(
          id: 1,
          title: 'Mortgage',
          iconPath: 'assets/icons/mortgage_icon.svg',
          onTap: () => tapped.add(1),
        ),
        MainServiceModel(
          id: 2,
          title: 'Personal Loan',
          iconPath: 'assets/icons/personal_loan_icon.svg',
          onTap: () => tapped.add(2),
        ),
        MainServiceModel(
          id: 3,
          title: 'Business Loan',
          iconPath: 'assets/icons/business_loan_icon.svg',
          onTap: () => tapped.add(3),
        ),
        MainServiceModel(
          id: 4,
          title: 'Car Loan',
          iconPath: 'assets/icons/car_loan_icon.svg',
          onTap: () => tapped.add(4),
        ),
      ],
    );
  }

  final List<int> tapped;
}

void main() {
  testWidgets('CalculatorView renders services and handles taps', (
    WidgetTester tester,
  ) async {
    final tapped = <int>[];
    final container = ProviderContainer(
      overrides: [
        calculatorControllerProvider.overrideWith(
          (ref) => TestCalculatorController(tapped, ref),
        ),
        notificationControllerProvider.overrideWith(
          (ref) => TestNotificationController(ref),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          navigatorKey: AppNavigator.key,
          home: const Scaffold(body: CalculatorView()),
        ),
      ),
    );

    expect(find.text('Calculator'), findsOneWidget);
    expect(find.text('Mortgage'), findsOneWidget);
    expect(find.text('Personal Loan'), findsOneWidget);
    expect(find.text('Business Loan'), findsOneWidget);
    expect(find.text('Car Loan'), findsOneWidget);
    expect(find.byType(InkWell), findsNWidgets(4));

    await tester.tap(find.text('Personal Loan'));
    await tester.pump();

    expect(container.read(calculatorControllerProvider).selectedService, 1);
    expect(tapped, contains(2));
  });
}
