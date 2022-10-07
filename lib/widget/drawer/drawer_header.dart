import 'package:flutter/material.dart';
import 'package:sigma_crm/config/theme/theme.dart';

class DrawerHead extends StatelessWidget {
  const DrawerHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // height: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
                colors: [
                  COLOR_4,
                  COLOR_5,
                ],
              ),
              // color: Colors.orange.shade400,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            child: Image.asset('images/logo-sigma-transparent.png'),
          ),
          // const Text('Sigma Rectrix')
        ],
      ),
    );
  }
}
