import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sih_2022_sahaye/Screens/operator/home_screen_op.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: () => MaterialApp(
              title: 'MyApp',
              home: HomeScreenOP(),
              debugShowCheckedModeBanner: false,
              builder: (context, widget) {
                ScreenUtil.setContext(context);
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                );
              },
              theme: ThemeData(
                textTheme: TextTheme(
                  headline1: GoogleFonts.openSans(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  headline2: GoogleFonts.openSans(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  headline3: GoogleFonts.openSans(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  headline6: GoogleFonts.openSans(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  bodyText1: GoogleFonts.openSans(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ));
  }
}
