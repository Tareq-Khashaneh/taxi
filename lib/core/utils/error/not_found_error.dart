import 'package:xml/xml.dart';

class NotFoundErrorResponse {
  final String message;

  NotFoundErrorResponse({required this.message});

  factory NotFoundErrorResponse.fromXml(String htmlString) {
    final document = XmlDocument.parse(htmlString);
    final body = document.findAllElements('body').first.innerText.trim();
    return NotFoundErrorResponse(message: body);
  }
}
