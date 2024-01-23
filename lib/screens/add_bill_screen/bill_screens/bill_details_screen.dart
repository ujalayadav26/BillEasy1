import 'dart:io' show File, Platform;

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parcha_app/repositories/pdf_helper.dart';
import 'package:parcha_app/screens/add_bill_screen/bill_screens/update_bill_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../model/bill_model/bill_model.dart';
import '../../../model/shop_model/shop_model.dart';
import '../../../utils/utils-functions.dart';
import '../../shop_info/shop_provider.dart';
import '../BillProvider.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class BillDetailsScreen extends StatelessWidget {
  //final BillModel bill;
  final index;

  BillDetailsScreen({required this.index});

  // String amount(String price, String count, String gst) {
  //   try {
  //     var amount = ((double.parse(price) * double.parse(count)) +
  //         ((double.parse(price) * int.parse(count) * double.parse(gst)) / 100));
  //     return amount.toStringAsFixed(2);
  //   } catch (e) {
  //     print("Error parsing number: $e");
  //     return "0";
  //   }
  // }
  //
  //
  // Future<pw.Document> generatePDF(BillModel bill, ShopModel shop, double total) async {
  //   final ByteData fontData =
  //       await rootBundle.load('assets/fonts/Poppins-Bold.ttf');
  //   final ttf = pw.Font.ttf(fontData.buffer.asByteData());
  //
  //   final pdf = pw.Document();
  //   pdf.addPage(
  //     pw.MultiPage(
  //       build: (context) => [
  //         pw.Header(
  //             level: 0,
  //             child: pw.Text(shop.shopName!,
  //                 style: pw.TextStyle(
  //                     fontSize: 30, fontWeight: pw.FontWeight.bold))),
  //         pw.Paragraph(
  //           text: shop.shopAddrese,
  //         ),
  //         pw.SizedBox(height: 20),
  //         pw.Column(
  //           crossAxisAlignment: pw.CrossAxisAlignment.start,
  //           mainAxisAlignment: pw.MainAxisAlignment.center,
  //           children: [
  //             pw.Row(
  //               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //               children: [
  //                 pw.Text("Invoice",
  //                     style: pw.TextStyle(
  //                         font: ttf,
  //                         fontSize: 30,
  //                         fontWeight: pw.FontWeight.bold)),
  //                 pw.Row(
  //                   children: [
  //                     pw.Text("GST No:",
  //                         style: pw.TextStyle(
  //                             font: ttf, fontWeight: pw.FontWeight.bold)),
  //                     pw.Text(shop.shopGstNo!,
  //                         style: pw.TextStyle(
  //                             font: ttf, fontWeight: pw.FontWeight.normal)),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //         pw.SizedBox(height: 20),
  //         pw.Row(
  //           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //           children: [
  //             pw.Column(
  //               crossAxisAlignment: pw.CrossAxisAlignment.start,
  //               children: [
  //                 pw.Row(
  //                   children: [
  //                     pw.Text('Bill To:',
  //                         style: pw.TextStyle(
  //                             font: ttf, fontWeight: pw.FontWeight.bold)),
  //                     pw.Text(
  //                       ' ${bill.buyerName}',
  //                     )
  //                   ],
  //                 ),
  //                 pw.Row(
  //                   children: [
  //                     pw.Text('Add:',
  //                         style: pw.TextStyle(
  //                             font: ttf, fontWeight: pw.FontWeight.bold)),
  //                     pw.Text(
  //                       ' ${bill.buyerAddress}',
  //                     )
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             pw.Column(
  //               crossAxisAlignment: pw.CrossAxisAlignment.start,
  //               children: [
  //                 pw.Row(
  //                   children: [
  //                     pw.Text('Bill No:',
  //                         style: pw.TextStyle(
  //                             font: ttf, fontWeight: pw.FontWeight.bold)),
  //                     pw.Text(
  //                       ' ${bill.id}',
  //                     )
  //                   ],
  //                 ),
  //                 pw.Row(
  //                   children: [
  //                     pw.Text('Date:',
  //                         style: pw.TextStyle(
  //                             font: ttf, fontWeight: pw.FontWeight.bold)),
  //                     pw.Text(
  //                       ' ${bill.dateAndTime}',
  //                     )
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //         pw.SizedBox(height: 20),
  //         pw.Row(
  //           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //           children: [
  //             pw.Container(
  //               width: 75,
  //               child: pw.Text('Item',
  //                   style: pw.TextStyle(
  //                       font: ttf, fontWeight: pw.FontWeight.bold)),
  //             ),
  //             pw.Text('Quantity',
  //                 style:
  //                     pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold)),
  //             pw.Text('Rate',
  //                 style:
  //                     pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold)),
  //             pw.Text('GST%',
  //                 style:
  //                     pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold)),
  //             pw.Text('Amount',
  //                 style:
  //                     pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold)),
  //           ],
  //         ),
  //         pw.SizedBox(height: 8),
  //         ...bill.buyStuff!.map((stuff) {
  //           // total += double.parse(amount(
  //           //     stuff.stuffPrice!, stuff.stuffCount!, stuff.parsDisOnStuff!));
  //           return pw.Padding(
  //             padding: const pw.EdgeInsets.only(top: 1.5, bottom: 1.5),
  //             child: pw.Row(
  //               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //               children: [
  //                 pw.Container(
  //                   width: 75,
  //                   child: pw.Text(
  //                     stuff.stuffName!,
  //                   ),
  //                 ),
  //                 pw.Text(
  //                   stuff.stuffCount!,
  //                 ),
  //                 pw.Text(
  //                   stuff.stuffPrice!,
  //                 ),
  //                 stuff.parsDisOnStuff! == "0"
  //                     ? pw.Text(" ")
  //                     : pw.Text(
  //                         "${stuff.parsDisOnStuff!}",
  //                       ),
  //                 pw.Text(
  //                   amount(stuff.stuffPrice!, stuff.stuffCount!,
  //                       stuff.parsDisOnStuff!),
  //                 ),
  //               ],
  //             ),
  //           );
  //         }).toList(),
  //         pw.Divider(),
  //         pw.Row(
  //           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //           children: [
  //             pw.Row(
  //               children: [
  //                 pw.Text("Total Amount ",
  //                     style: pw.TextStyle(
  //                       fontSize: 15,
  //                       fontWeight: pw.FontWeight.bold,
  //                       font: ttf,
  //                     )),
  //                 (bill.parsDisOnTotal == "0")
  //                     ? pw.SizedBox()
  //                     : pw.Text("(Discount ${bill.parsDisOnTotal})",
  //                         style: pw.TextStyle(
  //                           fontSize: 15,
  //                           fontWeight: pw.FontWeight.normal,
  //                           //font: ttf,
  //                         )),
  //               ],
  //             ),
  //             pw.Text(total.toString(),
  //                 style: pw.TextStyle(
  //                   font: ttf,
  //                 )),
  //           ],
  //         ),
  //         pw.Divider(),
  //         pw.Text("* ${shop.shopCondition}")
  //       ],
  //     ),
  //   );
  //   return pdf;
  // }
  //
  // Future savePDF(Future<pw.Document> pdf, String file_name) async {
  //   try {
  //     final directory = Platform.isAndroid
  //         ? await getTemporaryDirectory()
  //         : await getApplicationDocumentsDirectory();
  //     final file = File('${directory.path}/${file_name}.pdf');
  //
  //     var pdfObject = await pdf; // If pdf is a Future, we need to wait for it.
  //     var pdfBytes = await pdfObject.save();
  //     await file.writeAsBytes(pdfBytes);
  //     return file;
  //   } catch (e) {
  //     throw Exception("Error opening pdf file");
  //   }
  // }



  var s = 9;

  // Future<bool> isItAndroid11AndAbove() async {
  //   if (!Platform.isAndroid) {
  //     return false;
  //   }
  //
  //   final androidInfo = await DeviceInfoPlugin().androidInfo;
  //   return androidInfo.version.sdkInt >= 30; // Android 11 is SDK 30
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<BillModelProvider>(builder: (_, provider, __) {
      BillModel bill = provider.billList[index];
      double parsedValue = double.tryParse(
              provider.billList[index].parsDisOnTotal?.toString() ?? "") ??
          0.0;
      double total = 0 - parsedValue;

      //generatePDF(bill, total); // Call the method to generate PDF
      return LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.yellow[300],
            title: const Text('Bill Details'),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  provider.deleteBill(bill);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          body: Consumer<ShopProvider>(builder: (context, shopProvider, child) {
            ShopModel? shop = shopProvider.shop;
            return Padding(
              padding: const EdgeInsets.all(8),
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xfffff4db),
                        border: Border.all(width: 2,color: Theme.of(context).primaryColor),
                        borderRadius:
                        BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Bill from :- ",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        Text(shop!.shopName!,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(shop!.shopAddrese!,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.normal)),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Text("GST No:",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                            Text(shop.shopGstNo!,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  (constraints.maxWidth > 700)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text("Bill To:",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    Text("${bill.buyerName}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Bill No:",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    Text("${bill.id}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal)),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text("Add:",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        UtilsFunctions.truncateText(bill.buyerAddress!, 50),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal)),
                                    const SizedBox(
                                      width: 30,
                                    ),

                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Date:",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    Text("${bill.dateAndTime}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal)),
                                  ],
                                ),

                              ],
                            ),
                            const SizedBox(height: 16,),
                            Row(
                              children: [
                                CupertinoButton(
                                  onPressed: (){
                                    UtilsFunctions.makePhoneCall(bill.buyerMobile!);
                                  },
                                  padding: EdgeInsets.zero,
                                  child: Container(
                                    height: 45,
                                    width: 130,
                                    decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(15)),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.call,color: CupertinoColors.white,size: 20,),
                                        const SizedBox(width: 6,),
                                        Text("${bill.buyerMobile}",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal)),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6,),
                                CupertinoButton(
                                  onPressed: (){
                                    UtilsFunctions.openInWhatsapp(bill.buyerMobile!,"hii");
                                  },
                                  padding: EdgeInsets.zero,
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(15)),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: 25,
                                            height: 25,
                                            child: SvgPicture.asset("assets/svg/whatsapp.svg")),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6,),
                                CupertinoButton(
                                  onPressed: () async {
                                    // Create the pdf document.
                                    var pdf = PdfHelper.generatePDF(bill, shop!, total); // pass appropriate arguments for bill and total

                                    // Save the pdf document and get the file.
                                    final file = await PdfHelper.savePDF(pdf, bill.buyerName!);
                                    print(file);

                                    if (await Permission.storage.request().isGranted) {
                                      // Use share_plus to share the file
                                      await Share.shareFiles(
                                        [file.path],
                                        text: 'Example share text',
                                        subject: 'for ${bill.buyerName!}',
                                      );
                                    } else {
                                      print(
                                          "noooooooooooooooooooooooooooooooooooooooooooooooo");
                                    }
                                  },
                                  padding: EdgeInsets.zero,
                                  child: Container(
                                    height: 45,
                                    width: 130,
                                    decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(15)),
                                    alignment: Alignment.center,
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Text("share bill",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal)),
                                        SizedBox(width: 4,),
                                        Icon(Icons.share,color: CupertinoColors.white,size: 20,),

                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                  /// for mobile
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xfffff4db),
                                  border: Border.all(width: 2,color: Theme.of(context).primaryColor),
                                  borderRadius:
                                  BorderRadius.circular(20)),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10,),
                                  const Text("Bill to :- ",
                                      style: TextStyle(
                                          fontSize: 25, fontWeight: FontWeight.bold)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text("${bill.buyerName}",
                                              style: const TextStyle(
                                                  fontSize: 20, fontWeight: FontWeight.bold)),
                                        ],
                                      ),

                                    ],
                                  ),
                                  const SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Text("Add:",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          Text(UtilsFunctions.truncateText(bill.buyerAddress!, 30),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal)),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                  const SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Text("Date:",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          Text("${bill.dateAndTime}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Bill No:",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          Text("${bill.id}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CupertinoButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) => UpdateBillScreen(bill: bill)),
                                          );
                                        },
                                        padding: EdgeInsets.zero,
                                        child: Container(
                                          height: 25,
                                          width: 70,
                                          decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(15)),
                                          alignment: Alignment.center,
                                          child: const Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.edit_note_rounded,color: CupertinoColors.white,size: 20,),
                                              SizedBox(width: 6,),
                                              Text("Edite",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.normal)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16,),
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xfffff4db),
                                  border: Border.all(width: 2,color: Theme.of(context).primaryColor),
                                  borderRadius:
                                  BorderRadius.circular(20)),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("connect with customer :-",
                                          style: TextStyle(
                                              fontSize: 20, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 16,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CupertinoButton(
                                        onPressed: (){
                                          UtilsFunctions.makePhoneCall(bill.buyerMobile!);
                                        },
                                        padding: EdgeInsets.zero,
                                        child: Container(
                                          height: 45,
                                          width: 130,
                                          decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(15)),
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.call,color: CupertinoColors.white,size: 20,),
                                              const SizedBox(width: 6,),
                                              Text("${bill.buyerMobile}",
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.normal)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 6,),
                                      CupertinoButton(
                                        onPressed: (){
                                          UtilsFunctions.openInWhatsapp(bill.buyerMobile!,"hii");
                                        },
                                        padding: EdgeInsets.zero,
                                        child: Container(
                                          height: 45,
                                          width: 45,
                                          decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(15)),
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  width: 25,
                                                  height: 25,
                                                  child: SvgPicture.asset("assets/svg/whatsapp.svg")),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 6,),
                                      CupertinoButton(
                                        onPressed: () async {
                                          // Create the pdf document.
                                          var pdf = PdfHelper.generatePDF(bill, shop!, total); // pass appropriate arguments for bill and total

                                          // Save the pdf document and get the file.
                                          final file = await PdfHelper.savePDF(pdf, bill.buyerName!);
                                          print(file);

                                          if (await Permission.storage.request().isGranted) {
                                            // Use share_plus to share the file
                                            await Share.shareFiles(
                                              [file.path],
                                              text: 'Example share text',
                                              subject: 'for ${bill.buyerName!}',
                                            );
                                          } else {
                                            print(
                                                "noooooooooooooooooooooooooooooooooooooooooooooooo");
                                          }
                                        },
                                        padding: EdgeInsets.zero,
                                        child: Container(
                                          height: 45,
                                          width: 130,
                                          decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(15)),
                                          alignment: Alignment.center,
                                          child: const Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [

                                              Text("share bill",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.normal)),
                                              SizedBox(width: 4,),
                                              Icon(Icons.share,color: CupertinoColors.white,size: 20,),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),

                  const SizedBox(
                    height: 20,
                  ),
                  //Text('Total Discount: ${bill.parsDisOnTotal}'),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  ),

                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xfffff4db),
                        border: Border.all(width: 2,color: Theme.of(context).primaryColor),
                        borderRadius:
                        BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                              //color: Colors.black,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: const Text("Item",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:  Colors.black)),
                                ),
                                const Text("Quantity",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color:  Colors.black)),
                                const Text("Rate",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color:  Colors.black)),
                                const Text("GST",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color:  Colors.black)),
                                const Text("Amount",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color:  Colors.black)),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: bill.buyStuff!.map((stuff) {
                            total = total +
                                double.parse(PdfHelper.amount(stuff.stuffPrice!,
                                    stuff.stuffCount!, stuff.parsDisOnStuff!));
                            print(total);

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 5,
                                    child: Text(stuff.stuffName!,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        )),
                                  ),
                                  Text(stuff.stuffCount!,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      )),
                                  Text(stuff.stuffPrice!,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      )),
                                  stuff.parsDisOnStuff == "0"? const Text(" ",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      )):Text("${stuff.parsDisOnStuff!}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      )),
                                  Text(
                                      PdfHelper.amount(
                                          stuff.stuffPrice!,
                                          stuff.stuffCount!,
                                          (stuff.parsDisOnStuff! == null)
                                              ? "0"
                                              : stuff.parsDisOnStuff!),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      )),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text("Total Amount ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                                (bill.parsDisOnTotal == null ||
                                    bill.parsDisOnTotal == "0")
                                    ? const SizedBox()
                                    : Text("(Discount ${bill.parsDisOnTotal})",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    )),
                              ],
                            ),
                            Text(total.toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CupertinoButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => UpdateBillScreen(bill: bill)),
                                );
                              },
                              padding: EdgeInsets.zero,
                              child: Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(15)),
                                alignment: Alignment.center,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.edit_note_rounded,color: CupertinoColors.white,size: 20,),
                                    SizedBox(width: 6,),
                                    Text("Edite",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 280,
                  ),
                ],
              ),
            );
          }),
          floatingActionButton: Consumer<ShopProvider>(builder: (context, shopProvider, child) {
            ShopModel? shop = shopProvider.shop;
            return FloatingActionButton(
              backgroundColor: Colors.yellow[300],
              child: const Icon(Icons.file_download),
              onPressed: () async {
                // Create the pdf document.
                var pdf = PdfHelper.generatePDF(bill, shop!,
                    total); // pass appropriate arguments for bill and total

                // Save the pdf document and get the file.
                final file = await PdfHelper.savePDF(pdf, bill.buyerName!);
                print(file);

                if (await Permission.storage.request().isGranted) {
                  // Access the file
                  OpenFile.open(file.path);
                } else {
                  print("noooooooooooooooooooooooooooooooooooooooooooooooo");
                }
                // Open the file.
              },
            );
          }),
        );
      });
    });
  }
}
