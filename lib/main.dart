import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'routes/routes.gr.dart' as r;
import 'utils/theme.util.dart';
import 'views/app.widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        print("---");
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
              title: 'Flutter Demo',
              theme: AppTheme.theme().copyWith(
                textTheme: TextTheme(
                  headline1: GoogleFonts.montserrat(fontSize: 25),
                  headline2: GoogleFonts.montserrat(fontSize: 23),
                  bodyText1: GoogleFonts.montserrat(fontSize: 18),
                  bodyText2: GoogleFonts.montserrat(fontSize: 16),
                  subtitle1: GoogleFonts.montserrat(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                  caption: GoogleFonts.montserrat(fontSize: 14),
                ),
              ),
              builder: ExtendedNavigator.builder<r.Router>(router: r.Router()),
              home: SizedBox());
        }
        return CircularProgressIndicator();
      },
    );
  }
}
