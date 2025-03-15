import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:AI_editor_app/app_bloc.dart';
import 'package:AI_editor_app/app_event.dart';
import 'package:AI_editor_app/app_state.dart';
import 'package:AI_editor_app/class/AuthProvider.dart';
import 'package:AI_editor_app/singin/sing_in.dart';
import 'package:AI_editor_app/welcom/bloc/welcom_bolc.dart';
import 'package:AI_editor_app/welcom/welcom.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => WeclomBloc(),
          ),
          BlocProvider(
            create: (context) => Appbloc(),
          ),
        ],
        child: ScreenUtilInit(
          builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme:
                  AppBarTheme(elevation: 0, backgroundColor: Colors.white),
            ),
            home: const Welcom(),
            routes: {
              "SingIn": (context) => SingIn()
            },
          ),
        ));
  }
}
