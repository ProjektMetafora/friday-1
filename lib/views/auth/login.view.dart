import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friday/providers/providers.dart';
import 'package:friday/widgets/dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../widgets/buttons.dart';
import '../../widgets/inputdecoration.dart';
import 'package:auto_route/auto_route.dart';

class LoginView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var email = useTextEditingController();

    var password = useTextEditingController();

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.1.sw, vertical: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Hero(
                  tag: "firday",
                  child: SvgPicture.asset(
                    "assets/Group 10579.svg",
                    height: 0.08.sh,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0.15.sh,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(0.1.sw),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //  SizedBox(
                    //   height: 0.5.sh,
                    // ),
                    AutoSizeText(
                      "Login",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    AutoSizeText(
                      "Please login or sign up to continue",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: 0.05.sh,
                    ),
                    TextField(
                      controller: email,
                      decoration: inputFormat(context, label: "Email"),
                    ),
                    SizedBox(
                      height: 0.04.sh,
                    ),
                    TextField(
                        controller: password,
                        decoration: inputFormat(context, label: "Password")),
                    SizedBox(
                      height: 0.1.sh,
                    ),
                    AuthButton(
                      text: "Login",
                      onPressed: () async {
                        // if (email.text.contains('@') &&
                        //     password.text.length > 6) {
                        showBlockingDialog(context);
                        await context.read(authProvider).signIn(
                            {"email": email.text, "password": password.text});
                        context.rootNavigator.popUntilPath('/');
                        // }
                      },
                      color: Theme.of(context).buttonColor,
                    ),
                    GoogleSignUpButton(
                      text: "Signup with Google",
                      onPressed: () async {

                        showBlockingDialog(context);
                        await context.read(authProvider).signInWithGoogle();
                        context.rootNavigator.popUntilPath('/');
                      },
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      height: 0.05.sh,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          // style: TextSty÷/,
                          text: "Don't have an account? ",
                          style: Theme.of(context).textTheme.subtitle1,
                          children: [
                            TextSpan(
                              text: "SignUp",
                              style: TextStyle(color: Colors.white),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // context.rootNavigator.popUntilPath('/');
                                  context.rootNavigator.push('/sign-up-view');
                                },
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 0.15.sh,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
