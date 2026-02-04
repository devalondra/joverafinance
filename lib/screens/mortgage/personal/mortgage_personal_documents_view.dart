import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/mortgage/controller/mortgage_controller.dart';
import 'package:jovera_finance/screens/mortgage/common/property_details_view.dart';
import 'package:jovera_finance/screens/mortgage/widget/upload_document_widget.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_tools.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';

class MortgagePersonalDocumentsView extends ConsumerWidget {
  const MortgagePersonalDocumentsView({super.key});

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
                  text: "Last 6 months Bank statement",
                  onTap: () => controller.selectBankStatementDocument(context),
                  filePath: controller.bankStatementDocument.filePath ?? "",
                  isPdf:
                      controller.bankStatementDocument.fileName?.endsWith(
                        'pdf',
                      ) ??
                      false,
                ),
                UploadDocumentWidget(
                  text: "Credit Bureau Report",
                  onTap: () => controller.selectEtihadDocument(context),
                  filePath: controller.etihadBureauDocument.filePath ?? "",
                  isPdf:
                      controller.etihadBureauDocument.fileName?.endsWith(
                        'pdf',
                      ) ??
                      false,
                ),
              ],
            ),
          ),

          CustomButton(
            onPressed: () {
              final missingDocuments = <String>[
                if (controller.passportDocument.filePath?.isNotEmpty !=
                    true)
                  "Passport",
                if (controller.emiratesIdDocument.filePath?.isNotEmpty !=
                    true)
                  "Emirates ID",
                if (controller
                        .salaryCertificateDocument
                        .filePath
                        ?.isNotEmpty !=
                    true)
                  "Valid Salary Certificate",
                if (controller
                        .bankStatementDocument
                        .filePath
                        ?.isNotEmpty !=
                    true)
                  "Last 6 months Bank statement",
                if (controller
                        .etihadBureauDocument
                        .filePath
                        ?.isNotEmpty !=
                    true)
                  "Credit Bureau Report",
              ];

              if (missingDocuments.isNotEmpty) {
                appTools.showErrorSnackBar(
                  "Please upload the following documents: ${missingDocuments.join(', ')}",
                );
                return;
              }

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
