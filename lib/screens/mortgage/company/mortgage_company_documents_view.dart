import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/mortgage/controller/mortgage_controller.dart';
import 'package:jovera_finance/screens/mortgage/common/property_details_view.dart';
import 'package:jovera_finance/screens/mortgage/widget/upload_document_widget.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';

class MortgageCompanyDocumentsView extends ConsumerWidget {
  const MortgageCompanyDocumentsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(mortgageControllerProvider.notifier);
    ref.watch(mortgageControllerProvider);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                CustomPageTitle(
                  back: true,
                  notification: false,
                  title: "Required Documents",
                ),
                SizedBox(height: fullHeight * 0.05),
                UploadDocumentWidget(
                  onTap: () => controller.selectPassportDocument(context),
                  text: "Passport",
                  filePath: controller.passportDocument.filePath ?? "",
                  isPdf:
                      controller.passportDocument.fileName?.endsWith('pdf') ??
                      false,
                ),
                UploadDocumentWidget(
                  onTap: () => controller.selectEmiratesIdDocument(context),
                  text: "Emirates ID",
                  filePath: controller.emiratesIdDocument.filePath ?? "",
                  isPdf:
                      controller.emiratesIdDocument.fileName?.endsWith('pdf') ??
                      false,
                ),
                UploadDocumentWidget(
                  onTap: () => controller.selectTradeLicenseDocument(context),
                  text: "Trade License",
                  filePath: controller.tradeLicenseDocument.filePath ?? "",
                  isPdf:
                      controller.tradeLicenseDocument.fileName?.endsWith(
                        'pdf',
                      ) ??
                      false,
                ),
                UploadDocumentWidget(
                  onTap:
                      () => controller.selectSalaryCertificateDocument(context),
                  text: "Valid Salary Certificate",
                  filePath:
                      controller.salaryCertificateDocument.filePath ?? "",
                  isPdf:
                      controller.salaryCertificateDocument.fileName?.endsWith(
                        'pdf',
                      ) ??
                      false,
                ),
                UploadDocumentWidget(
                  text: "Last 12 months Bank statement",
                  onTap: () => controller.selectBankStatementDocument(context),
                  filePath: controller.bankStatementDocument.filePath ?? "",
                  isPdf:
                      controller.bankStatementDocument.fileName?.endsWith(
                        'pdf',
                      ) ??
                      false,
                ),
                UploadDocumentWidget(
                  text: "Etihad Bureau + Company",
                  onTap: () => controller.selectEtihadDocument(context),
                  filePath: controller.etihadBureauDocument.filePath ?? "",
                  isPdf:
                      controller.etihadBureauDocument.fileName?.endsWith(
                        'pdf',
                      ) ??
                      false,
                ),
                UploadDocumentWidget(
                  text: "Last 4 VAT Payments",
                  onTap: () => controller.selectVATDocument(context),
                  filePath:
                      controller.fourVATPaymentsDocument.filePath ?? "",
                  isPdf:
                      controller.fourVATPaymentsDocument.fileName?.endsWith(
                        'pdf',
                      ) ??
                      false,
                ),
              ],
            ),
          ),

          CustomButton(
            onPressed: () {
              AppNavigator.push(const PropertyDetailsView());
            },
            text: "Next",
          ),
          SizedBox(height: fullHeight * 0.05),
        ],
      ).paddingSymmetric(
        horizontal: horizontalPagePadding,
        vertical: verticalPagePadding,
      ),
    );
  }
}
