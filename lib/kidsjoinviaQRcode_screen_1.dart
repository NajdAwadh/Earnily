// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'export.dart';

class KidsjoinviaQRcode_screen_1 extends StatefulWidget {
  const KidsjoinviaQRcode_screen_1({Key? key}) : super(key: key);

  @override
  _KidsjoinviaQRcode_screen_1State createState() =>
      _KidsjoinviaQRcode_screen_1State();
}

class _KidsjoinviaQRcode_screen_1State
    extends State<KidsjoinviaQRcode_screen_1> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double widthScale = width / 390;
    double heightScale = height / 844;

    return Scaffold(
      backgroundColor: FvColors.screen1Background,
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Stack(children: [
                const SizedBox(height: 844, width: 390),

//-- Component HelloRectangleContainer --//
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 390,
                    height: 298,
                    decoration: const BoxDecoration(
                      color: FvColors.container4Background,
                      //borderRadius: BorderRadius.circular(56),
                    ),
                    child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
//-- Component Rectangle_Container_5 --//
                          Positioned(
                            child: Container(
                              width: 390 * widthScale,
                              height: 298 * heightScale,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(56),
                              ),
                            ),
                          ),

//-- End Rectangle_Container_5 --//
//-- Component profile_Container_7 --//
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 390,
                              height: 207,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(250, 243, 126, 126),
                                borderRadius: BorderRadius.circular(37),
                              ),
                            ),
                          ),

//-- End profile_Container_7 --//
                        ]),
                  ),
                ),

//-- Component profile_ImageView_17 --//
                Positioned(
                  left: 276,
                  top: 14,
                  child: SizedBox(
                    width: 85,
                    height: 85,
                    child: Image.asset("assets/profile_ImageView_17-85x85.png"),
                  ),
                ),
//-- End profile_ImageView_17 --//
//-- Component HelloTextView --//
                const Positioned(
                    left: 181,
                    top: 108,
                    child: Text(
                      "اهلاً",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w400,
                          //backgroundColor: Color.fromARGB(250, 243, 126, 126),
                          color: FvColors.textview24FontColor,
                          wordSpacing: 1.0),
                    )),
//-- End HelloTextView --//
//-- Component ScanQRTextView --//
                const Positioned(
                    left: 50,
                    top: 215,
                    child: Text(
                      "أمسح الباركود للإنضمام إلى العائلة",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: FvColors.textview24FontColor,
                          wordSpacing: 1.0),
                    )),
//-- End ScanQRTextView --//
//-- Component qrcode_ImageView_20 --//
                Positioned(
                  left: 37,
                  top: 297,
                  child: SizedBox(
                    width: 330,
                    height: 330,
                    child:
                        Image.asset("assets/qrcode_ImageView_20-330x330.png"),
                  ),
                ),
//-- End qrcode_ImageView_20 --//

//-- End HelloRectangleContainer --//
/*
//-- Component Bottom --//
                Positioned(
                  left: 0,
                  top: 761,
                  child: Container(
                    width: 390,
                    height: 83,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(206, 217, 217, 217),
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),

//-- End Bottom --//

//-- Component homebutton_ImageView_10 --//
                Positioned(
                  left: 155,
                  top: 740,
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child:
                        Image.asset("assets/homebutton_ImageView_11-80x80.png"),
                  ),
                ),
//-- End homebutton_ImageView_10 --//
//-- Component award_ImageView_11 --//
                Positioned(
                  left: 311,
                  top: 761,
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Image.asset("assets/award_ImageView_13-60x60.png"),
                  ),
                ),
//-- End award_ImageView_11 --//
//-- Component Ellipse_Container_12 --//
                Positioned(
                  left: 20,
                  top: 760,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),

//-- End Ellipse_Container_12 --//
//-- Component iconsfavorite_ImageView_13 --//
                Positioned(
                  left: 20,
                  top: 767,
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Image.asset(
                        "assets/iconsfavorite_ImageView_13-60x60.png"),
                  ),
                ),
//-- End iconsfavorite_ImageView_13 --//
//-- Component Wishlist_TextView_14 --//
                const Positioned(
                    left: 0,
                    top: 824,
                    child: Text(
                      "Wishlist",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: FvColors.textview24FontColor,
                          wordSpacing: 1.0),
                    )),
//-- End Wishlist_TextView_14 --//
//-- Component Home_TextView_15 --//
                const Positioned(
                    left: 157,
                    top: 823,
                    child: Text(
                      "Home",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: FvColors.textview24FontColor,
                          wordSpacing: 1.0),
                    )),
//-- End Home_TextView_15 --//
//-- Component Rewards_TextView_16 --//
                const Positioned(
                    left: 316,
                    top: 824,
                    child: Text(
                      "Rewards",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: FvColors.textview24FontColor,
                          wordSpacing: 1.0),
                    )),
//-- End Rewards_TextView_16 --//
*/
              ]),
            ),
//-- Component ScrollContainer --//
//-- End ScrollContainer --//
          ],
        ),
      ),
    );
  }
}
