import 'package:earnily/intro/page1.dart';
import 'package:earnily/intro/page3.dart';
import 'package:earnily/pages/main_page.dart';
import 'package:earnily/screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'intro/page2.dart';

class onbording extends StatefulWidget {
  const onbording({super.key});

  @override
  State<onbording> createState() => _onbordingState();
}

class _onbordingState extends State<onbording> {
  PageController _controller = PageController();

  bool last = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (value) {
            setState(() {
              last = (value == 2);
            });
          },
          children: [
            page1(),
            page2(),
            page3(),
          ],
        ),
        Container(
          alignment: Alignment(0, 0.65),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  _controller.jumpToPage(2);
                },
                child: Text(
                  'تخطى',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: ExpandingDotsEffect(
                    // spacing: 8.0,
                    //  radius: 4.0,
                    dotWidth: 24.0,
                    dotHeight: 24.0,
                    // paintStyle: PaintingStyle.stroke,
                    // strokeWidth: 1.5,
                    dotColor: Colors.grey,
                    activeDotColor: Colors.deepPurple),
              ),
              last
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const SignInScreen();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'انتهى',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      child: Text(
                        'التالي',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
            ],
          ),
        ),
      ],
    ));
  }
}
