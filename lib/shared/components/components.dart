import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context,widget)=> Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context)=>widget
    )
);

void navigateAndFinish(context,widget)=> Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => widget,
    ),
  (route) => false,
);


Widget defaultFormField({
    @required TextEditingController controller,
    @required TextInputType inputType,
    @required String labelText,
    @required IconData prefixIcon,
    bool readOnly = false,
    IconData suffixIcon,
    Function onChange,
    Function onSubmit,
    Function onTap,
    @required Function validation,
    bool obscureText = false,
    Function suffixFunction,

}) =>
    TextFormField(
        controller: controller,
        keyboardType: inputType,
        obscureText: obscureText,
        decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(),
            prefixIcon: Icon(prefixIcon),
            suffixIcon: suffixIcon !=null
                ? IconButton(
                onPressed: suffixFunction,
                icon: Icon(suffixIcon))
                : null,
        ),
        onChanged: onChange,
        onFieldSubmitted: onSubmit,
        onTap: onTap,
        readOnly: readOnly,
        validator: validation,
    );

Widget defaultButton({
  double width = double.infinity,
  double height = 40.0,
  Color backgroundColor = Colors.blue,
  Color textColor = Colors.white,
  bool isUpperCase = true,
  double radius = 0.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            radius
        ),
        color: backgroundColor,

      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 25.0
          ),
        ),
      ),
    );

Widget defaultTextButton({
  @required Function onPressed,
  @required String text,
}) => TextButton(
  onPressed: onPressed,
  child: Text(
    text.toUpperCase()),
);

void showToast({
  @required String msg,
  @required ToastState state,
})=> Fluttertoast.showToast(
  msg: msg,
  fontSize: 15.0,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  textColor: Colors.white,
  backgroundColor:toastColor(state),
);

enum ToastState{SUCCESS , ERROR , WARNNING}

Color toastColor(ToastState state)
{
  Color color;
  switch(state)
  {
    case ToastState.SUCCESS : color = Colors.green;
    break;

    case ToastState.ERROR : color = Colors.red;
    break;

    case ToastState.WARNNING : color = Colors.amber;
    break;
  }

  return color;
}