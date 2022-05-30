import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


Widget myDividor({required Color color}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 2,
      color: color,
    ),
  );
}

void navigateAndFinish({required context, required widget}) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget), (route) => false);
}

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return widget;
  }));
}

void showToast({
  required String msg,
  Color color = Colors.white,
  Color textColor = Colors.black,

}){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: textColor,
      fontSize: 16.0
  );
}

Widget emailFormField(context, emailController) {
  return TextFormField(
    controller: emailController,
    keyboardType: TextInputType.emailAddress,
    validator: (String? value) {
      if (value!.isEmpty) {
        return "You Must Enter Your Email Address";
      }
    },
    decoration: InputDecoration(
        label: const Text(
          "Email Address",
        ),
        prefixIcon: const Icon(
          Icons.email,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Colors.black,
            )),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: Colors.black))),
  );
}


Widget textFormField({
  required TextEditingController controller,
  bool isPassword = false,
  String validation = "",
  required String label,
  required TextInputType type,
  required IconData prefixIcon,
  IconData? suffixIcon,
  void Function()? fun,
  double borderRadius = 5.0,
  Color borderColor = Colors.black,
  void Function()? onTap

}){
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    validator: (String? value) {
      if (value!.isEmpty) {
        return validation;
      }
    },
    onTap: onTap,
    decoration: InputDecoration(
        label: Text(
          label,
        ),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(
          onPressed:  fun,
          icon: Icon(suffixIcon==null?suffixIcon = null: suffixIcon = suffixIcon),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor))),
  );
}

Widget defaultButton({
  double width = double.infinity,
  double height = 55,
  Color backgroundColor = Colors.blue,
  double borderRadius = 5.0,
  String? text,
  bool isUpperCase = false,
  Color? TextColor,
  required fun,
}) {
  return Container(
    width: width,
    height: height,
    child: MaterialButton(
      onPressed: fun,
      child: Text(
        isUpperCase ? text!.toUpperCase() : text!,
        style: TextStyle(
          color: TextColor,
          fontSize: 15,
        ),
      ),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      color: backgroundColor,
    ),
  );
}

Widget defaultTextButton(
    {required String text,
      required fun,
      double fontSize = 14,
      FontWeight weight = FontWeight.w300}) {
  return TextButton(
      onPressed: fun,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: weight,
        ),
      ));
}


void printFullText(String? text){
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text!).forEach((element)=> print(element.group(0)));
}

Widget buttonBuilder({
  required fun,
  Color color = Colors.blue,
  double height = 50,
  double width = double.infinity,
  double elevation = 10,
  required String text,
  bool isUpper = false,
  Color textColor = Colors.white,

}){
  return MaterialButton(
    elevation: elevation,
    color: color,
    height: height,
    minWidth: width,
    onPressed: fun,
    child: Text(isUpper?text.toUpperCase():text,
      style: TextStyle(
          color: textColor
      ),),
  );

}

