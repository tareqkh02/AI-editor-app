import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:AI_editor_app/singin/sing_in.dart';
import 'package:AI_editor_app/welcom/bloc/welcom_bolc.dart';
import 'package:AI_editor_app/welcom/bloc/welcom_event.dart';
import 'package:AI_editor_app/welcom/bloc/welcom_state.dart';

class Welcom extends StatefulWidget {
  const Welcom({super.key});

  @override
  State<Welcom> createState() => _WelcomState();
}

class _WelcomState extends State<Welcom> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Scaffold(
          body: BlocBuilder<WeclomBloc, WelcomState>(builder: (context, state) {
            return Container(
              margin: EdgeInsets.only(top: 34.h),
              width: 375.w,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView(
                    controller: pageController,
                    onPageChanged: (index) {
                      state.page = index;
                      BlocProvider.of<WeclomBloc>(context).add(WelcomEvent());
                    },
                    children: [
                      _page(
                          2,
                          context,
                          "Next",
                          "Welcome to  Neo-Codex-AI",
                          "Neo-Codex-AI combines the power of ChatGPT and GimenAI to enhance your coding experience. ",
                          "assets/images/svg.svg"),
                      _page(
                          3,
                          context,
                          "get Stareted",
                          "Let's build something amazing today!",
                          "Features Overview: AI-Powered Code Suggestions, Smart Code Fixing ,Text Editor with AI Enhancements",
                          "assets/images/svg.svg"),
                    ],
                  ),
                  Positioned(
                      bottom: 120.h,
                      child: DotsIndicator(
                        position: state.page,
                        dotsCount: 3,
                        mainAxisAlignment: MainAxisAlignment.center,
                        decorator: DotsDecorator(
                            color: Colors.grey,
                            activeColor: Colors.blue,
                            size: const Size.square(8.0),
                            activeSize: const Size(18.0, 8.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ))
                ],
              ),
            );
          }),
        ));
  }

  Widget _page(int index, BuildContext context, String ButtonName, String title,
      String subtitel, String imgPath) {
    return Column(
      children: [
        SizedBox(
          height: 250.w,
          width: 250.w,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(
              imgPath,
              height: 110,
              width: 110,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20.0, right: 10.0, bottom: 10.0),
          child: Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 80,
          width: 345.w,
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: Text(
            subtitel,
            style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 14.sp,
                fontWeight: FontWeight.normal),
          ),
        ),
        SizedBox(
          height: 80,
        ),
        GestureDetector(
          onTap: () {
            if (index < 3) {
              pageController.animateToPage(index,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.decelerate);
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => SingIn()),
                (Route<dynamic> route) => false,
              );
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 60.h, right: 25.w, left: 25.w),
            width: 325.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(15.w)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 1))
              ],
            ),
            child: Center(
              child: Text(
                ButtonName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        )
      ],
    );
  }
}
