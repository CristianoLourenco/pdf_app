import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfHomeView extends StatefulWidget {
  const PdfHomeView({super.key});

  @override
  State<PdfHomeView> createState() => _PdfHomeViewState();
}

class _PdfHomeViewState extends State<PdfHomeView> {
  File? _pdfFile;

  Future<void> _pickPDF() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Leitor de PDF")),
      body:
          _pdfFile == null
              ? const Center(child: Text("Selecione um arquivo pdf"))
              : PDFView(
                backgroundColor: Colors.deepOrange,
                filePath: _pdfFile!.path,
              ),

      floatingActionButton: FloatingActionButton(
        onPressed: _pickPDF,
        child: Icon(Icons.upload_file),
      ),
    );
  }
}
