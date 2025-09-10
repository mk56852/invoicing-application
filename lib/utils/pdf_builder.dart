import 'dart:io';

import 'package:flutter/material.dart';
import 'package:management_app/models/user.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfBuilder {
  final GlobalKey<SfDataGridState> gridKey;
  const PdfBuilder({required this.gridKey});

  Future<bool> build(List<User> users, Set<int> ids) async {
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
    PdfLayoutResult? layoutResult =
        await pdfGrid.draw(page: pdfPage, bounds: Rect.fromLTWH(20, 240, 0, 0));
    final List<int> bytes = document.saveSync();
    File('DataGrid.pdf').writeAsBytes(bytes);
    double nextY = layoutResult!.bounds.bottom + 70;
    await updatePdf(nextY, totalPrice(selectedUsers), 19);
    return true;
  }

  Future<void> updatePdf(double nextY, double total, int tva) async {
    try {
      // Load the existing PDF document from assets
      final File filex = File("DataGrid.pdf");
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
        bounds: const Rect.fromLTWH(50, 250, 0, 0),
      );
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(50, 50, 220, 38), brush: PdfBrushes.silver);
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(50, 90, 220, 80), brush: PdfBrushes.whiteSmoke);
      page.graphics.drawString(
        '     Maitre Nesrine Karray',
        PdfStandardFont(PdfFontFamily.helvetica, 15),
        brush: PdfBrushes.black,
        bounds: const Rect.fromLTWH(55, 60, 280, 50),
      );
      page.graphics.drawString(
        '- Tel: 98135216 | Mobile: 29267362 \n- Rue Mahdia Km8 Sekiet Dayer \n- Email: melek7967@gmail.com',
        PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: PdfBrushes.black,
        bounds: const Rect.fromLTWH(80, 100, 220, 80),
      );
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(400, 120, 150, 38), brush: PdfBrushes.silver);

      page.graphics.drawString(
        'Facture',
        PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.black,
        bounds: const Rect.fromLTWH(440, 128, 150, 38),
      );

      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(400, 160, 150, 80),
          brush: PdfBrushes.whiteSmoke);

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
        '$total TND',
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
        '$tva %',
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
        '${total * tva / 100}',
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
        '${total * (100 - tva) / 100}',
        PdfStandardFont(PdfFontFamily.helvetica, 11),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(475, nextY + 100, 150, 30),
      );
      // Save the updated document
      final List<int> updatedBytes = await document.save();
      document.dispose();

      final file = File('DataGrid.pdf');

      // Write to file
      await file.writeAsBytes(updatedBytes);

      print('PDF updated and saved to: ${file.path}');
    } catch (e) {
      print('Error updating PDF: $e');
    }
  }

  double totalPrice(List<User> users) {
    double total = 0;
    for (var item in users) {
      total += item.price;
    }
    return total;
  }
}
