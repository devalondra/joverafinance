import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart' as mp;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/model/chat_model.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/provider/chat_provider.dart';
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
  Rx<TextEditingController> textController = TextEditingController().obs;
  RxBool socketInitialized = false.obs;
  Uint8List? fileBytes;
  ScrollController scrollController = ScrollController();
  RxString selectedFilePath = ''.obs;
  RxString uploadedFileUrl = ''.obs;
  final userId = Get.find<AuthManager>().appUser.value.id;
  AppLoadingController appLoadingController = AppLoadingController();
  @override
  void onInit() async {
    await getAllMessages();
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

  void setupListeners() {
    notificationService.socket.off('chat:message');
    notificationService.socket.on('chat:message', (data) {
      print(data);
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
    appLoadingController.loading();
    ChatProvider().getAllMessages(
      onSuccess: (response) async {
        appLoadingController.stop();
        print(response);
        if (response.data != null) {
          messages.value = RxList<ChatModel>.from(
            json
                .decode(json.encode(response.data['messages']))
                .map((x) => ChatModel.fromJson(x)),
          );
          messages.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
          messages.refresh();
          scrollToBottom();
          for (ChatModel e in messages) {
            print(e.fileUrl);
          }
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

  // Future<Map<String, dynamic>> getProfileFormData() async {
  //   Map<String, dynamic> profileFormData = {};

  //   if (textController.value.text.isNotEmpty) {
  //     profileFormData["text"] = textController.value.text;
  //   }

  //   if (selectedFilePath.isNotEmpty && fileBytes != null) {
  //     profileFormData["path"] = selectedFilePath.value;

  //     profileFormData["fileUrl"] = fileBytes;
  //   }

  //   return profileFormData;
  // }

  Future<void> sendFile() async {
    Map<String, dynamic> resultMap = await getMessageFile();
    if (resultMap.isEmpty) return;

    ChatProvider().sendFile(
      data: mp.FormData.fromMap(resultMap),

      onSuccess: (response) async {
        appLoadingController.stop();
        selectedFilePath.value = "";
        print(response);
        uploadedFileUrl.value = response.data['fileUrl'] ?? "";
        print(uploadedFileUrl.value);
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
    // Map<String, dynamic> resultMap = await getProfileFormData();
    // if (resultMap.isEmpty) return;

    if (uploadedFileUrl.value != "") {
      final messagePayload = {
        "clientId": userId,
        "leadId": messages.last.leadId ?? "",
        "text": textController.value.text,

        "fileUrl": uploadedFileUrl.value,
      };
      socket.emit("chat:message", messagePayload);
      print(messagePayload);
      textController.value.clear();
      selectedFilePath.value = "";
      uploadedFileUrl.value = "";
    } else {
      final messagePayload = {
        "clientId": userId,
        "leadId": messages.last.leadId ?? "",
        "text": textController.value.text,
      };

      socket.emit("chat:message", messagePayload);
      textController.value.clear();
      selectedFilePath.value = "";
      uploadedFileUrl.value = "";
    }

    // locally add to messages so UI updates instantly
    // final newMessage = ChatModel(
    //   recipient: userId,
    //   leadId: messages.last.leadId ?? "",
    //   text: resultMap["text"] ?? "",
    //   recipientModel: "User",
    //   fileUrl: resultMap["path"] ?? "",
    //   timestamp: DateTime.now().toIso8601String(),

    //   status: "sending",
    // );

    // messages.add(newMessage);
    // messages.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
    // messages.refresh();
    // scrollToBottom();
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

  @override
  void onReady() {
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
