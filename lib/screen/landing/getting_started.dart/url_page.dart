import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sigma_crm/config/theme/theme.dart';
// import 'package:sigma_crm/screen/landing/getting_started.dart/page_1.dart';
import 'package:sigma_crm/screen/screen.dart';
import 'package:sigma_crm/widget/widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Urlpage extends StatefulWidget {
  const Urlpage({Key? key}) : super(key: key);
  @override
  State<Urlpage> createState() => UrlpageState();
}

class UrlpageState extends State<Urlpage> {
  final urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var urlController;
    var isLastPage;
    return Scaffold(
        backgroundColor: Colors.blue[50],
        resizeToAvoidBottomInset: false,
        bottomSheet: TextButton(
          child: const Text('Get Started'),
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(10, 5),
                  topRight: Radius.elliptical(10, 5),
                ),
              ),
              primary: Colors.white,
              backgroundColor: Colors.black,
              // backgroundColor: COLOR_2,
              minimumSize: const Size.fromHeight(80)),
          onPressed: () async {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginScreen(urlController)));
          },
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
                child: Column(
              children: [
                SpacingVertical(300),
                Text(
                  "Please enter your company's Odoo URL",
                  style: Theme.of(context).textTheme.headline3,
                ),
                SpacingVertical(20),
                TextFormField(
                    controller: urlController,
                    autofillHints: urlController,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      labelText: "Company's URL",
                    )
                    //validation
                    // validator: if,
                    ),
              ],
            )),
          ),
        ));
  }
}
