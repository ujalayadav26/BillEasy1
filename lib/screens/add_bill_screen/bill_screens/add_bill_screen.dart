import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/constents.dart';
import '../BillProvider.dart';

class BillForm extends StatelessWidget {
  final FocusNode buyerAddressFocusNode = FocusNode();
  final FocusNode buyerMobileFocusNode = FocusNode();
  final FocusNode parsDisOnTotalFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Consumer<BillModelProvider>(
      builder: (context, provider, child) {
        return LayoutBuilder(builder: (context, constraints) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.yellow[300],
              title: const Text('Bill Form'),
              actions: [
                // IconButton(
                //   icon: const Icon(Icons.add),
                //   onPressed: provider.addStuff,
                // ),
                IconButton(
                  icon: const Row(
                    children: [
                      Icon(Icons.save),
                      Text("Save")
                    ],
                  ),
                  onPressed: () {
                    provider.submitForm();
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 20,)
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: ListView(
                children: [

                  const SizedBox(height: 20,),

                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xfffff4db),
                        border: Border.all(width: 2,color: Theme.of(context).primaryColor),
                        borderRadius:
                        BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: provider.buyerNameController,
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
                                controller: provider.buyerAddressController,
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
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: provider.buyerMobileController,
                                    decoration: InputDecoration(
                                      labelText: Contents.BuyerMob,
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(15))),
                                    ),
                                    focusNode: buyerMobileFocusNode, // Assign the focus node to this field
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.phone,
                                    onFieldSubmitted: (_) {
                                      // Move the focus to the parsDisOnTotal field.
                                      FocusScope.of(context)
                                          .requestFocus(parsDisOnTotalFocusNode);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 35,
                                    child: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Text('',style: TextStyle(fontSize: 10,color: Colors.red),),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextFormField(
                                    controller: provider.parsDisOnTotalController,
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
                                  const SizedBox(
                                    height: 35,
                                    child: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Text('if you not give any discount fill this with "0"',style: TextStyle(fontSize: 10,color: Colors.red),),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.stuffNameControllers.length,
                    itemBuilder: (context, i) {
                      return (constraints.maxWidth > 500)
                          ? (i == 0)
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: const Color(0xfffff4db),
                                        border: Border.all(width: 2,color: Theme.of(context).primaryColor),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        const Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Add Item",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller: provider
                                                        .stuffNameControllers[i],
                                                    decoration: InputDecoration(
                                                      labelText: Contents.ItemName,
                                                      border: const OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.grey),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      15))),
                                                    ),
                                                    focusNode: provider
                                                        .stuffNameFocusNodes[i],
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onFieldSubmitted: (_) {
                                                      // Move focus to the next field
                                                      FocusScope.of(context)
                                                          .requestFocus(provider
                                                              .stuffPriceFocusNodes[i]);
                                                    },
                                                  ),
                                                  const SizedBox(height: 35,)
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller: provider
                                                        .stuffPriceControllers[i],
                                                    keyboardType: TextInputType.phone,
                                                    decoration: InputDecoration(
                                                      labelText: Contents.ItemPrice,
                                                      border: const OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.grey),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      15))),
                                                    ),
                                                    focusNode: provider
                                                        .stuffPriceFocusNodes[i],
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onFieldSubmitted: (_) {
                                                      // Move focus to the next field
                                                      FocusScope.of(context)
                                                          .requestFocus(provider
                                                              .stuffCountFocusNodes[i]);
                                                    },
                                                  ),
                                                  const SizedBox(height: 35,)
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller: provider
                                                        .stuffCountControllers[i],
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          Contents.ItemQuantity,
                                                      border: const OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.grey),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      15))),
                                                    ),
                                                    focusNode: provider
                                                        .stuffCountFocusNodes[i],
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    keyboardType: TextInputType.phone,
                                                    onFieldSubmitted: (_) {
                                                      // Move focus to the next field
                                                      FocusScope.of(context)
                                                          .requestFocus(provider
                                                              .parsDisOnStuffFocusNodes[i]);
                                                    },
                                                  ),
                                                  const SizedBox(height: 35,)
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  TextFormField(
                                                    controller: provider
                                                        .parsDisOnStuffControllers[i],
                                                    decoration: InputDecoration(
                                                      labelText: Contents.ItemGst,
                                                      border: const OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.grey),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      15))),
                                                    ),
                                                    keyboardType: TextInputType.phone,
                                                    focusNode: provider
                                                        .parsDisOnStuffFocusNodes[i],
                                                    // Do not add the TextInputAction.next if it is the last field
                                                  ),
                                                  const SizedBox(
                                                    height: 35,
                                                    child: Padding(
                                                      padding: EdgeInsets.all(4.0),
                                                      child: Text('if you not want to use GST, fill this with "0".',style: TextStyle(fontSize: 10,color: Colors.red),),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () =>
                                                  provider.deleteStuff(i),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: const Color(0xfffff4db),
                                        border: Border.all(width: 0,color: Theme.of(context).primaryColor),
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: provider
                                                .stuffNameControllers[i],
                                            decoration: InputDecoration(
                                              labelText: Contents.ItemName,
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                            ),
                                            focusNode:
                                                provider.stuffNameFocusNodes[i],
                                            textInputAction:
                                                TextInputAction.next,
                                            onFieldSubmitted: (_) {
                                              // Move focus to the next field
                                              FocusScope.of(context)
                                                  .requestFocus(provider
                                                      .stuffPriceFocusNodes[i]);
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            controller: provider
                                                .stuffPriceControllers[i],
                                            decoration: InputDecoration(
                                              labelText: Contents.ItemPrice,
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                            ),
                                            focusNode: provider
                                                .stuffPriceFocusNodes[i],
                                            textInputAction:
                                                TextInputAction.next,
                                            onFieldSubmitted: (_) {
                                              // Move focus to the next field
                                              FocusScope.of(context)
                                                  .requestFocus(provider
                                                      .stuffCountFocusNodes[i]);
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            controller: provider
                                                .stuffCountControllers[i],
                                            decoration: InputDecoration(
                                              labelText: Contents.ItemQuantity,
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                            ),
                                            focusNode: provider
                                                .stuffCountFocusNodes[i],
                                            textInputAction:
                                                TextInputAction.next,
                                            onFieldSubmitted: (_) {
                                              // Move focus to the next field
                                              FocusScope.of(context)
                                                  .requestFocus(provider
                                                      .parsDisOnStuffFocusNodes[i]);
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            controller: provider
                                                .parsDisOnStuffControllers[i],
                                            decoration: InputDecoration(
                                              labelText: Contents.ItemGst,
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                            ),
                                            focusNode: provider
                                                .parsDisOnStuffFocusNodes[i],
                                            // Do not add the TextInputAction.next if it is the last field
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () =>
                                              provider.deleteStuff(i),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                          : (i == 0)
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xfffff4db),
                                        border: Border.all(width: 2,color: Theme.of(context).primaryColor),
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          const Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("Add Item",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),),
                                              ),
                                            ],
                                          ),
                                          TextFormField(
                                            controller: provider
                                                .stuffNameControllers[i],
                                            decoration: InputDecoration(
                                              labelText: Contents.ItemName,
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                            ),
                                            focusNode:
                                                provider.stuffNameFocusNodes[i],
                                            textInputAction:
                                                TextInputAction.next,
                                            onFieldSubmitted: (_) {
                                              // Move focus to the next field
                                              FocusScope.of(context)
                                                  .requestFocus(provider
                                                      .stuffPriceFocusNodes[i]);
                                            },
                                          ),
                                          const SizedBox(height: 10),
                                          TextFormField(
                                            controller: provider
                                                .stuffPriceControllers[i],
                                            decoration: InputDecoration(
                                              labelText: Contents.ItemPrice,
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                            ),
                                            focusNode: provider
                                                .stuffPriceFocusNodes[i],
                                            textInputAction:
                                                TextInputAction.next,
                                            onFieldSubmitted: (_) {
                                              // Move focus to the next field
                                              FocusScope.of(context)
                                                  .requestFocus(provider
                                                      .stuffCountFocusNodes[i]);
                                            },
                                          ),
                                          const SizedBox(height: 10),
                                          TextFormField(
                                            controller: provider
                                                .stuffCountControllers[i],
                                            decoration: InputDecoration(
                                              labelText: Contents.ItemQuantity,
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                            ),
                                            focusNode: provider
                                                .stuffCountFocusNodes[i],
                                            textInputAction:
                                                TextInputAction.next,
                                            onFieldSubmitted: (_) {
                                              // Move focus to the next field
                                              FocusScope.of(context)
                                                  .requestFocus(provider
                                                      .parsDisOnStuffFocusNodes[i]);
                                            },
                                          ),
                                          const SizedBox(height: 10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              TextFormField(
                                                controller: provider
                                                    .parsDisOnStuffControllers[i],
                                                decoration: InputDecoration(
                                                  labelText: Contents.ItemGst,
                                                  border: const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              15))),
                                                ),
                                                keyboardType: TextInputType.phone,
                                                focusNode: provider
                                                    .parsDisOnStuffFocusNodes[i],
                                                // Do not add the TextInputAction.next if it is the last field
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Text('if you not want to use GST, fill this with "0".',style: TextStyle(fontSize: 10,color: Colors.red),),
                                              )
                                            ],
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () =>
                                                provider.deleteStuff(i),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xfffff4db),
                                        border: Border.all(width: 1,color: Theme.of(context).primaryColor),
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: provider
                                                .stuffNameControllers[i],
                                            decoration: InputDecoration(
                                              labelText: Contents.ItemName,
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                            ),
                                            focusNode:
                                                provider.stuffNameFocusNodes[i],
                                            textInputAction:
                                                TextInputAction.next,
                                            onFieldSubmitted: (_) {
                                              // Move focus to the next field
                                              FocusScope.of(context)
                                                  .requestFocus(provider
                                                      .stuffPriceFocusNodes[i]);
                                            },
                                          ),
                                          const SizedBox(height: 10),
                                          TextFormField(
                                            controller: provider
                                                .stuffPriceControllers[i],
                                            decoration: InputDecoration(
                                              labelText: Contents.ItemPrice,
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                            ),
                                            focusNode: provider
                                                .stuffPriceFocusNodes[i],
                                            textInputAction:
                                                TextInputAction.next,
                                            onFieldSubmitted: (_) {
                                              // Move focus to the next field
                                              FocusScope.of(context)
                                                  .requestFocus(provider
                                                      .stuffCountFocusNodes[i]);
                                            },
                                          ),
                                          const SizedBox(height: 10),
                                          TextFormField(
                                            controller: provider
                                                .stuffCountControllers[i],
                                            decoration: InputDecoration(
                                              labelText: Contents.ItemQuantity,
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                            ),
                                            focusNode: provider
                                                .stuffCountFocusNodes[i],
                                            textInputAction:
                                                TextInputAction.next,
                                            onFieldSubmitted: (_) {
                                              // Move focus to the next field
                                              FocusScope.of(context)
                                                  .requestFocus(provider
                                                      .parsDisOnStuffFocusNodes[i]);
                                            },
                                          ),
                                          const SizedBox(height: 10),
                                          TextFormField(
                                            controller: provider
                                                .parsDisOnStuffControllers[i],
                                            decoration: InputDecoration(
                                              labelText: Contents.ItemGst,
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                            ),
                                            focusNode: provider
                                                .parsDisOnStuffFocusNodes[i],
                                            // Do not add the TextInputAction.next if it is the last field
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () =>
                                                provider.deleteStuff(i),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                    },
                  ),
                  const SizedBox(height: 90,),
                ],
              ),
            ),
            floatingActionButton: Container(
              width: 150,
              child: FloatingActionButton(
                backgroundColor: Colors.yellow[300],
                onPressed: provider.addStuff,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add,),
                    SizedBox(width: 5,),
                    Text("Add Stuff")
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
