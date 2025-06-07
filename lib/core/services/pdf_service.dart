import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PdfService {
  Future<File> downloadPDF(String url) async {
    final fileName = url.split('/').last;
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/$fileName';

    final file = File(filePath);
    if (await file.exists()) return file;

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } else {
      throw Exception('erro ao baixar PDF');
    }
  }
}
