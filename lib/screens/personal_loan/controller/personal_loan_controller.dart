import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart' as mp;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/services/model/document_model.dart';
import 'package:jovera_finance/screens/personal_loan/provider/personal_loan_provider.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_tools.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';
import 'package:jovera_finance/widgets/document_picker_widget.dart';

class PersonalLoanState {
  const PersonalLoanState({
    required this.appLoadingController,
    required this.personalNameController,
    required this.personalPhoneNumberController,
    required this.personalEmailController,
    required this.passportDocument,
    required this.emiratesIdDocument,
    required this.salaryCertificateDocument,
    required this.bankStatementDocument,
    required this.etihadBureauDocument,
    this.applicantType = "Employee",
    this.mobileCountryCode = "+971",
    this.loanAmount = 80000.0,
    this.interestRate = 4.5,
    this.paymentPeriod = 15,
    this.paymentMaxPeriod = 60,
    this.calculatorType = "UAE National",
    this.nationalityType = 'UAE National',
    this.propertyType = 'Villa',
    this.propertyLocation = 'Abu Dhabi',
    this.propertyCondition = 'New',
    this.emirates = const [
      "Abu Dhabi",
      "Dubai",
      "Sharjah",
      "Ajman",
      "Umm Al Quwain",
      "Ras Al Khaimah",
      "Fujairah",
    ],
    this.nationalities = const ["UAE National", "Expat"],
    this.conditions = const ["New", "Old", "Off Plan"],
    this.properties = const ["Villa", "Apartment", "Townhouse", "Land"],
  });

  final String applicantType;
  final String mobileCountryCode;
  final double loanAmount;
  final double interestRate;
  final int paymentPeriod;
  final int paymentMaxPeriod;
  final String calculatorType;
  final AppLoadingController appLoadingController;
  final TextEditingController personalNameController;
  final TextEditingController personalPhoneNumberController;
  final TextEditingController personalEmailController;
  final DocumentModel passportDocument;
  final DocumentModel emiratesIdDocument;
  final DocumentModel salaryCertificateDocument;
  final DocumentModel bankStatementDocument;
  final DocumentModel etihadBureauDocument;
  final String nationalityType;
  final String propertyType;
  final String propertyLocation;
  final String propertyCondition;
  final List emirates;
  final List nationalities;
  final List conditions;
  final List properties;

  PersonalLoanState copyWith({
    String? applicantType,
    String? mobileCountryCode,
    double? loanAmount,
    double? interestRate,
    int? paymentPeriod,
    int? paymentMaxPeriod,
    String? calculatorType,
    DocumentModel? passportDocument,
    DocumentModel? emiratesIdDocument,
    DocumentModel? salaryCertificateDocument,
    DocumentModel? bankStatementDocument,
    DocumentModel? etihadBureauDocument,
    String? nationalityType,
    String? propertyType,
    String? propertyLocation,
    String? propertyCondition,
    List? emirates,
    List? nationalities,
    List? conditions,
    List? properties,
  }) {
    return PersonalLoanState(
      appLoadingController: appLoadingController,
      personalNameController: personalNameController,
      personalPhoneNumberController: personalPhoneNumberController,
      personalEmailController: personalEmailController,
      passportDocument: passportDocument ?? this.passportDocument,
      emiratesIdDocument: emiratesIdDocument ?? this.emiratesIdDocument,
      salaryCertificateDocument:
          salaryCertificateDocument ?? this.salaryCertificateDocument,
      bankStatementDocument:
          bankStatementDocument ?? this.bankStatementDocument,
      etihadBureauDocument:
          etihadBureauDocument ?? this.etihadBureauDocument,
      applicantType: applicantType ?? this.applicantType,
      mobileCountryCode: mobileCountryCode ?? this.mobileCountryCode,
      loanAmount: loanAmount ?? this.loanAmount,
      interestRate: interestRate ?? this.interestRate,
      paymentPeriod: paymentPeriod ?? this.paymentPeriod,
      paymentMaxPeriod: paymentMaxPeriod ?? this.paymentMaxPeriod,
      calculatorType: calculatorType ?? this.calculatorType,
      nationalityType: nationalityType ?? this.nationalityType,
      propertyType: propertyType ?? this.propertyType,
      propertyLocation: propertyLocation ?? this.propertyLocation,
      propertyCondition: propertyCondition ?? this.propertyCondition,
      emirates: emirates ?? this.emirates,
      nationalities: nationalities ?? this.nationalities,
      conditions: conditions ?? this.conditions,
      properties: properties ?? this.properties,
    );
  }
}

class PersonalLoanController extends StateNotifier<PersonalLoanState> {
  PersonalLoanController(this.ref)
    : super(
        PersonalLoanState(
          appLoadingController: AppLoadingController(),
          personalNameController: TextEditingController(),
          personalPhoneNumberController: TextEditingController(),
          personalEmailController: TextEditingController(),
          passportDocument: DocumentModel(),
          emiratesIdDocument: DocumentModel(),
          salaryCertificateDocument: DocumentModel(),
          bankStatementDocument: DocumentModel(),
          etihadBureauDocument: DocumentModel(),
        ),
      ) {
    calculateEMI();
  }

  final Ref ref;
  String get applicantType => state.applicantType;
  set applicantType(String value) => state = state.copyWith(applicantType: value);
  String get mobileCountryCode => state.mobileCountryCode;
  set mobileCountryCode(String value) =>
      state = state.copyWith(mobileCountryCode: value);
  double get loanAmount => state.loanAmount;
  set loanAmount(double value) => state = state.copyWith(loanAmount: value);
  double get interestRate => state.interestRate;
  set interestRate(double value) => state = state.copyWith(interestRate: value);
  int get paymentPeriod => state.paymentPeriod;
  set paymentPeriod(int value) => state = state.copyWith(paymentPeriod: value);
  int get paymentMaxPeriod => state.paymentMaxPeriod;
  set paymentMaxPeriod(int value) =>
      state = state.copyWith(paymentMaxPeriod: value);

  String get calculatorType => state.calculatorType;
  set calculatorType(String value) =>
      state = state.copyWith(calculatorType: value);
  AppLoadingController get appLoadingController => state.appLoadingController;
  TextEditingController get personalNameController =>
      state.personalNameController;
  TextEditingController get personalPhoneNumberController =>
      state.personalPhoneNumberController;
  TextEditingController get personalEmailController =>
      state.personalEmailController;

  DocumentModel get passportDocument => state.passportDocument;
  set passportDocument(DocumentModel value) =>
      state = state.copyWith(passportDocument: value);
  DocumentModel get emiratesIdDocument => state.emiratesIdDocument;
  set emiratesIdDocument(DocumentModel value) =>
      state = state.copyWith(emiratesIdDocument: value);
  DocumentModel get salaryCertificateDocument =>
      state.salaryCertificateDocument;
  set salaryCertificateDocument(DocumentModel value) =>
      state = state.copyWith(salaryCertificateDocument: value);
  DocumentModel get bankStatementDocument => state.bankStatementDocument;
  set bankStatementDocument(DocumentModel value) =>
      state = state.copyWith(bankStatementDocument: value);
  DocumentModel get etihadBureauDocument => state.etihadBureauDocument;
  set etihadBureauDocument(DocumentModel value) =>
      state = state.copyWith(etihadBureauDocument: value);

  String get nationalityType => state.nationalityType;
  set nationalityType(String value) =>
      state = state.copyWith(nationalityType: value);
  String get propertyType => state.propertyType;
  set propertyType(String value) =>
      state = state.copyWith(propertyType: value);
  String get propertyLocation => state.propertyLocation;
  set propertyLocation(String value) =>
      state = state.copyWith(propertyLocation: value);
  String get propertyCondition => state.propertyCondition;
  set propertyCondition(String value) =>
      state = state.copyWith(propertyCondition: value);
  List get emirates => state.emirates;
  List get nationalities => state.nationalities;
  List get conditions => state.conditions;
  List get properties => state.properties;

  Future<void> applyPersonalLoan() async {
    Map<String, dynamic> resultMap = await getPersonalLoanData();
    appLoadingController.loading();
    PersonalLoanProvider().applyPersonalLoan(
      data: mp.FormData.fromMap(resultMap),

      onSuccess: (response) async {
        if (kDebugMode) {
          print(response);
        }
        appLoadingController.stop();
        appTools.showSuccessSnackBar(
          "Your application is successfully submitted. We will get back to you after a short review.",
        );
        goToLoginScreen(ref.read);
        await updateData(ref.read);
      },
      onError: (error) {
        appLoadingController.stop();
        if (kDebugMode) {
          print(error.response);
        }
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              'Opps, an error occurred, Please try again later',
          timer: 0,
        );
      },
    );
  }

  Future<Map<String, dynamic>> getPersonalLoanData() async {
    Map<String, dynamic> personalLoanData = {};

    personalLoanData["client"] = ref.read(authManagerProvider).appUser?.id;

    personalLoanData["product"] = "Personal Loan";

    personalLoanData["description"] =
        "Loan Amount: $loanAmount, Payment Period: $paymentPeriod Months, Name: ${personalNameController.text}, Nationality: $nationalityType, Phone: ${mobileCountryCode.startsWith("+") ? "" : "+"}$mobileCountryCode${personalPhoneNumberController.text}, Email: ${personalEmailController.text}}";

    List<DocumentModel> documents = [
      passportDocument,
      emiratesIdDocument,
      salaryCertificateDocument,
      bankStatementDocument,
      etihadBureauDocument,
    ];

    List<mp.MultipartFile> fileList = [];

    for (var doc in documents) {
      if (doc.filePath != null && doc.filePath!.isNotEmpty) {
        String ext = doc.filePath!.split('.').last.toLowerCase();

        fileList.add(
          await mp.MultipartFile.fromFile(
            doc.filePath!,
            contentType: MediaType(
              ext == 'pdf' ? 'application' : 'image',
              ext == 'jpg' ? 'jpeg' : ext,
            ),
            filename: doc.fileName ?? doc.filePath!.split('/').last,
          ),
        );
      }
    }
    personalLoanData["files"] = fileList;
    if (kDebugMode) {
      print(personalLoanData);
    }
    return personalLoanData;
  }

  double calculateEMI() {
    double monthlyRate = interestRate / 100;
    int totalMonths = paymentPeriod;

    if (monthlyRate == 0) {
      return loanAmount / totalMonths;
    }

    double emi =
        loanAmount *
        monthlyRate *
        (pow(1 + monthlyRate, totalMonths)) /
        (pow(1 + monthlyRate, totalMonths) - 1);

    return emi;
  }

  selectPassportDocument(context) {
    FilePickerResult? photoCopy;
    DocumentPicker().documentPickerWidget(
      context,
      () async {
        photoCopy = await pickfromGallery();
        passportDocument.filePath = getDocument(photoCopy);
        initPassportDocument();
      },
      () async {
        photoCopy = await pickPdf();
        passportDocument.filePath = getDocument(photoCopy);
        initPassportDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        passportDocument.filePath = getImage(image);
        initPassportDocument();
      },
    );
  }

  selectEmiratesIdDocument(context) {
    FilePickerResult? photoCopy;
    DocumentPicker().documentPickerWidget(
      context,
      () async {
        photoCopy = await pickfromGallery();
        emiratesIdDocument.filePath = getDocument(photoCopy);
        initEmiratesIdDocument();
      },
      () async {
        photoCopy = await pickPdf();
        emiratesIdDocument.filePath = getDocument(photoCopy);
        initEmiratesIdDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        emiratesIdDocument.filePath = getImage(image);
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
        salaryCertificateDocument.filePath = getDocument(photoCopy);
        initSalaryDocument();
      },
      () async {
        photoCopy = await pickPdf();
        salaryCertificateDocument.filePath = getDocument(photoCopy);
        initSalaryDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        salaryCertificateDocument.filePath = getImage(image);
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
        bankStatementDocument.filePath = getDocument(photoCopy);
        initBankStatementDocument();
      },
      () async {
        photoCopy = await pickPdf();
        bankStatementDocument.filePath = getDocument(photoCopy);
        initBankStatementDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        bankStatementDocument.filePath = getImage(image);
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
        etihadBureauDocument.filePath = getDocument(photoCopy);
        initEtihadDocument();
      },
      () async {
        photoCopy = await pickPdf();
        etihadBureauDocument.filePath = getDocument(photoCopy);
        initEtihadDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        etihadBureauDocument.filePath = getImage(image);
        initEtihadDocument();
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
    AppNavigator.pop();
    return await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
  }

  pickfromGallery() async {
    AppNavigator.pop();
    return await FilePicker.platform.pickFiles(type: FileType.image);
  }

  pickfromCamera() async {
    AppNavigator.pop();
    return ImagePicker().pickImage(source: ImageSource.camera);
  }

  initPassportDocument() {
    if (passportDocument.fileName != "") {
      passportDocument.fileName =
          "passport.${passportDocument.filePath?.split('.').last}";
    }
    state = state.copyWith(passportDocument: passportDocument);
  }

  initEmiratesIdDocument() {
    if (emiratesIdDocument.fileName != "") {
      emiratesIdDocument.fileName =
          "emiratesId.${emiratesIdDocument.filePath?.split('.').last}";
    }
    state = state.copyWith(emiratesIdDocument: emiratesIdDocument);
  }

  initSalaryDocument() {
    if (salaryCertificateDocument.fileName != "") {
      salaryCertificateDocument.fileName =
          "salary_certificate.${salaryCertificateDocument.filePath?.split('.').last}";
    }
    state = state.copyWith(salaryCertificateDocument: salaryCertificateDocument);
  }

  initBankStatementDocument() {
    if (bankStatementDocument.fileName != "") {
      bankStatementDocument.fileName =
          "bank_statement.${bankStatementDocument.filePath?.split('.').last}";
    }
    state = state.copyWith(bankStatementDocument: bankStatementDocument);
  }

  initEtihadDocument() {
    if (etihadBureauDocument.fileName != "") {
      etihadBureauDocument.fileName =
          "etihad_bureau.${etihadBureauDocument.filePath?.split('.').last}";
    }
    state = state.copyWith(etihadBureauDocument: etihadBureauDocument);
  }

  @override
  void dispose() {
    personalNameController.dispose();
    personalPhoneNumberController.dispose();
    personalEmailController.dispose();
    appLoadingController.dispose();
    super.dispose();
  }
}

final personalLoanControllerProvider =
    StateNotifierProvider<PersonalLoanController, PersonalLoanState>((ref) {
  return PersonalLoanController(ref);
});
