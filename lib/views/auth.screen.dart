import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:werecycle/provider/bins.provider.dart';
import 'package:werecycle/utils/router.dart';
import 'package:werecycle/utils/theme_config.dart';
import 'package:werecycle/views/home.screen.dart';
import 'package:werecycle/views/main.screen.dart';
import 'package:werecycle/views/otp.screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;

  void _verifyPhoneNumber(String phoneNumber) async {
    String oldP = phoneNumber;
    phoneNumber = '+230$phoneNumber';
    setState(() {
      loading = !loading;
    });

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {
        print("Logged in through auto verify");
        GetStorage()..write("phoneNumber", oldP);
        MyRouter.pushPage(context, MainScreen());
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e);
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Verification failed.',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(milliseconds: 800),
        ));
      },
      codeSent: (String verificationId, int resendToken) {
        print("Code sent");
        MyRouter.pushPage(context, OTPScreen());
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Verification is taking too long. Please try again',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(milliseconds: 800),
        ));
      },
    );

    // setState(() {
    //   phoneController.text = "";
    //   loading = !loading;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text("Login"),
                    ),
                    Container(
                        constraints: const BoxConstraints(maxHeight: 340),
                        margin: const EdgeInsets.symmetric(horizontal: 32),
                        child: Image.asset("assets/images/login-image.png")),
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'We will send you a code ',
                            style: TextStyle(color: ThemeConfig.lightPrimary)),
                        TextSpan(
                            text: 'on this mobile number',
                            style: TextStyle(color: ThemeConfig.lightPrimary)),
                      ]),
                    )),
                Container(
                  height: 40,
                  constraints: const BoxConstraints(maxWidth: 500),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "5 895 1245",
                        isDense: true,
                      ),
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      maxLines: 1,
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: RaisedButton(
                    onPressed: () {
                      if (phoneController.text.isNotEmpty) {
                        // TODO: Add +230 if missing
                        _verifyPhoneNumber(
                          phoneController.text.toString().trim(),
                        );
                      } else {
                        // TODO: use regex to catch invalid number
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            'Please enter a phone number',
                            style: TextStyle(color: Colors.white),
                          ),
                          duration: Duration(milliseconds: 800),
                        ));
                      }
                    },
                    color: ThemeConfig.lightPrimary,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14))),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Next',
                            style: TextStyle(color: Colors.white),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              color: ThemeConfig.lightAccent,
                            ),
                            child: loading
                                ? SpinKitFadingCircle(
                                    color: Colors.white,
                                    size: 16.0,
                                  )
                                : Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 42,
                  child: FlatButton(
                    onPressed: () => MyRouter.pushPageReplacement(
                        context,
                        MultiProvider(
                          providers: [
                            ChangeNotifierProvider(
                                create: (context) => BinsProvider()),
                          ],
                          child: HomeScreen(showAppbar: true),
                        )),
                    child: Text(
                      "Skip Login",
                      style: TextStyle(
                        color: ThemeConfig.lightAccent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
