import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:friday/widgets/dialog.dart';
import 'package:hooks_riverpod/all.dart';

import '../../models/common/user.response.dart';
import '../../providers/providers.dart';
import '../../utils/string.util.dart';
import '../../widgets/creditcards.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 15, 15, 0),
                    child: IconButton(
                      onPressed: () {
                        context.rootNavigator.push('/wallet-view');
                      },
                      icon: Icon(MaterialCommunityIcons.wallet),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Icon(Icons.account_circle, size: 50, ),
                    ),
                    SizedBox(
                      width: 0.06.sw,
                    ),
                    Column(
                      children: [
                        AutoSizeText("Welcome Back",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.grey)),
                        Consumer(builder: (context, watch, child) {
                          context.read(appRepositoryProvider).getLoggedInUser();

                          return FutureBuilder<LoginUserResponse>(
                            future: context
                                .read(appRepositoryProvider)
                                .getLoggedInUser(),
                            builder: (BuildContext context,
                                AsyncSnapshot<LoginUserResponse> snapshot) {
                              if (snapshot.hasData) {
                                return AutoSizeText(
                                    "${snapshot.data.userDetails.name}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        .copyWith(fontSize: 28));
                              }

                              return CircularProgressIndicator();
                            },
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 0.1.sh),
                    child: Container(
                      height: 0.65.sh,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 0.06.sh,
                              ),
                              Consumer(builder: (context, watch, child) {
                                // context.read(appRepositoryProvider).getLoggedInUser();

                                return FutureBuilder<LoginUserResponse>(
                                  future: context
                                      .read(appRepositoryProvider)
                                      .getLoggedInUser(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<LoginUserResponse>
                                          snapshot) {
                                    if (snapshot.hasData) {
                                      return ActivateCardSwitch(

                                        isCardActive: snapshot
                                            .data.userDetails.vcardStatus,
                                      );
                                    }
                                    if (snapshot.hasError) {
                                      print(snapshot.error);
                                    }

                                    return CircularProgressIndicator();
                                  },
                                );
                              }),
                              Consumer(builder: (context, watch, child) {
                                // context.read(appRepositoryProvider).getLoggedInUser();

                                return FutureBuilder<LoginUserResponse>(
                                  future: context
                                      .read(appRepositoryProvider)
                                      .getLoggedInUser(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<LoginUserResponse>
                                          snapshot) {
                                    if (snapshot.hasData) {
                                      return MonthlySpend(
                                        spendValue: snapshot
                                            .data.userDetails.limit
                                            .toInt(),
                                      );
                                    }
                                    if (snapshot.hasError) {
                                      print(snapshot.error);
                                    }

                                    return CircularProgressIndicator();
                                  },
                                );
                              }),
                              Rewards(),
                              Offers(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Consumer(builder: (context, watch, child) {
                    // context.read(appRepositoryProvider).getLoggedInUser();

                    return FutureBuilder<LoginUserResponse>(
                      future:
                          context.read(appRepositoryProvider).getLoggedInUser(),
                      builder: (BuildContext context,
                          AsyncSnapshot<LoginUserResponse> snapshot) {
                        if (snapshot.hasData) {
                          return VirtualCard(
                            name: "${snapshot.data.userDetails.name}",
                            cardNumber: "${snapshot.data.vCard.vcNumber}",
                            validThru:
                                "${snapshot.data.vCard.expMonth}/${snapshot.data.vCard.expYear}",
                            image: "assets/Group 10768.svg",
                          );
                        }
                        if (snapshot.hasError) {
                          print(snapshot.error);
                        }

                        return CircularProgressIndicator();
                      },
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActivateCardSwitch extends HookWidget {
  final bool isCardActive;

  const ActivateCardSwitch({
    Key key,
    this.isCardActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isActive = useState(isCardActive);
    return Padding(
      padding: EdgeInsets.only(right: 0.1.sw),
      child: Align(
        alignment: Alignment.centerRight,
        heightFactor: 0.5,
        child: CupertinoSwitch(
          value: isActive.value,
          onChanged: (val) async {
            isActive.value = val;

            final result =
                await context.read(appRepositoryProvider).setVCardStatus(val);
            if (!result) {
              showSnack(context,
                  "Please make sure your KYC is done and at least one card is added");
            }
            // result
            // if (result) {
            //   isActive.value = val;
            // } else {
            //   isActive.value = !val;
            // }
          },
        ),
      ),
    );
  }
}

class Offers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.1.sw,0.03.sw,0.06.sw,0.04.sw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "We have some offers for you",
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Colors.black),
          ),
          SizedBox(
            height: 0.02.sh,
          ),
          Container(
            height: 0.1.sh,
            width: 1.0.sw,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  rewards[0],
                ),
                Image.asset(
                  rewards[1],
                ),
                Image.asset(
                  rewards[2],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Rewards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.1.sw,0.02.sw,0.06.sw,0.04.sw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Rewards",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.black),
            ),
          ),
          SizedBox(
            height: 0.02.sh,
          ),
          Container(
            height: 0.1.sh,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                  height: 0.08.sh,
                  width: 0.8.sw,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        rewards[index],
                      ),
                      Image.asset(
                        rewards[index],
                      ),
                      Image.asset(
                        rewards[2],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, __) {
                return SizedBox(
                  width: 0.03.sw,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class MonthlySpend extends HookWidget {
  final int spendValue;

  const MonthlySpend({
    Key key,
    this.spendValue = 1000,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var limit = useState(spendValue);
    var limitText = limit.value;
    if (limit.value > 1000) {
      limitText = limit.value ~/ 1000;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Text(
                "Monthly Spending Limit",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.black, fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Slider(
                  // divisions: 5,
                  min: 0,
                  max: 200000,
                  activeColor: Colors.black,
                  value: limit.value.toDouble(),
                  onChanged: (val) async {
                    limit.value = val.toInt();
                    print(val.toInt());

                    final result = await context
                        .read(appRepositoryProvider)
                        .setCardLimit(val.toInt());
                  },
                ),
                // LinearPercentIndicator(
                //   width: 0.65.sw,
                //   lineHeight: 14.0,
                //   percent: 0.5,
                //   backgroundColor: Colors.grey[200],
                //   progressColor: Colors.black,
                // ),
                Text(
                  "${limitText.toStringAsFixed(0)} K",
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.black),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
