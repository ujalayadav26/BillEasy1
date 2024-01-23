import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/constents.dart';
import '../../../model/bill_model/bill_model.dart';
import '../BillProvider.dart';

class UpdateBillScreen extends StatefulWidget {
  final BillModel bill;

  UpdateBillScreen({required this.bill});

  @override
  _UpdateBillScreenState createState() => _UpdateBillScreenState();
}

class _UpdateBillScreenState extends State<UpdateBillScreen> {
  late TextEditingController buyerNameController;
  late TextEditingController buyerAddressController;
  late TextEditingController buyerMobileController;
  late TextEditingController parsDisOnTotalController;

  late List<TextEditingController> stuffNameControllers;
  late List<TextEditingController> stuffPriceControllers;
  late List<TextEditingController> stuffCountControllers;
  late List<TextEditingController> parsDisOnStuffControllers;

  @override
  void initState() {
    super.initState();
    buyerNameController = TextEditingController(text: widget.bill.buyerName);
    buyerAddressController =
        TextEditingController(text: widget.bill.buyerAddress);
    buyerMobileController =
        TextEditingController(text: widget.bill.buyerMobile);
    parsDisOnTotalController =
        TextEditingController(text: widget.bill.parsDisOnTotal);

    stuffNameControllers = widget.bill.buyStuff!
        .map((e) => TextEditingController(text: e.stuffName))
        .toList();
    stuffPriceControllers = widget.bill.buyStuff!
        .map((e) => TextEditingController(text: e.stuffPrice))
        .toList();
    stuffCountControllers = widget.bill.buyStuff!
        .map((e) => TextEditingController(text: e.stuffCount))
        .toList();
    parsDisOnStuffControllers = widget.bill.buyStuff!
        .map((e) => TextEditingController(text: e.parsDisOnStuff))
        .toList();
  }

  void updateBill() {
    List<BillStuffModel> buyStuff = [];
    for (int i = 0; i < stuffNameControllers.length; i++) {
      buyStuff.add(BillStuffModel(
          stuffName: stuffNameControllers[i].text,
          stuffPrice: stuffPriceControllers[i].text,
          stuffCount: stuffCountControllers[i].text,
          parsDisOnStuff: parsDisOnStuffControllers[i].text));
    }

    BillModel updatedBill = BillModel(
      id: widget.bill.id, // make sure to keep the same id
      buyerName: buyerNameController.text,
      buyerAddress: buyerAddressController.text,
      buyerMobile: buyerMobileController.text,
      parsDisOnTotal: parsDisOnTotalController.text,
      buyStuff: buyStuff,
      dateAndTime: widget.bill.dateAndTime
    );

    Provider.of<BillModelProvider>(context, listen: false).updateBill(updatedBill);
    Navigator.pop(context); // Close the screen after update
  }

  final FocusNode buyerAddressFocusNode = FocusNode();
  final FocusNode buyerMobileFocusNode = FocusNode();
  final FocusNode parsDisOnTotalFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[300],
          title: const Text('Update Bill'),
          actions: [ IconButton(
            icon: const Icon(Icons.done_outline_rounded),
            onPressed: updateBill,
          ),],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: buyerNameController,
                      decoration: InputDecoration(
                        labelText: Contents.BuyerName,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        // When the user presses "next", move the focus to the buyerAddress field.
                        FocusScope.of(context)
                            .requestFocus(buyerAddressFocusNode);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: buyerAddressController,
                      decoration: InputDecoration(
                        labelText: Contents.BuyerAdd,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      focusNode:
                          buyerAddressFocusNode, // Assign the focus node to this field
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        // Move the focus to the buyerMobile field.
                        FocusScope.of(context)
                            .requestFocus(buyerMobileFocusNode);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: buyerMobileController,
                      decoration: InputDecoration(
                        labelText: Contents.BuyerMob,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      focusNode:
                          buyerMobileFocusNode, // Assign the focus node to this field
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      onFieldSubmitted: (_) {
                        // Move the focus to the parsDisOnTotal field.
                        FocusScope.of(context)
                            .requestFocus(parsDisOnTotalFocusNode);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: parsDisOnTotalController,
                      decoration: InputDecoration(
                        labelText: Contents.BuyerDisco,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      focusNode:
                          parsDisOnTotalFocusNode, // Assign the focus node to this field
                      // Do not add the TextInputAction.next if it is the last field
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ...List.generate(
                stuffNameControllers.length,
                (index) => (constraints.maxWidth > 500)
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: stuffNameControllers[index],
                                  decoration: InputDecoration(
                                    labelText: Contents.ItemName,
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: stuffPriceControllers[index],
                                  decoration: InputDecoration(
                                    labelText: Contents.ItemPrice,
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: stuffCountControllers[index],
                                  decoration: InputDecoration(
                                    labelText: Contents.ItemQuantity,
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: parsDisOnStuffControllers[index],
                                  decoration: InputDecoration(
                                    labelText: Contents.ItemGst,
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: const Color(0xfffff4db),
                                border: Border.all(width: 2,color: Theme.of(context).primaryColor),
                                borderRadius:
                                BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: stuffNameControllers[index],
                                    decoration: InputDecoration(
                                      labelText: Contents.ItemName,
                                      border: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: stuffPriceControllers[index],
                                    decoration: InputDecoration(
                                      labelText: Contents.ItemPrice,
                                      border: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: stuffCountControllers[index],
                                    decoration: InputDecoration(
                                      labelText: Contents.ItemQuantity,
                                      border: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: parsDisOnStuffControllers[index],
                                    decoration: InputDecoration(
                                      labelText: Contents.ItemGst,
                                      border: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            //color: Colors.redAccent,
                            height: 10,
                          ),
                        ],
                      ),
              ),
              // ElevatedButton(
              //   onPressed: updateBill,
              //   child: const Text('Update Bill'),
              // ),
              CupertinoButton(
                onPressed: updateBill,
                padding: EdgeInsets.zero,
                child: Container(
                    height: 65,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(15)),
                    alignment: Alignment.center,
                    child: Text('Update Bill',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
              )
            ],
          ),
        ),
      );
    });
  }
}
