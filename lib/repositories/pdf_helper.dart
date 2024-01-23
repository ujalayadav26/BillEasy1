import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import '../model/bill_model/bill_model.dart';
import '../model/shop_model/shop_model.dart';

class PdfHelper {
  static String amount(String price, String count, String gst) {
    try {
      var amount = ((double.parse(price) * double.parse(count)) +
          ((double.parse(price) * int.parse(count) * double.parse(gst)) / 100));
      return amount.toStringAsFixed(2);
    } catch (e) {
      print("Error parsing number: $e");
      return "0";
    }
  }

  static Future<pw.Document> generatePDF(
      BillModel bill, ShopModel shop, double total) async {
    final ByteData fontData =
        await rootBundle.load('assets/fonts/Poppins-Bold.ttf');
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());

    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Header(
              level: 0,
              child: pw.Text(shop.shopName!,
                  style: pw.TextStyle(
                      fontSize: 30, fontWeight: pw.FontWeight.bold))),
          pw.Paragraph(
            text: shop.shopAddrese,
          ),
          pw.SizedBox(height: 20),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Invoice",
                      style: pw.TextStyle(
                          font: ttf,
                          fontSize: 30,
                          fontWeight: pw.FontWeight.bold)),
                  pw.Row(
                    children: [
                      pw.Text("GST No:",
                          style: pw.TextStyle(
                              font: ttf, fontWeight: pw.FontWeight.bold)),
                      pw.Text(shop.shopGstNo!,
                          style: pw.TextStyle(
                              font: ttf, fontWeight: pw.FontWeight.normal)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    children: [
                      pw.Text('Bill To:',
                          style: pw.TextStyle(
                              font: ttf, fontWeight: pw.FontWeight.bold)),
                      pw.Text(
                        ' ${bill.buyerName}',
                      )
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text('Add:',
                          style: pw.TextStyle(
                              font: ttf, fontWeight: pw.FontWeight.bold)),
                      pw.Text(
                        ' ${bill.buyerAddress}',
                      )
                    ],
                  ),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    children: [
                      pw.Text('Bill No:',
                          style: pw.TextStyle(
                              font: ttf, fontWeight: pw.FontWeight.bold)),
                      pw.Text(
                        ' ${bill.id}',
                      )
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text('Date:',
                          style: pw.TextStyle(
                              font: ttf, fontWeight: pw.FontWeight.bold)),
                      pw.Text(
                        ' ${bill.dateAndTime}',
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Container(
                width: 75,
                child: pw.Text('Item',
                    style: pw.TextStyle(
                        font: ttf, fontWeight: pw.FontWeight.bold)),
              ),
              pw.Text('Quantity',
                  style:
                      pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold)),
              pw.Text('Rate',
                  style:
                      pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold)),
              pw.Text('GST%',
                  style:
                      pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold)),
              pw.Text('Amount',
                  style:
                      pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold)),
            ],
          ),
          pw.SizedBox(height: 8),
          ...bill.buyStuff!.map((stuff) {
            // total += double.parse(amount(
            //     stuff.stuffPrice!, stuff.stuffCount!, stuff.parsDisOnStuff!));
            return pw.Padding(
              padding: const pw.EdgeInsets.only(top: 1.5, bottom: 1.5),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Container(
                    width: 75,
                    child: pw.Text(
                      stuff.stuffName!,
                    ),
                  ),
                  pw.Text(
                    stuff.stuffCount!,
                  ),
                  pw.Text(
                    stuff.stuffPrice!,
                  ),
                  stuff.parsDisOnStuff! == "0"
                      ? pw.Text(" ")
                      : pw.Text(
                          "${stuff.parsDisOnStuff!}",
                        ),
                  pw.Text(
                    amount(stuff.stuffPrice!, stuff.stuffCount!,
                        stuff.parsDisOnStuff!),
                  ),
                ],
              ),
            );
          }).toList(),
          pw.Divider(),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Row(
                children: [
                  pw.Text("Total Amount ",
                      style: pw.TextStyle(
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                      )),
                  (bill.parsDisOnTotal == "0")
                      ? pw.SizedBox()
                      : pw.Text("(Discount ${bill.parsDisOnTotal})",
                          style: pw.TextStyle(
                            fontSize: 15,
                            fontWeight: pw.FontWeight.normal,
                            //font: ttf,
                          )),
                ],
              ),
              pw.Text(total.toString(),
                  style: pw.TextStyle(
                    font: ttf,
                  )),
            ],
          ),
          pw.Divider(),
          pw.Text("* ${shop.shopCondition}")
        ],
      ),
    );
    return pdf;
  }

  static Future savePDF(Future<pw.Document> pdf, String file_name) async {
    try {
      final directory = Platform.isAndroid
          ? await getTemporaryDirectory()
          : await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/${file_name}.pdf');

      var pdfObject = await pdf; // If pdf is a Future, we need to wait for it.
      var pdfBytes = await pdfObject.save();
      await file.writeAsBytes(pdfBytes);
      return file;
    } catch (e) {
      throw Exception("Error opening pdf file");
    }
  }
}
