import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sih_2022_sahaye/Screens/Authentication/login_screen.dart';
import 'package:sih_2022_sahaye/Screens/app_getting_started_screen.dart';
import 'package:sih_2022_sahaye/Screens/operator/home_screen_op.dart';
import 'Models/local_storage.dart';
import 'Screens/admin/admin_home_screen.dart';
import 'Screens/users/user_home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (FirebaseAuth.instance.currentUser != null) {
    final obj = UserModel();
    final res = await obj.getUserType();
    runApp(MyApp(
      isLoggedIn: true,
      index: res ?? "",
    ));
  } else {
    runApp(const MyApp(
      isLoggedIn: false,
    ));
  }
}

final _navKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  final String index; //for recognize user 0 for normal,1 for operator and 2 for admin.
  const MyApp({Key? key, required this.isLoggedIn, this.index = ""}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = widget.isLoggedIn;
    String index = widget.index;
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: () => MaterialApp(
              title: 'MyApp',
              key: _navKey,
              debugShowCheckedModeBanner: false,
              home: LoginScreen(index: 0),
              //  home: isLoggedIn?(index.toString()=="0"? UserHomeScreen():(index.toString()=="1"? HomeScreenOP():(index.toString()=="2"?const AdminHomeScreen():const GettingStartedScreen()))):const GettingStartedScreen(),
              /* builder: (context, widget) {
                ScreenUtil.setContext(context);
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: isLoggedIn?(index.toString()=="0"?const UserHomeScreen():(index.toString()=="1"?const HomeScreenOP():(index.toString()=="2"?const AdminHomeScreen():const GettingStartedScreen()))):const GettingStartedScreen(),
                );
              },*/
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
