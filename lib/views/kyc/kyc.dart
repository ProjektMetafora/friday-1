import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:friday/providers/providers.dart';
import 'package:friday/widgets/buttons.dart';
import 'package:friday/widgets/dialog.dart';
import 'package:friday/widgets/inputdecoration.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

class KYCView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var pan = useTextEditingController();
    var dob = useTextEditingController();
    var consent = "yes";

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.05.sh),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),

                  ),
                ),
                Text(
                  "KYC",
                  style: Theme.of(context).textTheme.headline1,
                ),
                Row(
                  children: [
                    Text(
                      "Complete your KYC",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      width: 0.01.sh,
                    ),
                    Icon(Icons.verified)
                  ],
                ),
                SizedBox(
                  height: 0.07.sh,
                ),
                Align(
                  child: SvgPicture.asset("assets/Group 10654.svg", width: 0.5.sw,),
                ),
                SizedBox(
                  height: 0.1.sh,
                ),
                TextField(
                  controller: pan,
                  decoration:
                      InputDecoration(
                        icon: new Icon(Icons.credit_card_rounded) ,
                      ),
                  ),

                SizedBox(
                  height: 0.03.sh,
                ),
                TextField(
                  controller: dob,
                  decoration:  InputDecoration(
                      icon: new Icon(Icons.date_range) ,
                  ),
                  ),

                SizedBox(
                  height: 0.03.sh,
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
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ActionButton(
                    onPressed: () async {
                      Map<String, dynamic> form = {
                        "pan_card": pan.text,
                        "dob": dob.text,
                        "consent": consent,
                      };
                      showSnack(context, "SAVING DETAILS");
                      print(form);
                      final res = await context.read(appRepositoryProvider).addKYC(form);
                      print(res);
                      if (res) {
                        context.rootNavigator.popUntilPath("/");
                        showSnack(context, "SUCCESS");

                      } else {
                        showSnack(context, "ERROR OCCURED IN KYC");
                      }
                    },
                    text: "Submit",
                    color: Theme.of(context).buttonColor,
                    width: 0.25,
                  ),
                ),
                // SizedBox(
                //   height: 0.03.sh,
                // ),
                // RichText(
                //   textAlign: TextAlign.start,
                //   text: TextSpan(
                //     // style: TextSty÷/,
                //     text: " Instructions ",
                //     style: Theme.of(context).textTheme.bodyText1,
                //     children: [
                //       TextSpan(
                //         text: " \n Verify documents ",
                //         style: Theme.of(context).textTheme.subtitle1,
                //       ),
                //       TextSpan(
                //         text: " \n Verify Identity ",
                //         style: Theme.of(context).textTheme.subtitle1,
                //       ),
                //     ],
                //   ),
                // )
                // Date
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExlcamationWidget extends StatelessWidget {
  final bool isDone;
  const ExlcamationWidget({
    Key key,
    this.isDone = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: isDone ? Colors.greenAccent : Colors.redAccent,
      child: Icon(
        isDone
            ? MaterialCommunityIcons.check
            : MaterialCommunityIcons.exclamation,
        color: Colors.black,
      ),
    );
  }
}
