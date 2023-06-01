import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:printing/printing.dart';
import '../util/util.dart';
import 'loadding_widget.dart';

typedef FileDocument = PlatformFile;

class DocumentsPickerViewer extends StatelessWidget {
  void Function(List<FileDocument> value)? onChange;
  bool multplesFile;
  List<String> urls;
  List<FileDocument>? currentValues;

  late Future<List<FileDocument>> _listDocsFuture;

  DocumentsPickerViewer({
    required this.onChange,
    required this.urls,
    this.multplesFile = true,
  }) {
    _listDocsFuture = getCurrntDocs();
  }

  @override
  Widget build(BuildContext context) {
    return LoaddingWidget.future(
        future: _listDocsFuture,
        builder: (data) => DocumentsPicker(
              initialValues: currentValues ?? data!,
              onChange: onChange == null
                  ? null
                  : (values) {
                      currentValues = values;
                      onChange!(values);
                    },
              multplesFile: multplesFile,
            ));
  }

  Future<List<FileDocument>> getCurrntDocs() async {
    if (urls.isEmpty) return [];
    var result = <FileDocument>[];
    for (var url in urls) {
      var content = await loadContentDoc(url);
      if (content.isNotEmpty)
        result.add(FileDocument(
          name: url,
          path: url,
          bytes: content,
          size: content.length,
        ));
    }
    return result;
  }

  Future<Uint8List> loadContentDoc(String url) async {
    if (url.isEmpty) return Uint8List.fromList([]);
    var response = await get(Uri.parse(url));
    return response.bodyBytes;
  }
}

class DocumentsPicker extends StatelessWidget {
  RxList<FileDocument> listDocs;
  void Function(List<FileDocument> value)? onChange;
  bool multplesFile;

  DocumentsPicker({
    required this.onChange,
    List<FileDocument>? initialValues,
    this.multplesFile = true,
  }) : listDocs = initialValues?.obs ?? <FileDocument>[].obs {
    if (onChange != null) listDocs.listen(onChange!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: Get.width - kPadding * 2,
        decoration: onChange == null
            ? null
            : BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Get.theme.cardColor,
              ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Obx(
            () => listDocs.isEmpty
                ? buildEmptyList()
                : Wrap(children: [
                    for (var doc in listDocs)
                      Card(
                        child: Stack(children: [
                          if (doc.extension == 'pdf')
                            AspectRatio(
                                aspectRatio: 21 / 29,
                                child: PdfPreview(
                                  padding: EdgeInsets.zero,
                                  useActions: false,
                                  build: (format) => doc.bytes!,
                                )),
                          if (doc.extension != 'pdf')
                            Image.memory(
                              doc.bytes!,
                              width: 125,
                            ),
                          if (onChange != null)
                            Positioned(
                              top: 0,
                              left: 0,
                              child: IconButton(
                                  onPressed: () => removeDoc(doc),
                                  icon: Icon(Icons.close,
                                      color: Get.theme.primaryColor)),
                            )
                        ]),
                      )
                  ]),
          ),
          if (onChange != null)
            Padding(
              padding: EdgeInsets.all(kPaddingInternal),
              child: ElevatedButton(
                  child: Text('Add document'.tr), onPressed: addDocument),
            )
        ]));
  }

  Future<void> addDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        withData: true,
        allowMultiple: multplesFile);
    if (result == null) return;
    if (multplesFile != true) listDocs.clear();
    listDocs.addAll(result.files);
  }

  removeDoc(FileDocument doc) {
    listDocs.remove(doc);
  }

  Widget buildPdfIcon(FileDocument doc) {
    return SizedBox(
        height: 150,
        width: 150,
        child: GridTile(
          child: Icon(
            Icons.picture_as_pdf_outlined,
            size: 125,
          ),
          footer: Container(
            padding: EdgeInsets.symmetric(horizontal: kPaddingInternal),
            color: Get.theme.primaryColor,
            child: Text(doc.name, style: TextStyle(color: Colors.white)),
          ),
        ));
  }

  Widget buildEmptyList() {
    if (onChange == null) return Container();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: kPadding),
        Icon(
          Icons.file_open_outlined,
          size: 36,
        ),
        Text(
          'Upload your files in JPG, PNG or PDF format'.tr,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
