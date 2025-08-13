import 'dart:typed_data';

class DocumentModel {
  int? id;
  Uint8List? fileData;
  String? fileType;
  String? filePath;
  String? fileName;
  DocumentModel({
    this.fileData,
    this.fileType,
    this.id,
    this.filePath,
    this.fileName,
  });
}
