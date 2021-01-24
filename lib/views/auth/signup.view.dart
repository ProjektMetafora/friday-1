import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_route/auto_route.dart';
import 'package:friday/providers/providers.dart';
import 'package:friday/widgets/dialog.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../widgets/buttons.dart';
import '../../widgets/inputdecoration.dart';
import '../../widgets/pincode.dart';

class SignUpView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var email = useTextEditingController();
    var name = useTextEditingController();
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
              height: 0.06.sh,
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
                      "Sign Up",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    AutoSizeText(
                      "Pleasse login or sign up to continue",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: 0.05.sh,
                    ),
                    TextField(
                      decoration: inputFormat(context, label: "Name"),
                      controller: name,
                    ),
                    SizedBox(
                      height: 0.04.sh,
                    ),
                    TextField(
                      decoration: inputFormat(context, label: "Email"),
                      controller: email,
                    ),
                    SizedBox(
                      height: 0.04.sh,
                    ),
                    TextField(
                      decoration: inputFormat(context, label: "Password"),
                      controller: password,
                    ),
                    SizedBox(
                      height: 0.1.sh,
                    ),
                    AuthButton(
                      text: "Next",
                      onPressed: () {
                        if (name.text.length >= 3 &&
                            email.text.isNotEmpty &&
                            password.text.length > 6) {
                          context.read(authProvider).addSignUpValues(
                              name.text, email.text, password.text);
                          context.rootNavigator.push('/sign-up-phone-view');
                        } else
                          showSnack(context, "Please enter valid details");
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
                          text: "Already have an account? ",
                          style: Theme.of(context).textTheme.subtitle1,
                          children: [
                            TextSpan(
                              text: "Login",
                              style: TextStyle(color: Colors.white),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // context.rootNavigator.popUntilPath('/');
                                  context.rootNavigator.push('/login-view');
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

class SignUpPhoneView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var phone = useTextEditingController();

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
                child: SvgPicture.asset(
                  "assets/Group 10579.svg",
                  height: 0.08.sh,
                ),
              ),
            ),
            SizedBox(
              height: 0.06.sh,
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
                      "Enter your Phone Number",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: 0.05.sh,
                    ),
                    AutoSizeText(
                      "We will send an otp code to this number",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: 0.05.sh,
                    ),
                    TextField(
                      decoration: inputFormat(
                        context,
                        label: "Phone",
                      ),
                      controller: phone,
                      inputFormatters: [],
                    ),
                    SizedBox(
                      height: 0.04.sh,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          // style: TextSty÷/,
                          text: " By Continuing I confirm I have read the ",
                          style: Theme.of(context).textTheme.subtitle1,
                          children: [
                            TextSpan(
                              text: " Privacy Policy ",
                              style: TextStyle(color: Colors.white),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // context.rootNavigator.push('/sign-up-view');
                                },
                            ),
                            TextSpan(
                              text: " and ",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            TextSpan(
                              text: " Terms and Conditions ",
                              style: TextStyle(color: Colors.white),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // context.rootNavigator.push('/sign-up-view');
                                },
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 0.15.sh,
                      ),
                    ),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                    AuthButton(
                      text: "Next",
                      onPressed: () {
                        if (phone.text.length == 10) {
                          context.read(authProvider).addphone(phone.text);
                          context.rootNavigator.push('/sign-up-otp-view');
                        } else
                          showSnack(
                              context, "Please enter a valid phone number");
                      },
                      color: Theme.of(context).buttonColor,
                    ),
                    SizedBox(
                      height: 0.05.sh,
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

class SignUpOtpView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var otp = useTextEditingController();

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
                child: SvgPicture.asset(
                  "assets/Group 10579.svg",
                  height: 0.08.sh,
                ),
              ),
            ),
            SizedBox(
              height: 0.06.sh,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(0.1.sw),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //  SizedBox(
                    //   height: 0.5.sh,
                    // ),
                    AutoSizeText(
                      "OTP Verification",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: 0.05.sh,
                    ),
                    Container(
                      width: 0.55.sw,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:
                              " Please enter the otp we have sent to your phone",
                          style: Theme.of(context).textTheme.subtitle1,
                          children: [
                            TextSpan(
                              text:
                                  " +91 ${context.read(authProvider).signUpForm['phone']} ",
                              style: TextStyle(color: Colors.white),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // context.rootNavigator.push('/sign-up-view');
                                },
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 0.15.sh,
                      ),
                    ),

                    SizedBox(
                      height: 0.02.sh,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: " Resend ",
                        style: TextStyle(color: Colors.white),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // context.rootNavigator.push('/sign-up-view');
                          },
                      ),

                      // SizedBox(
                      //   height: 0.15.sh,
                    ),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                    PincCodeWidget(),
                    SizedBox(
                      height: 0.04.sh,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        // style: TextSty÷/,
                        text: " By Continuing I confirm I have read the ",
                        style: Theme.of(context).textTheme.subtitle1,
                        children: [
                          TextSpan(
                            text: " Privacy Policy ",
                            style: TextStyle(color: Colors.white),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // context.rootNavigator.push('/sign-up-view');
                              },
                          ),
                          TextSpan(
                            text: " and ",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          TextSpan(
                            text: " Terms and Conditions ",
                            style: TextStyle(color: Colors.white),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // context.rootNavigator.push('/sign-up-view');
                              },
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 0.15.sh,
                    ),

                    SizedBox(
                      height: 0.03.sh,
                    ),
                    AuthButton(
                      text: "Confirm",
                      onPressed: () async {
                        showBlockingDialog(context);
                        final res = await context.read(authProvider).signUp();
                        context.rootNavigator.pop();
                        if (res) {
                          context.rootNavigator.popUntilPath('/');
                          context.rootNavigator.push('/login-view');
                        }
                        else {
                          showSnack(context, "Error Registering");
                        }
                      },
                      color: Theme.of(context).buttonColor,
                    ),
                    SizedBox(
                      height: 0.05.sh,
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
