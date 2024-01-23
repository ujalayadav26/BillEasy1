import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../../model/bill_model/bill_model.dart';
import '../../../utils/utils-functions.dart';
import '../../about_us/about_us.dart';
import '../../shop_info/shop_manegment_screen.dart';
import '../BillProvider.dart';
import 'add_bill_screen.dart';
import 'bill_details_screen.dart';

class BillListScreen extends StatefulWidget {
  @override
  _BillListScreenState createState() => _BillListScreenState();
}

class _BillListScreenState extends State<BillListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the bill list when the screen is created
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<BillModelProvider>(context, listen: false).refreshBillList();
    });
  }

  void bottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.5,
            maxChildSize: 0.9,
            minChildSize: 0.32,
            builder:
                (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  //color: Colors.orange,
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(30))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 5,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(30)),
                              )
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        CupertinoButton(
                          child: const Row(
                            children: [
                              Icon(Icons.add_business_rounded,),
                              SizedBox(width: 10,),
                              Text("Shop Info")
                            ],
                          ),
                          onPressed: () {
                            // Navigate to a new screen where the user can view more details about the bill
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => ShopManagementScreen()),
                            );
                          },
                        ),

                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CupertinoButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const AboutUs()));
                                },
                                child: Container(
                                    width: 130,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(30),
                                        border: Border.all(
                                            color: Theme.of(context).primaryColor, width: 3)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("About us"),
                                    ))),
                            CupertinoButton(
                                onPressed: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyPolicy()));
                                },
                                child: Container(
                                    width: 130,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(30),
                                        border: Border.all(
                                            color: Theme.of(context).primaryColor, width: 3)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Privacy policy"),
                                    ))),
                          ],
                        ),
                        CupertinoButton(
                          onPressed: (){
                            UtilsFunctions.openInWhatsapp("7271088606","hii i am come frome your Parcha App i want desktop application for my shop.");
                          },
                          padding: EdgeInsets.zero,
                          child: Container(
                            height: 45,
                            width: 305,
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
                                SizedBox(width: 5,),
                                const Text("Connect for desktop Application",style: TextStyle(color: Colors.white),)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "©2023 All Right ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  Text(
                                    "AsyncApps",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color:Theme.of(context).primaryColor),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10,)
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[300],
        title: const Text('Saved Bills'),
         actions: [

          CupertinoButton(
            child: const Icon(Icons.dehaze_rounded,),
            onPressed: () {
              bottomSheet(context);
            },
          )
        ],
      ),
      body: Consumer<BillModelProvider>(
        builder: (_, provider, __) {
          if (provider.billList.isEmpty) {
            return const Center(child: Text('No bills saved yet.'));
          }
          return ListView.builder(
            itemCount: provider.billList.length,
            itemBuilder: (context, index) {
              BillModel bill = provider.billList[ provider.billList.length-1-index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0),border: Border.all(width: 1,color: Colors.amber)),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    title: Text('Bill for: ${bill.buyerName}'),
                    subtitle: Text('Address: ${bill.buyerAddress}'),
                    onTap: () {
                      // Navigate to a new screen where the user can view more details about the bill
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => BillDetailsScreen(index: provider.billList.length-1-index,)),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Container(
        width: 150,
        child: FloatingActionButton(backgroundColor: Colors.yellow[300],
          onPressed: () {
            // Navigate to a new screen where the user can view more details about the bill
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => BillForm()),
            );
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add,),
            SizedBox(width: 5,),
            Text("Add Bill")
          ],
        ),),
      ),
    );
  }
}

