import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './providers/jobs.dart';
import './providers/auth.dart';

import './screens/authentication_screen.dart';
import './screens/job_details_screen.dart';
import './screens/saved_jobs_screen.dart';
import './screens/jobs_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Jobs>(
          update: (ctx, auth, previousData) => Jobs(auth.token, auth.userId,
              previousData == null ? [] : previousData.jobs),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, authData, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'GitHub Jobs - Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.blue[500],
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: ThemeData.light().textTheme.copyWith(
                  bodyText1: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 16,
                  ),
                  headline6: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  button: TextStyle(color: Colors.white),
                ),
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
            ),
          ),
          home: authData.isAuth
              ? JobsScreen()
              : FutureBuilder(
                  future: authData.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) => AuthScreen(),
                ),
          routes: {
            AuthScreen.routeName: (context) => AuthScreen(),
            JobsScreen.routeName: (context) => JobsScreen(),
            JobDetailsScreen.routeName: (context) => JobDetailsScreen(),
            SavedJobsScreen.routeName: (context) => SavedJobsScreen(),
          },
        ),
      ),
    );
  }
}
