class ChatModel {
  String? id;
  String? leadId;
  String? recipient;
  String? recipientModel;
  String? text;
  String? timestamp;
  String? status;
  String? fileUrl;
  String? senderName;
  String? senderImage;
  String? senderId;

  List? files;
  ChatModel({
    this.recipient,
    this.leadId,
    this.id,
    this.recipientModel,
    this.text,
    this.timestamp,
    this.files,
    this.fileUrl,
    this.status,
    this.senderName,
    this.senderImage,
    this.senderId,
  });
  ChatModel.fromJson(json) {
    leadId = json["leadId"] ?? "";
    recipient = json["recipient"] ?? "";
    recipientModel = json["recipientModel"] ?? "";
    text = json["text"] ?? "";
    timestamp = json["timestamp"] ?? "";
    id = json["_id"] ?? "";
    status = json["status"] ?? "";
    senderId = json["senderId"] ?? "";
    senderImage = json["senderImage"] ?? "";
    senderName = json["senderName"] ?? "";
    files = json["files"] ?? [];
    fileUrl = json["fileUrl"] ?? "";
  }
}
