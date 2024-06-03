import 'package:event_prokit/screens/EASignInScreen.dart';
import 'package:event_prokit/utils/EAapp_widgets.dart';
import 'package:event_prokit/utils/supabaseConnect.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:event_prokit/utils/EAColors.dart';

class SHSigUPScreen extends StatefulWidget {
  @override
  SHSigUPScreenState createState() => SHSigUPScreenState();
}

class SHSigUPScreenState extends State<SHSigUPScreen> {
  /**************************/
  //TODO
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cityController = TextEditingController();

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
    /**************************/
    //TODO
    _emailController.dispose();
    _firstNameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  /**************************/
  //TODO
  Future<void> _register() async {
    final email = _emailController.text;
    final firstName = _firstNameController.text;
    final password = _passwordController.text;

    if (email.isNotEmpty &&
        firstName.isNotEmpty &&
        password.isNotEmpty != null) {
      try {
        await SupabaseService.addUser(email, firstName, password);
        SHSignInScreen().launch(context);
        toast('Sign Up Succesfully , please sign in');
      } catch (error) {
        toast('Registration failed: $error');
      }
    } else {
      toast('Please fill all fields correctly');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            commonCachedNetworkImage(
              'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.9.jpg',
              fit: BoxFit.fill,
              height: context.height(),
              width: context.width(),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: appSecondaryBackgroundColor,
                ),
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                width: context.width(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('New\nAccount',
                            style: boldTextStyle(color: white, size: 25)),
                        Container(
                          height: 80,
                          width: 80,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: grey),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.camera_alt_outlined, color: grey),
                              8.height,
                              Text('Upload',
                                  style: secondaryTextStyle(color: grey)),
                            ],
                          ),
                        )
                      ],
                    ),
                    16.height,
                    AppTextField(
                      //TODO
                      controller: _emailController,
                      textStyle: primaryTextStyle(color: white),
                      cursorColor: white,
                      textFieldType: TextFieldType.EMAIL,
                      decoration: buildSHInputDecoration('Email',
                          textColor: Colors.grey),
                    ),
                    16.height,
                    AppTextField(
                      //TODO
                      controller: _firstNameController,
                      textStyle: primaryTextStyle(color: white),
                      cursorColor: white,
                      textFieldType: TextFieldType.OTHER,
                      decoration: buildSHInputDecoration('First Name',
                          textColor: Colors.grey),
                    ),
                    16.height,
                    AppTextField(
                      //TODO
                      controller: _passwordController,
                      textStyle: primaryTextStyle(color: white),
                      cursorColor: white,
                      textFieldType: TextFieldType.PASSWORD,
                      suffixIconColor: white,
                      suffix: Icon(Icons.remove_red_eye_rounded, color: white),
                      decoration: buildSHInputDecoration('Password',
                          textColor: Colors.grey),
                    ),
                    16.height,
                    /***************** */
                    //TODO

                  
                    /************ */

                    RichTextWidget(
                      list: [
                        TextSpan(
                          text: 'You have agreed to our ',
                          style: secondaryTextStyle(color: grey, size: 14),
                        ),
                        TextSpan(
                            text: 'Terms of Services\n',
                            style: boldTextStyle(color: white, size: 12)),
                        TextSpan(
                          text: 'when connection to sign up.',
                          style: secondaryTextStyle(color: grey, size: 14),
                        ),
                      ],
                    ),
                    32.height,
                    button(
                        context: context,
                        textColor: white,
                        width: context.width(),
                        text: 'Get Started',
                        //TODO
                        onTap: _register
                      /* onTap: () {
                          SHDashBoardScreen().launch(context);
                        }*/
                        ),
                    32.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?',
                            style: primaryTextStyle(color: grey)),
                        4.width,
                        Text('Sign In', style: primaryTextStyle(color: white))
                            .onTap(
                          () {
                            finish(context);
                            SHSignInScreen().launch(context);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
