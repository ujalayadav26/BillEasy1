import 'package:hive/hive.dart';

part 'shop_model.g.dart'; // this file will be generated later

@HiveType(typeId: 2)
class ShopModel extends HiveObject {
  @HiveField(0)
  String? shopName;

  @HiveField(1)
  String? shopGstNo;

  @HiveField(2)
  String? shopAddrese;

  @HiveField(3)
  String? shopCondition;

  ShopModel(this.shopName, this.shopGstNo, this.shopAddrese,this.shopCondition);
}
