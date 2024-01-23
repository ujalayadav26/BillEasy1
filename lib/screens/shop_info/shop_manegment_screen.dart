import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:parcha_app/screens/shop_info/shop_provider.dart';
import 'package:provider/provider.dart';

import '../../cubits/shop_cubit/shop_model_cubit.dart';
import '../../model/shop_model/shop_model.dart';

class ShopManagementScreen extends StatefulWidget {
  @override
  _ShopManagementScreenState createState() => _ShopManagementScreenState();
}

class _ShopManagementScreenState extends State<ShopManagementScreen> {
  final _formKey = GlobalKey<FormState>();

  String? shopName;
  String? shopGstNo;
  String? shopAddress;
  String? shopCondition;


  final FocusNode gstNoFocusNode = FocusNode();
  final FocusNode addAndMobFocusNode = FocusNode();
  final FocusNode conditionFocusNode = FocusNode();
  final FocusNode saveShopFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Getting a reference to ShopProvider using Provider
    final shopProvider = Provider.of<ShopProvider>(context, listen: false);
    shopProvider.initHive();
    shopProvider.getDataOfShop();

    print(shopProvider.shop);
  }

  @override
  void dispose() {
    gstNoFocusNode.dispose();
    addAndMobFocusNode.dispose();
    conditionFocusNode.dispose();
    saveShopFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shopProvider = Provider.of<ShopProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[300],
        title: Text(shopProvider.shop == null
            ? "Welcome to Parcha"
            : "Shop Management"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(shopProvider.shop == null
                    ? "You are first time in app fill the details, \nThis information will appear in your generated bills."
                    : "Shop Management"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: shopProvider.shop?.shopName,
                decoration: const InputDecoration(
                  labelText: 'Shop Name',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                onSaved: (value) => shopName = value,
                validator: (value) =>
                    value!.isEmpty ? 'This field is required' : null,
                onFieldSubmitted: (_) {
                  // When the user presses "next", move the focus to the buyerAddress field.
                  FocusScope.of(context)
                      .requestFocus(gstNoFocusNode);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: shopProvider.shop?.shopGstNo,
                focusNode: gstNoFocusNode,
                decoration: const InputDecoration(
                  labelText: 'GST No',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                onSaved: (value) => shopGstNo = value,
                validator: (value) =>
                    value!.isEmpty ? 'This field is required' : null,
                onFieldSubmitted: (_) {
                  // When the user presses "next", move the focus to the buyerAddress field.
                  FocusScope.of(context)
                      .requestFocus(addAndMobFocusNode);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: shopProvider.shop?.shopAddrese,
                focusNode: addAndMobFocusNode,
                decoration: const InputDecoration(
                  labelText: "Address and Phone",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                onSaved: (value) => shopAddress = value,
                validator: (value) =>
                    value!.isEmpty ? 'This field is required' : null,
                onFieldSubmitted: (_) {
                  // When the user presses "next", move the focus to the buyerAddress field.
                  FocusScope.of(context)
                      .requestFocus(conditionFocusNode);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: shopProvider.shop?.shopCondition,
                focusNode: conditionFocusNode,
                decoration: const InputDecoration(
                  labelText: 'Statement appear in bottom of bill',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                onSaved: (value) => shopCondition = value,
                validator: (value) =>
                    value!.isEmpty ? 'This field is required' : null,
                onFieldSubmitted: (_) {
                  // When the user presses "next", move the focus to the buyerAddress field.
                  FocusScope.of(context)
                      .requestFocus(saveShopFocusNode);
                },
              ),
              const SizedBox(height: 32),
              Focus(
                focusNode: saveShopFocusNode,
                child: CupertinoButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final shop = ShopModel(
                          shopName, shopGstNo, shopAddress, shopCondition);


                      BlocProvider.of<ShopModelCubit>(context).saveShop(shop);
                      Navigator.pop(context);

                      // if (shopProvider.shop == null) {
                      //   await shopProvider.createShop(shop, context);
                      //   shopProvider.getDataOfShop();
                      // } else {
                      //   await shopProvider.updateShop(shop, context);
                      //   shopProvider.getDataOfShop();
                      // }
                    }
                  },
                  padding: EdgeInsets.zero,
                  child: Container(
                      height: 65,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(15)),
                      alignment: Alignment.center,
                      child: Text(shopProvider.shop == null
                          ? 'Create Shop'
                          : 'Update Shop',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                ),
              ),
              // if (shopProvider.shop != null) ...[
              //   SizedBox(height: 16),
              //   ElevatedButton(
              //     onPressed: () async {
              //       await shopProvider.deleteShop();
              //       shopProvider.getDataOfShop();
              //     },
              //     child: Text('Delete Shop'),
              //     style: ElevatedButton.styleFrom(primary: Colors.red),
              //   ),
              // ]
            ],
          ),
        ),
      ),
    );
  }
}
