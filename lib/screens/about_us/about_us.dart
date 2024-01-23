import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:math' as math;

import '../../utils/ui_utils/colers.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {




  //for do a phone call
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  //for sanding a email
  Future<void> _emailURL() async{

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'ujalayadav1012@gmail.com',
      // query: encodeQueryParameters(<String, String>{
      //   'subject': 'Example Subject & Symbols are allowed!',
      // }),
    );

    await launchUrl(emailLaunchUri);
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "AsyncApps",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Col().main2nd),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
                width: 50,
                height: 50,
                child: SvgPicture.asset("assets/svg/my_logo_svg.svg")),
          ],
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.rotate(
                      angle: math.pi / 10,
                      child: Container(
                        height: 50,
                        width: 150,
                        alignment: FractionalOffset.center,
                        decoration: BoxDecoration(
                            color: Color(0x33c75cfa),
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Transform.rotate(
                      angle: -math.pi / 10,
                      child: Container(
                        height: 50,
                        width: 150,
                        alignment: FractionalOffset.center,
                        decoration: BoxDecoration(
                            color: Color(0x33ffe200),
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Transform.rotate(
                      angle: math.pi / 6,
                      child: Container(
                        height: 50,
                        width: 150,
                        alignment: FractionalOffset.center,
                        decoration: BoxDecoration(
                            color: Color(0x26FFA443),
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                    Transform.rotate(
                      angle: math.pi / 1,
                      child: Container(
                        height: 50,
                        width: 150,
                        alignment: FractionalOffset.center,
                        decoration: BoxDecoration(
                            color: Color(0x26006fff),
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Transform.rotate(
                      angle: math.pi / 10,
                      child: Container(
                        height: 50,
                        width: 150,
                        alignment: FractionalOffset.center,
                        decoration: BoxDecoration(
                            color: Color(0x3300ffcf),
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Transform.rotate(
                      angle: math.pi / -4,
                      child: Container(
                        height: 50,
                        width: 150,
                        alignment: FractionalOffset.center,
                        decoration: BoxDecoration(
                            color: Color(0x338aff3a),
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '"AsyncApps is a software\n development company that specializes in creating applications that help offline businesses transition to an online presence. Our team of skilled developers and designers work together to create customized solutions for businesses of all sizes, with the goal of streamlining their processes and increasing their online visibility. Our apps are designed to be user-friendly and intuitive, making it easy for businesses to manage their online presence without the need for technical expertise. We offer a range of features including online ordering, inventory management, customer relationship management, and analytics, all tailored to meet the unique needs of each individual business.At AsyncApps, we understand that every business is different, and we take the time to listen to our clients and understand their needs before creating a customized solution. We are committed to providing the highest quality service and support to our clients, and we work closely with them throughout the development process to ensure that their needs are met and their goals are achieved.Whether you are a small local business or a large enterprise, AsyncApps can help you make the transition from offline to online, with apps that are reliable, efficient, and easy to use. Contact us today to learn more about our services and how we can help your business thrive in the online marketplace."',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontSize: 15,
                        // fontWeight: FontWeight.bold,
                        color: Color(0xFF343434),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      onPressed: (){
                        _makePhoneCall("+917266983259");
                      },
                      child: Container(
                        height: 50,
                        width: 140,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFFFFA735)
                        ),
                        child: Text("Make a call",style: TextStyle(color: Col().main2nd,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    CupertinoButton(
                      onPressed: (){
                        _emailURL();
                      },
                      child: Container(
                        height: 50,
                        width: 140,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xFF37FF93)
                        ),
                        child: Text("Send a email",style: TextStyle(color: Col().main2nd,fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 320,
                  padding: EdgeInsets.only(top: 15,left: 15,right: 15),
                  decoration: BoxDecoration(
                    color: Color(0x76AAAAE5),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Ujala Yadav",
                            style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF343434),
                              ),
                            ),
                          ),
                          SizedBox(height: 3,),

                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
