class VisaApplicationModel {
  String? id;
  String? submittedAt;
  String? status;
  String? salesPerson;
  String? typeOfLoan;
  String? orderNumber;
  bool? isRejected;
  String? description;

  VisaApplicationModel({
    this.id,
    this.orderNumber,

    this.status,
    this.submittedAt,
    this.salesPerson,
    this.typeOfLoan,
    this.description,
  });
  VisaApplicationModel.fromJson(Map<String, dynamic> json) {
    id = json['leadId'];
    orderNumber = json['orderNumber'];
    isRejected = json['reject'];

    status = json['status'];
    salesPerson = json['salesPerson'];
    typeOfLoan = json['type_of_loan'];
    submittedAt = json['submissionDate'];
    description = json['description'];
  }
}
