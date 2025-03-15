import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:AI_editor_app/common/valus/colors.dart';

AppBar buildAppBar() {
  return AppBar(
    bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: AppColors.primarySecondaryBackground,
          height: 1.0,
        )),
    title: Center(
      child: Text(
        "Welcom back !",
        style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.normal,
            color: AppColors.primaryText),
      ),
    ),
  );
}

Widget buildThreadParty(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        reusableIcons("google"),
        reusableIcons("apple"),
        reusableIcons("facebook"),
      ],
    ),
  );
}

Widget reusableIcons(String imgName) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      height: 40.w,
      width: 40.w,
      child: Image.asset("assets/icons/${imgName}.png"),
    ),
  );
}

Widget reusabelText(String text) {
  return Container(
    margin: EdgeInsets.only(bottom: 5.h),
    child: Text(
      text,
      style: TextStyle(
          color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14.sp),
    ),
  );
}

Widget buildTextfild(String text, String typeoftext, String iconName,
    TextEditingController controller) {
  return Container(
    width: 325.w,
    height: 50.h,
    margin: EdgeInsets.only(bottom: 20.h),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15.w)),
        border: Border.all(color: AppColors.primaryFourElementText)),
    child: Row(
      children: [
        Container(
            width: 16.w,
            margin: EdgeInsets.only(left: 17.w),
            height: 16.w,
            child: Image.asset('assets/icons/$iconName.png')),
        SizedBox(
            width: 270.w,
            height: 50.h,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  hintText: "${text}",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.transparent,
                  )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.transparent,
                  )),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.transparent,
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.transparent,
                  )),
                  hintStyle: TextStyle(
                    color: AppColors.primarySecondaryElementText,
                  )),
              style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp),
              autocorrect: false,
              obscureText: typeoftext == "password" ? true : false,
            ))
      ],
    ),
  );
}

Widget forgetpassword() {
  return Container(
      margin: EdgeInsets.only(left: 25.w),
      width: 260.w,
      height: 44.h,
      child: GestureDetector(
        onTap: () {},
        child: Text("Forget password?",
            style: TextStyle(
              color: AppColors.primaryText,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primaryText,
              fontSize: 12.sp,
            )),
      ));
}

Widget buildLogiandRegbutton(
    String buttonName, String buttonType, Function onTapAction) {
  return GestureDetector(
    onTap: () {
      onTapAction();
    },
    child: Container(
      margin: EdgeInsets.only(
          left: 25.w, right: 25.w, top: buttonType == "login" ? 10.h : 10.h),
      width: 325.w,
      height: 50.h,
      decoration: BoxDecoration(
          color: buttonType == "login"
              ? AppColors.primaryElement
              : AppColors.primaryBackground,
          borderRadius: BorderRadius.circular(15.w),
          border: Border.all(
              color: buttonType == "login"
                  ? Colors.transparent
                  : AppColors.primaryFourElementText),
          boxShadow: [
            BoxShadow(
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(0, 1),
                color: Colors.grey.withOpacity(0.1))
          ]),
      child: Center(
          child: Text(
        buttonName,
        style: TextStyle(
            color: buttonType == "login"
                ? AppColors.primaryBackground
                : AppColors.primaryText,
            fontWeight: FontWeight.normal,
            fontSize: 16.sp),
      )),
    ),
  );
}

Widget haveAccount(Function onTapAction) {
  return Container(
    margin: EdgeInsets.only(left: 25.w, top: 15.h),
    width: 260.w,
    height: 44.h,
    child: GestureDetector(
      onTap: () {
        onTapAction();
      },
      child: Text(
        "If you have a Account go to Sing in page",
        style: TextStyle(
          color: Colors.black,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.primaryText,
          fontSize: 12.sp,
        ),
      ),
    ),
  );
}
