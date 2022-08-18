import 'package:flutter/material.dart';
import 'package:gocolis/common/widgets/bottom_bar.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/features/auth/admin/screens/admin_screen.dart';
import 'package:gocolis/features/auth/authSignUp/services/authService.dart';
import 'package:gocolis/features/auth/sender/screens/facebook_login_page.dart';
import 'package:gocolis/features/auth/sender/screens/google_login.dart';
import 'package:gocolis/features/auth/sender/screens/sender_home.dart';
import 'package:gocolis/features/auth/sender/screens/sender_login_screen.dart';
import 'package:gocolis/features/auth/sender/services/facebook_login_controller.dart';
import 'package:gocolis/features/auth/sender/services/google_login_controller.dart';
import 'package:gocolis/features/auth/sender/services/sender_services.dart';
import 'package:gocolis/features/auth/sender/services/social_login_controller.dart';
import 'package:gocolis/features/auth/traveler/screens/traveler_home.dart';
import 'package:gocolis/features/auth/traveler/screens/traverler_login_screen.dart';
import 'package:gocolis/features/auth/traveler/services/traveler_services.dart';
import 'package:gocolis/features/messages/screens/message_home.dart';
import 'package:gocolis/features/profile/screens/main_profile.dart';
import 'package:gocolis/features/profile/screens/profile_screen.dart';
import 'package:gocolis/providers/user_provider.dart';
import 'package:gocolis/router.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => GoogleSignINController(),
      child: const SenderLoginScreen(),
    ),
    ChangeNotifierProvider(
      create: (context) => FacebookSignINController(),
      child: const SenderLoginScreen(),
    ),
    /*ChangeNotifierProvider(
      create: (context) => GoogleSignINController(),
      child: GoogleLogin(),
    ),
    ChangeNotifierProvider(
      create: (context) => FacebookSignINController(),
      child: FacebookLogin(),
    ),*/
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  final SenderServices senderServices = SenderServices();
  final TravelerServices travelerServices = TravelerServices();
  //whenever i run initState fctn, i get the user data
  @override
  void initState() {
    super.initState();
    //bind authService to my UI
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
//google-sign-in ----------------------------------------------------
 /*   return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => GoogleSignINController(),
        child: GoogleLogin(),
      ),
    ], 
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoColis',
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: GoogleLogin(),
    ),
  );
  }
} */
//-------------------------------------------------------------------------------------------------------------------------------
    
    //INJECT MAP CONTROLLER
    //Get.lazyPut(() => ImageController());
    return MaterialApp(
      //return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoColis',
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: backgroundColor,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      /*home: Provider.of<UserProvider>(context).user.token.isNotEmpty
        ? SenderHome()
        : const  SenderLoginScreen(),*/
      /*home: Provider.of<UserProvider>(context).user.token.isNotEmpty 
        ? Provider.of<UserProvider>(context).user.userType == 'admin'
          ? const AdminScreen()
          : const BottomBar()
        : const SenderLoginScreen(),*/
      //home: MapScreen(),
      //home: DeliveryRequestsScreen(),
      //home: ImageScreen(),
      //home: SenderLoginScreen(),
      //home: MainProfile(),
      /*home: Provider.of<UserProvider>(context).user.token.isNotEmpty
        ? MainProfile()
        : const  SenderLoginScreen(),*/
      /*home: Provider.of<UserProvider>(context).user.token.isNotEmpty
      ? SenderHome()
      : SenderLoginScreen(),*/

      //home: SenderLoginScreen(),

      /*home: Provider.of<UserProvider>(context).user.token.isNotEmpty 
        ? Provider.of<UserProvider>(context).user.userType == 'traveler'
          ? const TravelerHome()
          : const BottomBar()
        : const TravelerLoginScreen(),*/

      home: MessageHome(),
    );
  }
}
