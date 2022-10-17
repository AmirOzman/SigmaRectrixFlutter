// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sigma_crm/config/theme/theme.dart';
import 'package:sigma_crm/screen/landing/getting_started.dart/url_page.dart';
// import 'package:sigma_crm/screen/landing/getting_started.dart/page_1.dart';
import 'package:sigma_crm/screen/screen.dart';
import 'package:sigma_crm/widget/widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding>
    with SingleTickerProviderStateMixin {
  final pageController = PageController();
  // final urlController = TextEditingController();
  // late Uri uri =urlController.text.tryParse(value);
  late final AnimationController welcomeController;
  bool isLastPage = false;
  var pageIndex;

  @override
  void initState() {
    super.initState();
    welcomeController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
    welcomeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            //setState(() =>
            //(isLastPage = index == 2),
            //
            //);

            setState(() {
              pageIndex = index;
            });
          },
          children: [
            // Page1(welcomeController),
            Container(
              child: Center(
                  child: Column(
                children: [
                  SpacingVertical(80),
                  Lottie.asset(
                    'assets/welcome.json',
                    controller: welcomeController,
                    // onLoaded: (composition) {
                    //   welcomeController.forward();
                    // },
                  ),
                  Text(
                    'Welcome\nto\nOdoo\nCRM app',
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                          color: COLOR_1,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
            ),
            Container(
              child: Center(
                  child: Text(
                'Customer Relation Management\nmade\nEasy',
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              )),
            ),
            //Container(
            //  child: Padding(
            //    padding: EdgeInsets.all(20.0),
            //    child: Center(
            //       child: Column(
            //      children: [
            //        SpacingVertical(300),
            //        Text(
            //          "Please enter your company's Odoo URL",
            //          style: Theme.of(context).textTheme.headline3,
            //        ),
            //        SpacingVertical(20),
            //        TextForm(
            //          controller: urlController,
            //          label: "Company's URL", kb: TextInputType.url,
            //          validation
            //           validator: if,
            //        ),
            //      ],
            //    )),
            //  ),
            //),
          ],
        ),
      ),
      bottomSheet:

          //isLastPage
          //   ? TextButton(
          //       child: const Text('Get Started'),
          //       style: TextButton.styleFrom(
          //          shape: RoundedRectangleBorder(
          //            borderRadius: BorderRadius.only(
          //              topLeft: Radius.elliptical(10, 5),
          //              topRight: Radius.elliptical(10, 5),
          //            ),
          //          ),
          //          primary: Colors.white,
          //          backgroundColor: Colors.black,
          //           backgroundColor: COLOR_2,
          //           minimumSize: const Size.fromHeight(80)),
          //      onPressed: () async {
          //       Navigator.of(context).pushReplacement(
          //            MaterialPageRoute(builder: (context) => LoginScreen(urlController)));
          //      },
          //    ) :
          Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        height: 80,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          TextButton(
            child: Text(''),
            onPressed: () {},
          ),
          Center(
            child: SmoothPageIndicator(
              controller: pageController,
              count: 3,
              onDotClicked: (index) => pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn),
              effect: WormEffect(
                  spacing: 16,
                  activeDotColor: COLOR_2,
                  dotColor: Colors.black26),
            ),
          ),
          TextButton(
              child: Text('Next'),
              onPressed: () {
                if (pageIndex ==
                    1) // 1 is our index for last page because the third page is actually a new screen.
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Urlpage()),
                  );
                } else
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
              })
        ]),
      ),
    );
  }
}
