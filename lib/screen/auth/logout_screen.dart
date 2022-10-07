import 'package:flutter/material.dart';
import 'package:sigma_crm/screen/screen.dart';
import 'package:sigma_crm/widget/widget.dart';

class LogOutScreen extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  const LogOutScreen(this.client, this.session, {Key? key}) : super(key: key);

  @override
  State<LogOutScreen> createState() => _LogOutScreenState();
}

class _LogOutScreenState extends State<LogOutScreen> {
  late final OdooLoginEvent odooLog;

  @override
  Widget build(BuildContext context) {
    final urlController = TextEditingController();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarCustom(
              client: widget.client,
              session: widget.session,
              tajuk: Text(
                'Logged Out',
                style: Theme.of(context).textTheme.headline4,
              ),
              float: true,
              log: false,
              find: false),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SpacingPixel(
                        h: 250,
                      ),
                      Text(
                        "You have been logged out",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SpacingAll(h: 0.07, w: 1),
                      ButtonText(
                          nama: "Go back to Login",
                          lebar: 0.70,
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen(urlController)),
                              (Route<dynamic> route) => false,
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
