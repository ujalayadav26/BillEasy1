import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../model/shop_model/shop_model.dart';
import '../add_bill_screen/bill_screens/all_bills_screen.dart';

const String shopBoxName = 'shopBox';
const String shopKey = 'userShop';

class ShopProvider with ChangeNotifier {

  Box<ShopModel>? _shopBox;

  // Initializing the Hive box.
  Future<void> initHive() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    _shopBox = await Hive.openBox<ShopModel>(shopBoxName);
  }

  // Alias method for creating a shop
  Future<void> createShop(ShopModel shopMode, BuildContext context) async {
    await setShop(shopMode,context);
    notifyListeners();
  }

  // Alias method for updating a shop
  Future<void> updateShop(ShopModel shopMode, BuildContext context) async {
    await setShop(shopMode,context);
    notifyListeners();
  }

  // Create or Update
  Future<void> setShop(ShopModel shopMode, BuildContext context) async {
    if (_shopBox != null) {
      await _shopBox!.put(shopKey, shopMode);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => BillListScreen()),
      );
      notifyListeners();
    } else {
      // Handle the error or throw a custom exception
      throw Exception("Hive box is not initialized.");
    }
  }

  Future<void> getDataOfShop() async{
    final box = await Hive.openBox<ShopModel>(shopBoxName); // Assuming _shopBoxName is a global constant
    shop = box.get(shopKey);
  }

  // Read
  ShopModel? shop;

  // Delete
  Future<void> deleteShop() async {
    await _shopBox!.delete(shopKey);
    notifyListeners();
  }

  // Clean up
  void close() {
    _shopBox!.close();
  }
}
