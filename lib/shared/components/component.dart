
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/module/login/login.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/remote/colors/colors.dart';

void navegateAndReplacement(context, Widget) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Widget,
        ), (route) {
      return false;
    });

void navegateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );

void signOut(context) => CacheHelper.removeData(key: 'token').then((value) {
      if (value) {
        navegateAndReplacement(context, LoginScreen());
      }
    });
Widget defaultFormField({
  required TextEditingController controller,
  TextInputType? type,
  ValueChanged? onSubmit,
  ValueChanged? onChange,
  GestureTapCallback? onTap,
  bool isPassword = false,
  FormFieldValidator<String>? validate,
  String? label,
  IconData? prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
  int maxLines = 1,
  InputBorder? border,
  int? indexLenght,
  String? hint,
  double? width,
  double? height,
  Color? labelTextColor,
  textColor = Colors.black,
  textAlign = TextAlign.start,
}) =>
    Container(
      width: width,
      height: height,
      child: TextFormField(
        textAlign: textAlign,
        inputFormatters: [
          LengthLimitingTextInputFormatter(indexLenght),
        ],
        maxLines: maxLines,
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap: onTap,
        style: TextStyle(
          color: textColor,
        ),
        validator: validate,
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
              TextStyle(color: labelTextColor, fontWeight: FontWeight.bold),
          hintText: hint,
          hintStyle: TextStyle(
            color: defaultColor,
          ),
          prefixIcon: Icon(
            prefix,
            color: defaultColor,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffix,
                  ),
                )
              : null,
          border: border,
        ),
      ),
    );

Widget defaultButton2({
  double width = double.infinity,
  Color background = Colors.red,
  bool isUpperCase = true,
  required VoidCallback? function,
  required String text,
  double? elevation = 18.0,
  Color? textColors = Colors.white,
  double? fontSize,
  double? iconSize,
  Color? iconColor,
  IconData? icon,
}) =>
    Container(
      width: width,
      //color: background,
      height: 40,
      child: Material(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        elevation: elevation!,
        color: background,
        //HexColor("F23B3F"),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        // Add This
        child: MaterialButton(
          onPressed: function,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: iconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                text,
                style: TextStyle(color: textColors, fontSize: fontSize),
              ),
            ],
          ),
        ),
      ),
    );

Widget defaultButton({
  double? width = double.infinity,
  Color? background = Colors.blueAccent,
  bool? isUpperCase = true,
  required VoidCallback? function,
  required String text,
  double? elevation = 18.0,
  Color? textColors = Colors.white,
  double? fontSize,
}) =>
    Container(
      width: width,
      //color: background,
      height: 40,
      child: Material(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        elevation: elevation!,
        color: background,
        //HexColor("F23B3F"),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        // Add This
        child: MaterialButton(
          onPressed: function,
          child: Text(
            isUpperCase! ? text.toUpperCase() : text,
            style: TextStyle(color: textColors, fontSize: fontSize),
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required VoidCallback function,
  required String text,
  Color? color,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        //text.toUpperCase(),
        text,
        style: TextStyle(color: color, fontSize: 17.0, fontFamily: 'Honey'),
      ),
    );
void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum لما يكون عندي كذا حاجه وبختار مبينهم
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

class BouncyPageRoute extends PageRouteBuilder {
  Widget? widget;

  BouncyPageRoute({this.widget})
      : super(
          transitionDuration: Duration(milliseconds: 1),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation,
              Widget child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.bounceIn);

            return ScaleTransition(
              //alignment:Alignment.lerp(Alignment.topRight, Alignment.bottomLeft, 2.0),
              scale: animation,
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secAnimation) {
            return widget!;
          },
        );
}



void PrintFullText(String text) {
  final Pattern = RegExp('.{1,800}'); //800 is the size of each chunk
  Pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Widget buildListProductSearch(model, context) => Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () {
          // HomeCubit.get(context).getProductDetails(productId: '${model.id}');
          // navegateTo(context, DishDetails());
        },
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(model.dishImage),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              width: 130.0,
              height: 130.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    model.dishName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:const TextStyle(
                      fontSize: 18.0,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        model.dishPrice.toString(),
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
