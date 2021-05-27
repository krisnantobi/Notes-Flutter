// Class QuoteModel digunakan untuk normalize atau membuat schema data yang dikirim dari response API
class QuoteModel {
  final String content;

  QuoteModel({this.content});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(content: json['content']);
  }
}
