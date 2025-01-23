import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tintwiz_app/dashboard.dart';
import 'package:tintwiz_app/openbutton.dart';
import 'package:tintwiz_app/screen/dynamic_form.dart';
import 'package:tintwiz_app/utils/shared_prefs.dart';



import 'details_form.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preference.init();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBvLjE-_TNmRInZJXC-aduq1GBxLmyDmc4",
        authDomain: "auto-assist-c9acb.firebaseapp.com",
        projectId: "auto-assist-c9acb",
        storageBucket: "auto-assist-c9acb.firebasestorage.app",
        messagingSenderId: "615209874193",
        appId: "1:615209874193:web:9a513334241ba8627152b0",
        measurementId: "G-G0ETCVBZFV"
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final GoRouter _router = GoRouter(routes: [
    GoRoute(path: "/",
    builder: (context, state) => DashBoard(),
    ),


    // GoRoute(path: "/dashboard",
    //   builder: (context, state) => DashBoard(),
    // ),
    GoRoute(path: "/details",
      builder: (context, state) => DetailsScreen(),
    ),

    GoRoute(path: "/settings",
      builder: (context, state) => DynamicFormWithLayoutBuilderr(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) {
       final queryParams = state.uri.queryParameters;
        final params = state.extra as Map<String, bool>?; // Receiving data
        return OpenButton(
          queryParams:queryParams,
          isNameVisible: params?['isNameVisible'] ?? true,
          isAddressVisible: params?['isAddressVisible'] ?? false,
          isMobileVisible: params?['isMobileVisible'] ?? false,
          isCompanyNameVisible: params?['isCompanyNameVisible'] ?? true,
          isEmailVisible: params?['isEmailVisible'] ?? false,
          isVehicleVisible: params?['isVehicleVisible'] ?? false,
          isMessageVisible: params?['isMessageVisible'] ?? false,
        );
      },
    ),

  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      //home: LoginPage(),
    );
  }
}
