import 'dart:io';

import 'package:flutter/material.dart';
import 'package:management_app/models/setting.dart';
import 'package:management_app/models/user.dart';
import 'package:management_app/utils/app_methods.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfBuilder {
  final GlobalKey<SfDataGridState> gridKey;
  const PdfBuilder({required this.gridKey});

  Future<bool> build(List<User> users, Set<int> ids, Setting setting,
      [DateTime? date]) async {
    try {
      if (ids.isEmpty) {
        return false;
      }
      List<User> selectedUsers =
          users.where((user) => ids.contains(user.id)).toList();
      PdfDocument document = PdfDocument();
      PdfPage pdfPage = document.pages.add();
      PdfGrid pdfGrid = gridKey.currentState!.exportToPdfGrid(
          excludeColumns: ['id', 'select', 'action'],
          rows: selectedUsers.map((item) => item.toDataGridRow()).toList(),
          cellExport: (details) {
            details.pdfCell.style.font =
                PdfStandardFont(PdfFontFamily.helvetica, 12); // bigger text
            details.pdfCell.style.cellPadding =
                PdfPaddings(top: 5, bottom: 2, left: 5);
            if (details.cellType == DataGridExportCellType.columnHeader) {
              details.pdfCell.style.backgroundBrush = PdfBrushes.silver;
              details.pdfCell.style.textBrush = PdfBrushes.black;
            }
            if (details.cellType == DataGridExportCellType.row) {
              details.pdfCell.style.backgroundBrush = PdfBrushes.white;
            }

            if (details.cellType == DataGridExportCellType.columnHeader) {
              if (details.columnName == 'name') {
                details.pdfCell.value = 'Nom du Propriétaire';
              }
            }
            if (details.cellType == DataGridExportCellType.columnHeader) {
              if (details.columnName == 'ref') {
                details.pdfCell.value = 'Ref CFE';
              }
            }
            if (details.cellType == DataGridExportCellType.columnHeader) {
              if (details.columnName == 'title') {
                details.pdfCell.value = 'Titre Foncier';
              }
            }
            if (details.cellType == DataGridExportCellType.columnHeader) {
              if (details.columnName == 'price') {
                details.pdfCell.value = 'Montant HT';
              }
            }
          },
          autoColumnWidth: true,
          fitAllColumnsInOnePage: true);
      PdfLayoutResult? layoutResult = await pdfGrid.draw(
          page: pdfPage, bounds: Rect.fromLTWH(20, 220, 0, 0));
      final List<int> bytes = document.saveSync();
      await File(
              '${setting.factureDirectory}/Facture_${setting.factureNumber}.pdf')
          .writeAsBytes(bytes);
      double nextY = layoutResult!.bounds.bottom + 70;
      await updatePdf(nextY, totalPrice(selectedUsers), setting, date);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> updatePdf(
      double nextY, double total, Setting setting, DateTime? date) async {
    String totalPrice = (total * (100 - setting.tva) / 100).toStringAsFixed(3);
    DateTime dateT = date ?? DateTime.now();
    // Load the existing PDF document from assets
    final File filex = File(
        '${setting.factureDirectory}/Facture_${setting.factureNumber}.pdf');
    final List<int> bytes = await filex.readAsBytes();

    // Load the PDF document
    final PdfDocument document = PdfDocument(inputBytes: bytes);

    // Access the first page
    final PdfPage page = document.pages[0];

    // Create a PDF font and brush
    final PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 12);
    final PdfBrush brush = PdfSolidBrush(PdfColor(0, 0, 0));

    page.graphics.drawString(
      'Vérifications préables des TF',
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      brush: PdfBrushes.black,
      bounds: const Rect.fromLTWH(50, 230, 0, 0),
    );
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(50, 50, 250, 38), brush: PdfBrushes.silver);
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(50, 90, 250, 65), brush: PdfBrushes.whiteSmoke);
    page.graphics.drawString(
      '     Maitre ${setting.getFullName()}',
      PdfStandardFont(PdfFontFamily.helvetica, 15),
      brush: PdfBrushes.black,
      bounds: const Rect.fromLTWH(75, 60, 280, 50),
    );
    page.graphics.drawString(
      'Tel: ${setting.phone1} | Mobile: ${setting.phone2} | Fax: ${setting.fax}',
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      brush: PdfBrushes.black,
      bounds: const Rect.fromLTWH(56, 100, 300, 80),
    );

    page.graphics.drawString(
      '${setting.adress}',
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      brush: PdfBrushes.black,
      bounds: const Rect.fromLTWH(56, 113, 220, 80),
    );
    page.graphics.drawString(
      'Email: ${setting.email}',
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      brush: PdfBrushes.black,
      bounds: const Rect.fromLTWH(56, 126, 220, 80),
    );
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 120, 150, 45), brush: PdfBrushes.silver);

    page.graphics.drawString(
      'Facture',
      PdfStandardFont(PdfFontFamily.helvetica, 20),
      brush: PdfBrushes.black,
      bounds: const Rect.fromLTWH(440, 128, 150, 38),
    );

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 160, 150, 67), brush: PdfBrushes.whiteSmoke);
    page.graphics.drawString(
      "Honoraires d'avocat",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(420, 167, 150, 30),
    );
    page.graphics.drawString(
      "MF: ${setting.matricule}",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(420, 182, 150, 30),
    );
    page.graphics.drawString(
      "Facture N: ${setting.factureNumber}",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(420, 196, 150, 30),
    );
    page.graphics.drawString(
      "Date : ${dateT.day}/${dateT.month}/${dateT.year}",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(420, 210, 150, 30),
    );
    page.graphics.drawString(
      'TOTAL A PAYER (HT)',
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(315, nextY + 10, 150, 30),
    );

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(450, nextY + 5, 110, 25),
        brush: PdfBrushes.whiteSmoke);
    page.graphics.drawString(
      '${total.toStringAsFixed(3)} TND',
      PdfStandardFont(PdfFontFamily.helvetica, 11),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(475, nextY + 10, 150, 30),
    );
    page.graphics.drawString(
      'TAUX TVA',
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(315, nextY + 40, 150, 30),
    );
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(450, nextY + 35, 110, 25),
        brush: PdfBrushes.whiteSmoke);
    page.graphics.drawString(
      '${setting.tva} %',
      PdfStandardFont(PdfFontFamily.helvetica, 11),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(475, nextY + 40, 150, 30),
    );
    page.graphics.drawString(
      'TVA',
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(315, nextY + 70, 150, 30),
    );
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(450, nextY + 65, 110, 25),
        brush: PdfBrushes.whiteSmoke);
    page.graphics.drawString(
      '${(total * setting.tva / 100).toStringAsFixed(3)}',
      PdfStandardFont(PdfFontFamily.helvetica, 11),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(475, nextY + 70, 150, 30),
    );
    page.graphics.drawString(
      'TOTAL A PAYER (TTC)',
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(315, nextY + 100, 150, 30),
    );
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(450, nextY + 95, 110, 25),
        brush: PdfBrushes.whiteSmoke);
    page.graphics.drawString(
      '$totalPrice',
      PdfStandardFont(PdfFontFamily.helvetica, 11),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(475, nextY + 100, 150, 30),
    );

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(30, nextY + 140, 220, 25),
        brush: PdfBrushes.black);
    page.graphics.drawString(
      'Arrété la présete facture a la somme de :',
      PdfStandardFont(PdfFontFamily.helvetica, 11),
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(40, nextY + 144, 300, 30),
    );
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(250, nextY + 140, 320, 25),
        brush: PdfBrushes.whiteSmoke);
    page.graphics.drawString(
      currencyToWords(double.parse(totalPrice)),
      PdfStandardFont(PdfFontFamily.helvetica, 11),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(260, nextY + 144, 350, 30),
    );
    // Save the updated document
    final List<int> updatedBytes = await document.save();
    document.dispose();

    final file = File(
        '${setting.factureDirectory}/Facture_${setting.factureNumber}.pdf');

    // Write to file
    await file.writeAsBytes(updatedBytes);
  }

  double totalPrice(List<User> users) {
    double total = 0;
    for (var item in users) {
      total += item.price;
    }
    return total;
  }
}
