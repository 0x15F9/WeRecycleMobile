import 'package:flutter/material.dart';
import 'package:werecycle/utils/theme_config.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      // padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: InputDecoration(
                        hintText: "5 895 1245",
                        isDense: true,
                      ),
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      maxLines: 1,
                      // placeholder: '+33...',
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: RaisedButton(
                    onPressed: () {
                      // if (phoneController.text.isNotEmpty) {
                      //   loginStore.getCodeWithPhoneNumber(
                      //       context, phoneController.text.toString());
                      // } else {
                      //   loginStore.loginScaffoldKey.currentState
                      //       .showSnackBar(SnackBar(
                      //     behavior: SnackBarBehavior.floating,
                      //     backgroundColor: Colors.red,
                      //     content: Text(
                      //       'Please enter a phone number',
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ));
                      // }
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
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 16,
                            ),
                          )
                        ],
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
