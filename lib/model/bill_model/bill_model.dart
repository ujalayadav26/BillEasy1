import 'package:hive/hive.dart';

part 'bill_model.g.dart';

@HiveType(typeId: 0)
class BillModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? buyerName;
  @HiveField(2)
  String? buyerAddress;
  @HiveField(3)
  String? buyerMobile;
  @HiveField(4)
  String? parsDisOnTotal;
  @HiveField(5)
  List<BillStuffModel>? buyStuff;
  @HiveField(6)
  String? dateAndTime;

  BillModel({
    this.id,
    this.buyerName,
    this.buyerAddress,
    this.buyerMobile,
    this.parsDisOnTotal,
    this.buyStuff,
    this.dateAndTime
  });
}

@HiveType(typeId: 1)
class BillStuffModel extends HiveObject {
  @HiveField(0)
  String? stuffName;
  @HiveField(1)
  String? stuffPrice;
  @HiveField(2)
  String? stuffCount;
  @HiveField(3)
  String? parsDisOnStuff;

  BillStuffModel({this.stuffName, this.stuffPrice, this.stuffCount,this.parsDisOnStuff});
}
