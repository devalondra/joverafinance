import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/mortgage/controller/mortgage_controller.dart';
import 'package:jovera_finance/screens/mortgage/mortgage_apply/view/propert_details_view.dart';
import 'package:jovera_finance/screens/mortgage/mortgage_apply/widget/upload_document_widget.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class MortgageCompanyDocumentsView extends GetView<MortgageController> {
  const MortgageCompanyDocumentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          SizedBox(height: verticalPagePadding),
          Obx(
            () => Expanded(
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
                    fileName: MainText(
                      text: controller.passportDocument.value.fileName ?? "",
                      fontSize: 12.sp,
                    ).paddingSymmetric(horizontal: fullWidth * 0.01),
                    visibility:
                        controller
                            .passportDocument
                            .value
                            .fileName
                            ?.isNotEmpty ??
                        false,
                  ),
                  UploadDocumentWidget(
                    onTap: () => controller.selectEmiratesIdDocument(context),
                    text: "Emirates ID",
                    fileName: MainText(
                      text: controller.emiratesIdDocument.value.fileName ?? "",
                      fontSize: 12.sp,
                    ).paddingSymmetric(horizontal: fullWidth * 0.01),
                    visibility:
                        controller
                            .emiratesIdDocument
                            .value
                            .fileName
                            ?.isNotEmpty ??
                        false,
                  ),
                  UploadDocumentWidget(
                    onTap: () => controller.selectTradeLicenseDocument(context),
                    text: "Trade License",
                    fileName: MainText(
                      text:
                          controller.tradeLicenseDocument.value.fileName ?? "",
                      fontSize: 12.sp,
                    ).paddingSymmetric(horizontal: fullWidth * 0.01),
                    visibility:
                        controller
                            .tradeLicenseDocument
                            .value
                            .fileName
                            ?.isNotEmpty ??
                        false,
                  ),
                  UploadDocumentWidget(
                    onTap:
                        () =>
                            controller.selectSalaryCertificateDocument(context),
                    text: "Valid Salary Certificate",
                    fileName: MainText(
                      text:
                          controller.salaryCertificateDocument.value.fileName ??
                          "",
                      fontSize: 12.sp,
                    ).paddingSymmetric(horizontal: fullWidth * 0.01),
                    visibility:
                        controller
                            .salaryCertificateDocument
                            .value
                            .fileName
                            ?.isNotEmpty ??
                        false,
                  ),
                  UploadDocumentWidget(
                    text: "Last 12 months Bank statement",
                    onTap:
                        () => controller.selectBankStatementDocument(context),
                    fileName: MainText(
                      text:
                          controller.bankStatementDocument.value.fileName ?? "",
                      fontSize: 12.sp,
                    ).paddingSymmetric(horizontal: fullWidth * 0.01),
                    visibility:
                        controller
                            .bankStatementDocument
                            .value
                            .fileName
                            ?.isNotEmpty ??
                        false,
                  ),
                  UploadDocumentWidget(
                    text: "Etihad Bureau + Company",
                    onTap: () => controller.selectEtihadDocument(context),
                    fileName: MainText(
                      text:
                          controller.etihadBureauDocument.value.fileName ?? "",
                      fontSize: 12.sp,
                    ).paddingSymmetric(horizontal: fullWidth * 0.01),
                    visibility:
                        controller
                            .etihadBureauDocument
                            .value
                            .fileName
                            ?.isNotEmpty ??
                        false,
                  ),
                  UploadDocumentWidget(
                    text: "Last 4 VAT Payments",
                    onTap: () => controller.selectVATDocument(context),
                    fileName: MainText(
                      text:
                          controller.fourVATPaymentsDocument.value.fileName ??
                          "",
                      fontSize: 12.sp,
                    ).paddingSymmetric(horizontal: fullWidth * 0.01),
                    visibility:
                        controller
                            .fourVATPaymentsDocument
                            .value
                            .fileName
                            ?.isNotEmpty ??
                        false,
                  ),
                ],
              ),
            ),
          ),

          CustomButton(
            onPressed: () {
              Get.to(() => PropertDetailsView());
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
