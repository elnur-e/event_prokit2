import 'package:event_prokit/utils/EAapp_widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:event_prokit/screens/EASignInScreen.dart';
import 'package:event_prokit/screens/EASignUpScreen.dart';
import 'package:event_prokit/screens/EAWalkThroughScreen.dart'; // EAWalkThroughScreen ekranını ekleyin

class EAControllScreen extends StatefulWidget {
  @override
  EAControllScreenState createState() => EAControllScreenState();
}

class EAControllScreenState extends State<EAControllScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setStatusBarColor(Colors.transparent);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              commonCachedNetworkImage(
                "https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.2.jpg",
                fit: BoxFit.cover,
                height: context.height(),
                width: context.width(),
              ),
              Container(
                width: context.width(),
                height: context.height(),
                color: Colors.black26,
              ),
              Column(
                children: [
                  Text('Event', style: boldTextStyle(color: white, size: 30)),
                  16.height,
                  Text('EVENT', style: primaryTextStyle(color: white), textAlign: TextAlign.center),
                  16.height,
                  button(
                    textColor: white,
                    width: context.width(),
                    context: context,
                    text: 'Get Started',
                    onTap: () {
                      finish(context);
                      SHSigUPScreen().launch(context);
                    },
                  ),
                  16.height,
                  AppButton(
                    color: context.cardColor,
                    text: 'Sign In',
                    textStyle: boldTextStyle(),
                    width: context.width(),
                    shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    onTap: () {
                      finish(context);
                      SHSignInScreen().launch(context).then((value) {
                        if (value) {
                          EAWalkThroughScreen().launch(context); // Giriş başarılıysa EAWalkThroughScreen ekranını aç
                        }
                      });
                    },
                  ),
                ],
              ).paddingSymmetric(vertical: 16, horizontal: 16)
            ],
          ),
        ],
      ),
    );
  }
}
