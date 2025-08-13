import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jovera_finance/screens/bottom_navigation/services/model/document_model.dart';
import 'package:jovera_finance/widgets/document_picker_widget.dart';

class MortgageController extends GetxController {
  RxString applicantType = "".obs;
  RxString mobileCountryCode = "+971".obs;
  Rx<TextEditingController> personalNameController =
      TextEditingController().obs;
  Rx<TextEditingController> personalNationalityController =
      TextEditingController().obs;
  Rx<TextEditingController> personalPhoneNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> personalEmailController =
      TextEditingController().obs;

  Rx<DocumentModel> passportDocument = DocumentModel().obs;
  Rx<DocumentModel> emiratesIdDocument = DocumentModel().obs;
  Rx<DocumentModel> salaryCertificateDocument = DocumentModel().obs;
  Rx<DocumentModel> bankStatementDocument = DocumentModel().obs;
  Rx<DocumentModel> etihadBureauDocument = DocumentModel().obs;
  Rx<DocumentModel> tradeLicenseDocument = DocumentModel().obs;
  Rx<DocumentModel> fourVATPaymentsDocument = DocumentModel().obs;

  RxString propertyType = 'Villa'.obs;
  RxString propertyLocation = 'Abu Dhabi'.obs;
  RxString propertyCondition = 'New'.obs;
  List emirates = [
    "Abu Dhabi",
    "Dubai",
    "Sharjah",
    "Ajman",
    "Umm Al Quwain",
    "Ras Al Khaimah",
    "Fujairah",
  ];
  List conditions = ["New", "Old"];
  List properties = ["Villa", "Apartment", "Townhouse", "Land"];
  selectPassportDocument(context) {
    FilePickerResult? photoCopy;
    DocumentPicker().documentPickerWidget(
      context,
      () async {
        photoCopy = await pickfromGallery();
        passportDocument.value.filePath = getDocument(photoCopy);
        initPassportDocument();
      },
      () async {
        photoCopy = await pickPdf();
        passportDocument.value.filePath = getDocument(photoCopy);
        initPassportDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        passportDocument.value.filePath = getImage(image);
        initPassportDocument();
      },
    );
  }

  selectTradeLicenseDocument(context) {
    FilePickerResult? photoCopy;
    DocumentPicker().documentPickerWidget(
      context,
      () async {
        photoCopy = await pickfromGallery();
        tradeLicenseDocument.value.filePath = getDocument(photoCopy);
        initTradeLicenseDocument();
      },
      () async {
        photoCopy = await pickPdf();
        tradeLicenseDocument.value.filePath = getDocument(photoCopy);
        initTradeLicenseDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        tradeLicenseDocument.value.filePath = getImage(image);
        initTradeLicenseDocument();
      },
    );
  }

  selectEmiratesIdDocument(context) {
    FilePickerResult? photoCopy;
    DocumentPicker().documentPickerWidget(
      context,
      () async {
        photoCopy = await pickfromGallery();
        emiratesIdDocument.value.filePath = getDocument(photoCopy);
        initEmiratesIdDocument();
      },
      () async {
        photoCopy = await pickPdf();
        emiratesIdDocument.value.filePath = getDocument(photoCopy);
        initEmiratesIdDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        emiratesIdDocument.value.filePath = getImage(image);
        initEmiratesIdDocument();
      },
    );
  }

  selectSalaryCertificateDocument(context) {
    FilePickerResult? photoCopy;
    DocumentPicker().documentPickerWidget(
      context,
      () async {
        photoCopy = await pickfromGallery();
        salaryCertificateDocument.value.filePath = getDocument(photoCopy);
        initSalaryDocument();
      },
      () async {
        photoCopy = await pickPdf();
        salaryCertificateDocument.value.filePath = getDocument(photoCopy);
        initSalaryDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        salaryCertificateDocument.value.filePath = getImage(image);
        initSalaryDocument();
      },
    );
  }

  selectBankStatementDocument(context) {
    FilePickerResult? photoCopy;
    DocumentPicker().documentPickerWidget(
      context,
      () async {
        photoCopy = await pickfromGallery();
        bankStatementDocument.value.filePath = getDocument(photoCopy);
        initBankStatementDocument();
      },
      () async {
        photoCopy = await pickPdf();
        bankStatementDocument.value.filePath = getDocument(photoCopy);
        initBankStatementDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        bankStatementDocument.value.filePath = getImage(image);
        initBankStatementDocument();
      },
    );
  }

  selectEtihadDocument(context) {
    FilePickerResult? photoCopy;
    DocumentPicker().documentPickerWidget(
      context,
      () async {
        photoCopy = await pickfromGallery();
        etihadBureauDocument.value.filePath = getDocument(photoCopy);
        initEtihadDocument();
      },
      () async {
        photoCopy = await pickPdf();
        etihadBureauDocument.value.filePath = getDocument(photoCopy);
        initEtihadDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        etihadBureauDocument.value.filePath = getImage(image);
        initEtihadDocument();
      },
    );
  }

  selectVATDocument(context) {
    FilePickerResult? photoCopy;
    DocumentPicker().documentPickerWidget(
      context,
      () async {
        photoCopy = await pickfromGallery();
        fourVATPaymentsDocument.value.filePath = getDocument(photoCopy);
        initVATDocument();
      },
      () async {
        photoCopy = await pickPdf();
        fourVATPaymentsDocument.value.filePath = getDocument(photoCopy);
        initVATDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        fourVATPaymentsDocument.value.filePath = getImage(image);
        initVATDocument();
      },
    );
  }

  getDocument(photoCopy) {
    if (photoCopy != null) {
      File file = File(photoCopy!.files.single.path!);
      return file.path;
    } else {
      return "";
    }
  }

  getImage(image) {
    if (image != null) {
      File file = File(image.path);
      return file.path;
    } else {
      return "";
    }
  }

  pickPdf() async {
    Get.back();
    return await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
  }

  pickfromGallery() async {
    Get.back();
    return await FilePicker.platform.pickFiles(type: FileType.image);
  }

  pickfromCamera() async {
    Get.back();
    return ImagePicker().pickImage(source: ImageSource.camera);
  }

  initPassportDocument() {
    passportDocument.value.fileName =
        "passport.${passportDocument.value.filePath?.split('.').last}";
    passportDocument.update(passportDocument);
  }

  initEmiratesIdDocument() {
    emiratesIdDocument.value.fileName =
        "emiratesId.${emiratesIdDocument.value.filePath?.split('.').last}";
    emiratesIdDocument.update(emiratesIdDocument);
  }

  initTradeLicenseDocument() {
    tradeLicenseDocument.value.fileName =
        "trade_license.${tradeLicenseDocument.value.filePath?.split('.').last}";
    tradeLicenseDocument.update(tradeLicenseDocument);
  }

  initSalaryDocument() {
    salaryCertificateDocument.value.fileName =
        "salary_certificate.${salaryCertificateDocument.value.filePath?.split('.').last}";
    salaryCertificateDocument.update(salaryCertificateDocument);
  }

  initBankStatementDocument() {
    bankStatementDocument.value.fileName =
        "bank_statement.${bankStatementDocument.value.filePath?.split('.').last}";
    bankStatementDocument.update(bankStatementDocument);
  }

  initEtihadDocument() {
    etihadBureauDocument.value.fileName =
        "etihad_bureau.${etihadBureauDocument.value.filePath?.split('.').last}";
    etihadBureauDocument.update(etihadBureauDocument);
  }

  initVATDocument() {
    fourVATPaymentsDocument.value.fileName =
        "VAT_payments.${fourVATPaymentsDocument.value.filePath?.split('.').last}";
    fourVATPaymentsDocument.update(fourVATPaymentsDocument);
  }
}
