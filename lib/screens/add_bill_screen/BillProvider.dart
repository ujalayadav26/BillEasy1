import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../model/bill_model/bill_model.dart';

class BillModelProvider with ChangeNotifier {


  final buyerNameController = TextEditingController();
  final buyerAddressController = TextEditingController();
  final buyerMobileController = TextEditingController();
  final parsDisOnTotalController = TextEditingController();
  List<TextEditingController> stuffNameControllers = [];
  List<TextEditingController> stuffPriceControllers = [];
  List<TextEditingController> stuffCountControllers = [];
  List<TextEditingController> parsDisOnStuffControllers = [];

  List<FocusNode> stuffNameFocusNodes = [];
  List<FocusNode> stuffPriceFocusNodes = [];
  List<FocusNode> stuffCountFocusNodes = [];
  List<FocusNode> parsDisOnStuffFocusNodes = [];

  List<BillModel> billList = [];

  BillModelProvider() {
    refreshBillList();
  }

  void addStuff() {
    stuffNameControllers.insert(0, TextEditingController());
    stuffPriceControllers.insert(0, TextEditingController());
    stuffCountControllers.insert(0, TextEditingController());
    parsDisOnStuffControllers.insert(0, TextEditingController());

    // Insert new focus nodes too
    stuffNameFocusNodes.insert(0, FocusNode());
    stuffPriceFocusNodes.insert(0, FocusNode());
    stuffCountFocusNodes.insert(0, FocusNode());
    parsDisOnStuffFocusNodes.insert(0, FocusNode());

    notifyListeners();
  }

  void deleteStuff(int index) {
    stuffNameControllers.removeAt(index);
    stuffPriceControllers.removeAt(index);
    stuffCountControllers.removeAt(index);
    parsDisOnStuffControllers.removeAt(index);
    notifyListeners();
  }

  void submitForm() {
    List<BillStuffModel> buyStuff = [];
    for (int i = 0; i < stuffNameControllers.length; i++) {
      buyStuff.add(BillStuffModel(
        stuffName: stuffNameControllers[i].text,
        stuffPrice: stuffPriceControllers[i].text,
        stuffCount: stuffCountControllers[i].text,
        parsDisOnStuff: parsDisOnStuffControllers[i].text
      ));
    }
    BillModel bill = BillModel(
      buyerName: buyerNameController.text,
      buyerAddress: buyerAddressController.text,
      buyerMobile: buyerMobileController.text,
      parsDisOnTotal: parsDisOnTotalController.text,
      buyStuff: buyStuff,
      dateAndTime: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} at ${DateTime.now().hour} : ${DateTime.now().minute}"
    );
    _saveBill(bill);
  }

  Future<void> _saveBill(BillModel bill) async {
    final box = await Hive.openBox<BillModel>('bills');
    final uniqueId = box.length; // Generate a new unique ID based on the length of the box
    bill.id = uniqueId; // Assign the new unique ID to the bill
    await box.put(uniqueId, bill); // Use put method with key
    refreshBillList();
  }

  Future<void> refreshBillList() async {
    var box;
    if (Hive.isBoxOpen('bills')) {
      box = Hive.box<BillModel>('bills');
      print('Hive box path -----------------------------------: ${box.path}');
    } else {
      box = await Hive.openBox<BillModel>('bills');
      print('Hive box path-------------------------------------------: ${box.path}');
    }
    billList = box.keys.map((key) {
      var bill = box.get(key);
      bill?.id = key; // Set the id from the key
      return bill;
    }).where((bill) => bill != null).toList().cast<BillModel>();
    notifyListeners();
  }

  Future<void> updateBill(BillModel bill) async {
    var box;
    if (Hive.isBoxOpen('bills')) {
      box = Hive.box<BillModel>('bills');
    } else {
      box = await Hive.openBox<BillModel>('bills');
    }
    await box.put(bill.id, bill);
    refreshBillList();
  }

  Future<void> deleteBill(BillModel bill) async {
    var box;
    if (Hive.isBoxOpen('bills')) {
      box = Hive.box<BillModel>('bills');
    } else {
      box = await Hive.openBox<BillModel>('bills');
    }
    await box.delete(bill.id); // Use delete method with key
    refreshBillList();
  }

}
