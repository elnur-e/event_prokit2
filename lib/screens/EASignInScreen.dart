import 'package:event_prokit/screens/EADashedBoardScreen.dart';
import 'package:event_prokit/screens/EASignUpScreen.dart';
import 'package:event_prokit/utils/EAColors.dart';
import 'package:event_prokit/utils/EAapp_widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class SHSignInScreen extends StatefulWidget {
  @override
  SHSignInScreenState createState() => SHSignInScreenState();
}

bool isLoggedIn = false; // Oturum durumu değişkeni
List<String> currentUser = []; // currentUser'ı bir liste olarak tanımlayın

class SHSignInScreenState extends State<SHSignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn(String email, String password) async {
    // E-posta ve şifre alanlarının dolu olup olmadığını kontrol et
    if (email.isEmpty || password.isEmpty) {
      toast('Please fill all fields');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Supabase üzerinde kullanıcı girişini kontrol et
      final response = await Supabase.instance.client
          .from('user')
          .select('email, password, name, city') // Ek bilgileri de getirin
          .eq('email', email)
          .eq('password', password)
          .select();

      // Yanıt alındı ve hata yoksa
      if (response.isEmpty) {
        // Yanıtta veri yoksa, yani kullanıcı yanlış bilgileri girdiyse veya hata oluştuysa
        toast('Invalid email or password');
      } else {
        // Yanıtta veri varsa, yani kullanıcı doğru bilgileri girdiyse
        isLoggedIn = true; // Oturum açıldı

        // Kullanıcı bilgilerini alın
        setState(() {
          currentUser = [
            response[0]['name'],
          ]; // Oturum açıldığında kullanıcı bilgilerini sakla
        });

        toast('Sign in successful');
        // Ana ekrana yönlendir
        EADashedBoardScreen().launch(context);
      }
    } catch (e) {
      // Beklenmeyen bir hata oluşursa
      toast('An error occurred. Please try again');
    } finally {
      setState(() {
        isLoading = false;
      });
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
                height: context.height() * 0.7,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Welcome\nBack',
                              style: boldTextStyle(color: white, size: 25)),
                          Container(
                            height: 78,
                            width: 75,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: grey),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: commonCachedNetworkImage(
                                'https://i.dlpng.com/static/png/6981952_preview.png',
                                fit: BoxFit.cover,
                                height: 45,
                                width: 45),
                          )
                        ],
                      ),
                      16.height,
                      AppTextField(
                        controller: emailController,
                        textStyle: primaryTextStyle(color: white),
                        cursorColor: white,
                        textFieldType: TextFieldType.EMAIL,
                        decoration: buildSHInputDecoration('Email',
                            textColor: Colors.grey),
                      ),
                      16.height,
                      AppTextField(
                        controller: passwordController,
                        textStyle: primaryTextStyle(color: white),
                        cursorColor: white,
                        textFieldType: TextFieldType.PASSWORD,
                        suffixIconColor: white,
                        suffix:
                            Icon(Icons.remove_red_eye_rounded, color: white),
                        decoration: buildSHInputDecoration('Password',
                            textColor: Colors.grey),
                      ),
                      16.height,
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text('Forgot Password?',
                                style: boldTextStyle(color: white),
                                textAlign: TextAlign.end)
                            .onTap(
                          () {
                          },
                        ),
                      ),
                      80.height,
                      isLoading
                          ? CircularProgressIndicator(color: white)
                          : button(
                              context: context,
                              textColor: white,
                              width: context.width(),
                              text: 'Sign In',
                              onTap: () => signIn(emailController.text,
                                  passwordController.text),
                            ),
                      32.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have account?',
                              style: primaryTextStyle(color: grey)),
                          4.width,
                          Text('Get Started',
                                  style: boldTextStyle(color: white, size: 16))
                              .onTap(
                            () {
                              finish(context);
                              SHSigUPScreen().launch(context);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
