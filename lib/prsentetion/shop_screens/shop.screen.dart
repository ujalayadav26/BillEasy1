import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parcha_app/model/shop_model/shop_model.dart';
import 'package:parcha_app/screens/shop_info/shop_manegment_screen.dart';

import '../../cubits/shop_cubit/shop_model_cubit.dart';

class ShopScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<ShopModelCubit>(context).deleteShop();
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: BlocBuilder<ShopModelCubit, ShopModelState>(
        builder: (context, state) {
          print(state);
          if (state is ShopModelLoading) {
            return CircularProgressIndicator();
          } else if (state is ShopModelLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Shop Management"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: state.shops.shopName,
                      decoration: const InputDecoration(
                        labelText: 'Shop Name',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      onSaved: (value) => shopName = value,
                      validator: (value) =>
                          value!.isEmpty ? 'This field is required' : null,
                      onFieldSubmitted: (_) {
                        // When the user presses "next", move the focus to the buyerAddress field.
                        FocusScope.of(context).requestFocus(gstNoFocusNode);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: state.shops.shopGstNo,
                      focusNode: gstNoFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'GST No',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      onSaved: (value) => shopGstNo = value,
                      validator: (value) =>
                          value!.isEmpty ? 'This field is required' : null,
                      onFieldSubmitted: (_) {
                        // When the user presses "next", move the focus to the buyerAddress field.
                        FocusScope.of(context).requestFocus(addAndMobFocusNode);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: state.shops.shopAddrese,
                      focusNode: addAndMobFocusNode,
                      decoration: const InputDecoration(
                        labelText: "Address and Phone",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      onSaved: (value) => shopAddress = value,
                      validator: (value) =>
                          value!.isEmpty ? 'This field is required' : null,
                      onFieldSubmitted: (_) {
                        // When the user presses "next", move the focus to the buyerAddress field.
                        FocusScope.of(context).requestFocus(conditionFocusNode);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: state.shops.shopCondition,
                      focusNode: conditionFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'Statement appear in bottom of bill',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      onSaved: (value) => shopCondition = value,
                      validator: (value) =>
                          value!.isEmpty ? 'This field is required' : null,
                      onFieldSubmitted: (_) {
                        // When the user presses "next", move the focus to the buyerAddress field.
                        FocusScope.of(context).requestFocus(saveShopFocusNode);
                      },
                    ),
                    const SizedBox(height: 32),
                    Focus(
                      focusNode: saveShopFocusNode,
                      child: CupertinoButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            final shop = ShopModel(shopName, shopGstNo,
                                shopAddress, shopCondition);

                            BlocProvider.of<ShopModelCubit>(context)
                                .saveShop(shop);
                            //Navigator.pop(context);
                          }
                        },
                        padding: EdgeInsets.zero,
                        child: Container(
                            height: 65,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(15)),
                            alignment: Alignment.center,
                            child: Text(
                              'Update Shop',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ShopModelAdding) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "You are first time in app fill the details, This information will appear in your generated bills."),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      //initialValue: shopProvider.shop?.shopName,
                      decoration: const InputDecoration(
                        labelText: 'Shop Name',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      onSaved: (value) => shopName = value,
                      validator: (value) =>
                          value!.isEmpty ? 'This field is required' : null,
                      onFieldSubmitted: (_) {
                        // When the user presses "next", move the focus to the buyerAddress field.
                        FocusScope.of(context).requestFocus(gstNoFocusNode);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      //initialValue: shopProvider.shop?.shopGstNo,
                      focusNode: gstNoFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'GST No',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      onSaved: (value) => shopGstNo = value,
                      validator: (value) =>
                          value!.isEmpty ? 'This field is required' : null,
                      onFieldSubmitted: (_) {
                        // When the user presses "next", move the focus to the buyerAddress field.
                        FocusScope.of(context).requestFocus(addAndMobFocusNode);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      // initialValue: shopProvider.shop?.shopAddrese,
                      focusNode: addAndMobFocusNode,
                      decoration: const InputDecoration(
                        labelText: "Address and Phone",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      onSaved: (value) => shopAddress = value,
                      validator: (value) =>
                          value!.isEmpty ? 'This field is required' : null,
                      onFieldSubmitted: (_) {
                        // When the user presses "next", move the focus to the buyerAddress field.
                        FocusScope.of(context).requestFocus(conditionFocusNode);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      // initialValue: shopProvider.shop?.shopCondition,
                      focusNode: conditionFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'Statement appear in bottom of bill',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      onSaved: (value) => shopCondition = value,
                      validator: (value) =>
                          value!.isEmpty ? 'This field is required' : null,
                      onFieldSubmitted: (_) {
                        // When the user presses "next", move the focus to the buyerAddress field.
                        FocusScope.of(context).requestFocus(saveShopFocusNode);
                      },
                    ),
                    const SizedBox(height: 32),
                    Focus(
                      focusNode: saveShopFocusNode,
                      child: CupertinoButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            final shop = ShopModel(shopName, shopGstNo,
                                shopAddress, shopCondition);

                            BlocProvider.of<ShopModelCubit>(context)
                                .saveShop(shop);
                            //Navigator.pop(context);

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
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(15)),
                          alignment: Alignment.center,
                          child: Text(
                            'Create Shop',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Container(
            color: Colors.red,
            height: 20,
            width: 30,
          );
        },
      ),
    );
  }
}
