import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sigma_crm/widget/widget.dart';

class Page1 extends StatelessWidget {
  final AnimationController controller;
  const Page1(
    this.controller, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            SpacingVertical(40),
            Lottie.asset(
              'assets/welcome.json',
              controller: controller,
              // onLoaded: (composition) {
              //   welcomeController.forward();
              // },
            ),
            Text(
              'Welcome to Odoo CRM app',
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        ),
      ),
    );
  }
}
