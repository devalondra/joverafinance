import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as mp;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/model/chat_model.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/model/my_lead.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/provider/chat_provider.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/model/visa_application_model.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/provider/dashboard_provider.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/services/notification_service.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';
import 'package:jovera_finance/widgets/document_picker_widget.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';

class ChatController extends GetxController {
  late Socket socket;
  RxList<ChatModel> messages = <ChatModel>[].obs;
  NotificationService notificationService = Get.find();
  final AuthManager authManager = Get.find();
  Rx<TextEditingController> textController = TextEditingController().obs;
  RxBool socketInitialized = false.obs;
  Uint8List? fileBytes;

  RxList<MyLead> leads = <MyLead>[].obs;
  Rx<MyLead?> selectedLead = Rx<MyLead?>(null);

  ScrollController scrollController = ScrollController();
  RxString selectedFilePath = ''.obs;
  RxString uploadedFileUrl = ''.obs;
  String? get userId => authManager.appUser.value.id;
  AppLoadingController appLoadingController = AppLoadingController();
  @override
  void onInit() async {
    await getAllMessages();
    await getLeads();
    if (notificationService.isSocketInitialized) {
      socketInitialized.value = notificationService.isSocketInitialized;

      debugPrint("££££££££ socket connected");
      socket = notificationService.socketInstance;
      setupListeners();
      debugPrint('✅ ChatController using existing socket');
    } else {
      debugPrint('❌ Socket not initialized yet');
    }

    super.onInit();
  }

  @override
  void onReady() async {
    await getLeads();
    if (notificationService.isSocketInitialized) {
      socketInitialized.value = notificationService.isSocketInitialized;
      debugPrint("££££££££ socket connected");
      socket = notificationService.socketInstance;
      setupListeners();
      debugPrint('✅ ChatController using existing socket');
    } else {
      debugPrint('❌ Socket not initialized yet');
    }

    super.onReady();
  }

  ChatModel? get sender =>
      messages.where((e) => e.recipientModel == "Client").lastOrNull;

  Future<void> getMyApplications() async {
    if (!authManager.isLogged.value) {
      return;
    }
    appLoadingController.loading();
    DashboardProvider().getMyVisaApplications(
      onSuccess: (response) {
        appLoadingController.stop();
        if (kDebugMode) print(response);
        if (response.data != null && response.data['leads'].length != 0) {
          final leadsApplications = RxList<VisaApplicationModel>.from(
            json
                .decode(json.encode(response.data['leads']))
                .map((x) => VisaApplicationModel.fromJson(x)),
          );
          leads.value =
              leadsApplications
                  .map(
                    (element) => MyLead(
                      leadId: element.id ?? "",
                      leadType: element.typeOfLoan ?? "",
                    ),
                  )
                  .toList();
          if (kDebugMode) print(leadsApplications);
          leads.refresh();
          if (leads.isNotEmpty) {
            selectedLead.value = leads.first;
          }
          if (kDebugMode) print(leads);
        }
      },
      onError: (error) {
        appLoadingController.stop();
        if (kDebugMode) print(error.message);
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              'Opps, an error occurred, Please try again later',
          timer: 1,
        );
      },
    );
  }

  bool get hasSenderImage => (sender?.senderImage ?? "").startsWith("https");

  String _resolveLeadId() {
    final String selectedLeadId = selectedLead.value?.leadId ?? "";
    if (selectedLeadId.isNotEmpty) {
      return selectedLeadId;
    }
    if (messages.isNotEmpty) {
      final String lastMessageLeadId = messages.last.leadId ?? "";
      if (lastMessageLeadId.isNotEmpty) {
        return lastMessageLeadId;
      }
    }
    if (leads.isNotEmpty) {
      return leads.first.leadId ?? "";
    }
    return "";
  }

  getLeads() async {
    await getMyApplications();
  }

  void setupListeners() {
    notificationService.socket.off('chat:message');
    notificationService.socket.on('chat:message', (data) {
      if (Get.find<BottomNavigationBarController>().selectedIndex.value == 3) {
        ChatModel messageModel = ChatModel(
          leadId: data["leadId"] ?? "",
          recipient: data["recipient"] ?? "",
          senderId: data["senderId"] ?? "",
          senderImage: data["senderImage"] ?? "",
          senderName: data["senderName"] ?? "",
          recipientModel: data["recipientModel"] ?? "",
          text: data["text"] ?? "",
          timestamp: data["timestamp"] ?? "",
          id: data["_id"] ?? "",
          status: data["status"] ?? "",
          files: data["files"] ?? "",
          fileUrl: data["fileUrl"] ?? "",
        );

        messages.add(messageModel);
        messages.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
        messages.refresh();
        scrollToBottom();
      } else {
        Get.snackbar(
          "Message",
          data["text"],
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
          backgroundColor: AppColors.black2,
          colorText: Colors.white,
          mainButton: TextButton(
            onPressed: () {
              Get.find<BottomNavigationBarController>().selectedIndex.value = 3;
              ChatModel messageModel = ChatModel(
                leadId: data["leadId"] ?? "",
                recipient: data["recipient"] ?? "",
                senderId: data["senderId"] ?? "",
                senderImage: data["senderImage"] ?? "",
                senderName: data["senderName"] ?? "",
                recipientModel: data["recipientModel"] ?? "",
                text: data["text"] ?? "",
                timestamp: data["timestamp"] ?? "",
                id: data["_id"] ?? "",
                status: data["status"] ?? "",
                files: data["files"] ?? "",
                fileUrl: data["fileUrl"] ?? "",
              );

              messages.add(messageModel);
              messages.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
              messages.refresh();
              scrollToBottom();
            },
            child: Text("View", style: TextStyle(color: Colors.white)),
          ),
        );
      }
    });
  }

  Future<void> getAllMessages() async {
    if (!authManager.isLogged.value) {
      return;
    }

    appLoadingController.loading();
    ChatProvider().getAllMessages(
      onSuccess: (response) async {
        appLoadingController.stop();
        if (kDebugMode) print(response);
        if (response.data != null && response.data['messages'].length != 0) {
          messages.value = RxList<ChatModel>.from(
            json
                .decode(json.encode(response.data['messages']))
                .map((x) => ChatModel.fromJson(x)),
          );
          messages.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
          messages.refresh();
          scrollToBottom();
        }
      },
      onError: (error) {
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              "Something went wrong while loading old messages",
        );
      },
    );
  }

  selectFile(context) {
    FilePickerResult? doc;
    DocumentPicker().documentPickerWidget(
      context,

      () async {
        Get.back();
        doc = await FilePicker.platform.pickFiles(type: FileType.image);

        if (doc != null) {
          File file = File(doc!.files.single.path!);
          selectedFilePath.value = file.path;
          fileBytes = await file.readAsBytes();
        } else {}
      },

      () async {
        Get.back();
        doc = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );

        if (doc != null) {
          File file = File(doc!.files.single.path!);
          debugPrint("*****************************************");
          selectedFilePath.value = file.path;
          fileBytes = await file.readAsBytes();
        } else {}
      },
      () async {
        Get.back();

        final XFile? image = await ImagePicker().pickImage(
          source: ImageSource.camera,
        );

        if (image != null) {
          File file = File(image.path);
          selectedFilePath.value = file.path;
          fileBytes = await file.readAsBytes();
        } else {}
      },
    );
  }

  Future<Map<String, dynamic>> getMessageFile() async {
    Map<String, dynamic> fileData = {};
    if (selectedFilePath.isNotEmpty) {
      String ext = selectedFilePath.value.split('.').last.toLowerCase();
      fileData["file"] = await mp.MultipartFile.fromFile(
        selectedFilePath.value,
        contentType: MediaType(
          ext == 'pdf' ? 'application' : 'image',
          ext == 'jpg' ? 'jpeg' : ext,
        ),
        filename: "file_${selectedFilePath.value.split('/').last}",
      );
    }

    return fileData;
  }

  Future<void> sendFile() async {
    Map<String, dynamic> resultMap = await getMessageFile();
    if (resultMap.isEmpty) return;

    ChatProvider().sendFile(
      data: mp.FormData.fromMap(resultMap),

      onSuccess: (response) async {
        appLoadingController.stop();
        selectedFilePath.value = "";
        if (kDebugMode) print(response);
        uploadedFileUrl.value = response.data['fileUrl'] ?? "";
        if (kDebugMode) print(uploadedFileUrl.value);
        sendMessageViaSocket();
      },
      onError: (error) {
        selectedFilePath.value = "";
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              "Something went wrong white loading old messages",
        );
      },
    );
  }

  void sendMessageViaSocket() async {
    final String leadId = _resolveLeadId();
    if (leadId.isEmpty) {
      appTools.showErrorSnackBar(
        "Unable to send message. Please select a lead.",
      );
      return;
    }
    if (uploadedFileUrl.value != "") {
      final messagePayload = {
        "clientId": userId,
        "leadId": leadId,
        "text": textController.value.text,

        "fileUrl": uploadedFileUrl.value,
      };
      socket.emit("chat:message", messagePayload);
      if (kDebugMode) print(messagePayload);
      textController.value.clear();
      selectedFilePath.value = "";
      uploadedFileUrl.value = "";
    } else {
      final messagePayload = {
        "clientId": userId,
        //todo remove mandatory leadid
        
        "leadId": leadId,
        "text": textController.value.text,
      };
      if (kDebugMode) print(messagePayload);
      socket.emit("chat:message", messagePayload);
      textController.value.clear();
      selectedFilePath.value = "";
      uploadedFileUrl.value = "";
    }
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void printSocket() {
    if (notificationService.isSocketInitialized) {
      socketInitialized.value = notificationService.isSocketInitialized;
      debugPrint("££££££££ socket connected");
      socket = notificationService.socketInstance;
      setupListeners();
      debugPrint('✅ ChatController using existing socket');
    } else {
      debugPrint('❌ Socket not initialized yet');
    }
  }
}
