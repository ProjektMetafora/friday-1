import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:friday/models/common/user.response.dart';
import 'package:friday/widgets/buttons.dart';
import 'package:friday/widgets/inputdecoration.dart';
import 'package:auto_route/auto_route.dart';

import '../../providers/providers.dart';
import '../../providers/providers.dart';

//
// class ProfileView extends StatefulWidget {
//   @override
//   _ProfileViewState createState() => _ProfileViewState();
// }
//
class ProfileView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // var name = useTextEditingController();
    // var email = useTextEditingController();
    // var phone = useTextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer(builder: (context, watch, child) {
            return FutureBuilder<LoginUserResponse>(
              future: context.read(appRepositoryProvider).getLoggedInUser(),
              builder: (BuildContext context,
                  AsyncSnapshot<LoginUserResponse> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.1.sw, vertical: 0.08.sh),
                          child: Text(
                            "Profile",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 0.08.sh),
                            child: Container(
                              height: 0.75.sh,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(35),
                                    topRight: Radius.circular(35),
                                  ),
                                  color: Colors.white,
                                ),
                                // color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Form(
                                        child: Column(
                                          children: [

                                            Container(
                                                decoration: BoxDecoration(

                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(
                                                          10.0) //                 <--- border radius here
                                                  ),
                                                ),
                                                alignment: Alignment.centerLeft,
                                                width: 0.75.sw,
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      WidgetSpan(
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .fromLTRB(
                                                              10.0,
                                                              0,
                                                              20.0,
                                                              0),
                                                          child: Icon(
                                                              Icons
                                                                  .account_box_rounded,
                                                              color:
                                                              Colors.black,
                                                              size: 30),
                                                        ),
                                                      ),
                                                      WidgetSpan(
                                                        child: Text(
                                                          snapshot.data
                                                              .userDetails.name,
                                                          style: TextStyle(
                                                              color:
                                                              Colors.black,
                                                              fontSize: 25),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            SizedBox(
                                              height: 0.04.sh,
                                            ),
                                            Container(
                                                decoration: BoxDecoration(

                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(
                                                          10.0) //                 <--- border radius here
                                                  ),
                                                ),
                                                alignment: Alignment.centerLeft,
                                                width: 0.75.sw,
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      WidgetSpan(
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .fromLTRB(
                                                              10.0,
                                                              0,
                                                              20.0,
                                                              0),
                                                          child: Icon(
                                                              Icons
                                                                  .email_rounded,
                                                              color:
                                                              Colors.black,
                                                              size: 30),
                                                        ),
                                                      ),
                                                      WidgetSpan(
                                                        child: Text(
                                                          snapshot.data
                                                              .userDetails.name,
                                                          style: TextStyle(
                                                              color:
                                                              Colors.black,
                                                              fontSize: 25),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            SizedBox(
                                              height: 0.04.sh,
                                            ),
                                            Container(
                                                decoration: BoxDecoration(

                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(
                                                          10.0) //                 <--- border radius here
                                                      ),
                                                ),
                                                alignment: Alignment.centerLeft,
                                                width: 0.75.sw,
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      WidgetSpan(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  10.0,
                                                                  0,
                                                                  20.0,
                                                                  0),
                                                          child: Icon(
                                                              Icons
                                                                  .phone_android_rounded,
                                                              color:
                                                                  Colors.black,
                                                              size: 30),
                                                        ),
                                                      ),
                                                      WidgetSpan(
                                                        child: Text(
                                                          "8511595490",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 25),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            SizedBox(
                                              height: 0.04.sh,
                                            ),
                                            ActionButton(
                                              onPressed: () async {
                                                await context
                                                    .read(authProvider)
                                                    .signOut();

                                                context.rootNavigator
                                                    .popUntilPath('/');

                                                // await context.read(authProvider).signIn(
                                                //     {"email": email.text, "password": password.text});
                                                // context.rootNavigator.popUntilPath('/');
                                              },
                                              width: 0.75,
                                              text: "LogOut",
                                              color: Colors.black,
                                            ),
                                            //   Align(
                                            //     alignment: Alignment.centerRight,
                                            //     child: ActionButton(
                                            //       onPressed: () async {
                                            //         await context.read(authProvider).signOut();
                                            //
                                            //         context.rootNavigator.popUntilPath('/');
                                            //
                                            //         // await context.read(authProvider).signIn(
                                            //         //     {"email": email.text, "password": password.text});
                                            //         // context.rootNavigator.popUntilPath('/');
                                            //       },
                                            //       text: "Logout",
                                            //       color:
                                            //       Theme.of(context).primaryColor,
                                            //     ),
                                            //   )
                                            //   ],
                                            // ),
                                            SizedBox(
                                              height: 0.01.sh,
                                            ),
                                            ActionButton(
                                              onPressed: () {
                                                context.rootNavigator
                                                    .push('/k-yc-view');
                                              },
                                              width: 0.75,
                                              text: "KYC",
                                              color: Colors.black,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,

                            child: Icon(Icons.account_circle, size: 100, )
                            ),

                        ],
                      ),
                    ],
                  );
                }
                if (snapshot.hasError) {
                  print(snapshot.error);
                }

                return CircularProgressIndicator();
              },
            );
          }),
        ),
      ),
    );
  }
}
