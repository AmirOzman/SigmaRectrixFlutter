// ignore_for_file: unnecessary_import, must_be_immutable, unused_local_variable, unused_catch_clause

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sigma_crm/screen/landing/getting_started.dart/url_page.dart';
import 'package:sigma_crm/screen/screen.dart';
import 'package:sigma_crm/widget/widget.dart';

class LoginScreen extends StatefulWidget {
  var urlController;
  LoginScreen(this.urlController, {Key? key}) : super(key: key);

  //const LoginScreen(TextEditingController urlController, {Key? key, this.urlController}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _isHidden = true;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  late AnimationController controller;
  //bottomsheet change url

  //change URL of company's Odoo
  Future changeURL() => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      /*
                      Expanded(
                          child: TextField(
                              controller: TextEditingController(
                                text: widget.urlController.text,
                                
                              ),
                              onChanged: (text) => {
                                  widget.urlController = this.widget.urlController
                              }
                              
                              //widget.urlController, label: "Odoo's Url eg: "http://sigmarectrix.com" ",            
                              //initialValue: 'hjhgjhg'//widget.urlController.text,
                              )),
                              */
                      Expanded(
                          child: ButtonText(
                              nama: 'Change',
                              lebar: double.infinity,
                              onPressed: () {
                                //setState(() {
                                //  widget.urlController = this.widget.urlController;
                                //});

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Urlpage(),
                                  ),
                                );
                              }))
                    ]),
              ),
            ),
          );
        },
      );

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    controller.dispose();

    super.dispose();
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue[50],
          resizeToAvoidBottomInset: false,
          body: isLoading
              ? Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: CircularProgressIndicator.adaptive(
                    value: controller.value,
                    semanticsLabel: 'Linear progress indicator',
                    // color: Colors.orange,
                    strokeWidth: 10,
                  )),
                )
              : GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: SingleChildScrollView(
                    child: Center(
                      child: PaddingCustom(
                        h: 0.025,
                        w: 0.05,
                        child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.all(screenSize.height * 0.025),
                                  child: AutofillGroup(
                                    child: Form(
                                      key: formKey,
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            screenSize.height * 0.025),
                                        child: Column(
                                          children: [
                                            const SpacingAll(h: 0.05, w: 1),
                                            Image.asset(
                                              'images/logo-sigma-transparent.png',
                                              width: 600,
                                              height: 200,
                                            ),
                                            const SpacingAll(h: 0.05, w: 1),
                                            //EmailField(email: _email),
                                            EmailField(email: _email),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            passwordField(),
                                            SizedBox(height: 10),
                                            Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: RichText(
                                                    text: TextSpan(
                                                        text: 'change URL',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .blueAccent,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap = () {
                                                                changeURL();
                                                              }))),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            ButtonText(
                                                nama: "Login",
                                                lebar: screenSize.width * 0.25,
                                                onPressed: () async {
                                                  try {
                                                    //var baseURL = widget
                                                    //.urlController.text;
                                                    var baseURL =
                                                        'http://10.0.0.208:8069';
                                                    //10.0.0.208

                                                    ///Odoo 15
                                                    // 'https://senanglah.com/';
                                                    'http://localhost:8069';
                                                    // Authenticate to server with db name and credentials
                                                    var client = OdooClient(
                                                        //widget
                                                        //   .urlController.text
                                                        'http://10.0.0.208:8069'
                                                        //10.0.0.208

                                                        ///Odoo 15
                                                        // 'https://senanglah.com/',
                                                        // 'http://192.168.1.9:8069', //IP wifi rumah

                                                        // http://10.0.0.190:8069 IP dalam network sigma
                                                        // 'http://192.168.5.207:8069', //IP dalam hotspot phone
                                                        // 'http://127.0.0.1',
                                                        );

                                                    final session = await client
                                                        .authenticate(
                                                            'amir',
                                                            'amiruddinozman@gmail.com',
                                                            //_email.text,
                                                            'Khaiozman123');
                                                    // 'myerpsigma',
                                                    //.text,
                                                    //_password.text);

                                                    setState(() {
                                                      isLoading = true;
                                                    });

                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .removeCurrentMaterialBanner();

                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ScreenView(
                                                          client,
                                                          session,
                                                          // baseURL: baseURL,
                                                          // userImage: userAvatar,
                                                        ),
                                                      ),

                                                      // HomeScreen(
                                                      //     client, session)),
                                                      // SalesLeadForm(
                                                      //     client, session)),
                                                      (Route<dynamic> route) =>
                                                          false,
                                                    );
                                                    // Navigator.of(context).pushAndRemoveUntil(ScreenView(client,session), (route) => false);

                                                  } on OdooException catch (e) {
                                                    // Cleanup on odoo exception

                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .hideCurrentMaterialBanner();

                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showMaterialBanner(
                                                            MaterialBanner(
                                                      backgroundColor:
                                                          Colors.yellow,
                                                      content: const Text(
                                                        "Invalid Email or Password",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .hideCurrentMaterialBanner();
                                                            },
                                                            child: const Text(
                                                                "DISMISS"))
                                                      ],
                                                    ));
                                                  }
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  TextFormField passwordField() {
    return TextFormField(
      onChanged: (text) {
        if (text.isEmpty) {
          "Please Enter Your Password";
        }
      },
      autofillHints: const [AutofillHints.password],
      controller: _password,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          labelText: "Password",
          hintText: "Password",
          hintStyle: const TextStyle(color: Colors.red),
          suffixIcon: GestureDetector(
            onTap: _togglePasswordView,
            child: Icon(_isHidden ? Icons.visibility : Icons.visibility_off),
          ),
          prefixIcon: const Align(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: Icon(Icons.password),
          )),
      obscureText: _isHidden,
    );
  }
}
