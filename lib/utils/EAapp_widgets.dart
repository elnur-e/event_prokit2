import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_prokit/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:event_prokit/model/EAForYouModel.dart';

import 'EAColors.dart';

AppBar getAppBar(String title, {List<Widget>? actions, PreferredSizeWidget? bottom, bool? center, Widget? titleWidget, double? elevation, Widget? backWidget}) {
  return AppBar(
    title: titleWidget ?? Text(title, style: boldTextStyle(color: whiteColor, size: 18)),
    flexibleSpace: AppBarGradientWidget(),
    actions: actions,
    centerTitle: center,
    leading: backWidget,
    bottom: bottom,
    automaticallyImplyLeading: false,
    elevation: elevation,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  );
}

Widget commonCachedNetworkImage(
  String? url, {
  double? height,
  double? width,
  BoxFit? fit,
  AlignmentGeometry? alignment,
  bool usePlaceholderIfUrlEmpty = true,
  double? radius,
  Color? color,
}) {
  if (url!.validate().isEmpty) {
    return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
  } else if (url.validate().startsWith('http')) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: fit,
      color: color,
      alignment: alignment as Alignment? ?? Alignment.center,
      errorWidget: (_, s, d) {
        return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
      },
      placeholder: (_, s) {
        if (!usePlaceholderIfUrlEmpty) return SizedBox();
        return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
      },
    );
  } else {
    return Image.asset(url, height: height, width: width, fit: fit, alignment: alignment ?? Alignment.center).cornerRadiusWithClipRRect(radius ?? defaultRadius);
  }
}

Widget placeHolderWidget({double? height, double? width, BoxFit? fit, AlignmentGeometry? alignment, double? radius}) {
  return Image.asset('images/placeholder.jpg', height: height, width: width, fit: fit ?? BoxFit.cover, alignment: alignment ?? Alignment.center).cornerRadiusWithClipRRect(radius ?? defaultRadius);
}

class AppBarGradientWidget extends StatelessWidget {
  final Widget? child;

  AppBarGradientWidget({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor1,
            primaryColor2,
          ],
        ),
      ),
      child: child,
    );
  }
}

Widget commonButton({double? width, String? btnText}) {
  return Container(
    width: width,
    height: 50,
    alignment: Alignment.center,
    padding: EdgeInsets.all(8),
    decoration: boxDecorationRoundedWithShadow(
      24,
      gradient: LinearGradient(
        colors: [
          primaryColor1,
          primaryColor2,
        ],
      ),
    ),
    child: Text(btnText!.toUpperCase(), style: boldTextStyle(color: white), textAlign: TextAlign.center),
  );
}

class ChatMessageWidget1 extends StatelessWidget {
  const ChatMessageWidget1({
    Key? key,
    required this.isMe,
    required this.data,
  }) : super(key: key);

  final bool isMe;
  final EAMessageModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isMe.validate() ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          margin: isMe.validate() ? EdgeInsets.only(top: 3.0, bottom: 3.0, right: 0, left: (500 * 0.25).toDouble()) : EdgeInsets.only(top: 4.0, bottom: 4.0, left: 0, right: (500 * 0.25).toDouble()),
          decoration: BoxDecoration(
            color: !isMe
                ? primaryColor1
                : appStore.isDarkModeOn
                    ? cardDarkColor
                    : white,
            boxShadow: defaultBoxShadow(),
            borderRadius: isMe.validate()
                ? BorderRadius.only(bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10))
                : BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10), topRight: Radius.circular(10)),
            border: Border.all(color: isMe ? Theme.of(context).dividerColor : Colors.transparent),
          ),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: Text(data.msg!,
                      style: primaryTextStyle(
                          color: !isMe
                              ? white
                              : appStore.isDarkModeOn
                                  ? gray
                                  : textPrimaryColor))),
              Text(data.time!, style: secondaryTextStyle(color: !isMe ? white : textSecondaryColor, size: 12))
            ],
          ),
        ),
      ],
    );
  }
}

class CustomTheme extends StatelessWidget {
  final Widget? child;

  CustomTheme({required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appStore.isDarkModeOn
          ? ThemeData.dark().copyWith(
              hintColor: appColorPrimary,
              colorScheme: ColorScheme.fromSwatch(backgroundColor: context.scaffoldBackgroundColor),
            )
          : ThemeData.light(),
      child: child!,
    );
  }
}
InputDecoration buildSHInputDecoration(String name, {Widget? prefixIcon, Widget? suffixIcon, Color? textColor,}) {
  return InputDecoration(
    contentPadding: EdgeInsets.only(left: 16),
    prefixIcon: prefixIcon,
    hintText: name,
    hintStyle: secondaryTextStyle(color: textColor),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0), borderSide: BorderSide(color: grey, width: 0.5)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0), borderSide: BorderSide(color: grey, width: 0.5)),
  );
}

Widget button({double? width, String? text, Color? textColor, Function? onTap, required BuildContext context}) {
  return Container(
    width: context.width(),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      //color: SHSecondaryColor
      gradient: LinearGradient(
        colors: [primaryColor1, primaryColor1],
        begin: FractionalOffset.topLeft,
        end: FractionalOffset.centerRight,
      ),
    ),
    child: TextButton(
      child: Text(
        text!,
        style: boldTextStyle(color: textColor),
      ),
      onPressed: onTap as void Function()?,
    ),
  );
}
