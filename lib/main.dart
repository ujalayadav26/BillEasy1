import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:parcha_app/prsentetion/shop_screens/shop.screen.dart';
import 'package:parcha_app/repositories/hive_operations.repo.dart';
import 'package:parcha_app/screens/add_bill_screen/BillProvider.dart';
import 'package:parcha_app/screens/add_bill_screen/bill_screens/add_bill_screen.dart';
import 'package:parcha_app/screens/add_bill_screen/bill_screens/all_bills_screen.dart';
import 'package:parcha_app/screens/shop_info/shop_manegment_screen.dart';
import 'package:parcha_app/screens/shop_info/shop_provider.dart';
import 'package:parcha_app/utils/constents.dart';
import 'package:provider/provider.dart';

import 'cubits/shop_cubit/shop_model_cubit.dart';
import 'model/bill_model/bill_model.dart';
import 'model/shop_model/shop_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ShopModeAdapter());
  Hive.registerAdapter(BillModelAdapter());
  Hive.registerAdapter(BillStuffModelAdapter());
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => BillModelProvider()),
    ChangeNotifierProvider(create: (context) => ShopProvider())
  ], child: MyApp()));
  WidgetsBinding.instance?.addPostFrameCallback((_) {
    Hive.close();
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _navigateToShopManagement = false;

  @override
  void initState() {
    super.initState();
    _checkShopModeData();
    final shopProvider = Provider.of<ShopProvider>(context, listen: false);
    shopProvider.getDataOfShop();
  }

  Future<void> _checkShopModeData() async {
    final box = await Hive.openBox<ShopModel>(
        shopBoxName); // Assuming _shopBoxName is a global constant
    final shop = box.get(shopKey); // Assuming _shopKey is a global constant

    if (shop == null ||
        shop.shopName == null ||
        shop.shopGstNo == null ||
        shop.shopAddrese == null ||
        shop.shopCondition == null) {
      setState(() {
        _navigateToShopManagement = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopModelCubit(HiveOperationsRepository<ShopModel>(KeyContents.shopBoxKey))..refreshShop(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
       //home: ShopScreen(),
       home: _navigateToShopManagement ? ShopManagementScreen() : BillListScreen(),
      ),
    );
  }
}
