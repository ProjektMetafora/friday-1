import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:friday/models/common/cards_list.response.dart';
import 'package:friday/providers/providers.dart';
import 'package:hooks_riverpod/all.dart';

import '../../widgets/creditcards.dart';
import 'add.card.view.dart';

class CardsView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer(builder: (context, watch, child) {
            // context.read(appRepositoryProvider).getLoggedInUser();

            return FutureBuilder<CardsList>(
              future: context.read(appRepositoryProvider).getCardsList(),
              builder:
                  (BuildContext context, AsyncSnapshot<CardsList> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(MaterialCommunityIcons.wallet),
                          ),
                        ),
                      ),
                      ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ActualCards(
                              index: index,
                              name: "${snapshot.data.cards[index].nameOnCard}",
                              cardNumber:
                                  "${snapshot.data.cards[index].binNumber}XXXXXX${snapshot.data.cards[index].cardLastFourDigits}",
                              validThru:
                                  "${snapshot.data.cards[index].expirationMonth}/${snapshot.data.cards[index].expirationYear}",
                              image: "assets/Group 10768.svg",
                              isDefault: snapshot.data.cards[index].isDefault,
                            );
                          },
                          separatorBuilder: (_, __) {
                            return SizedBox();
                          },
                          itemCount: snapshot.data.cards.length),
                      SizedBox(
                        height: 0.08.sh,
                      ),
                    ],
                  );
                }
                if (snapshot.hasError) {
                  print(snapshot.error);
                }

                if (snapshot.connectionState == null){
                 return Container(
                   height: 1.sh,
                   child: Center(
                     child: Text(
                       "Cards not added. \n Please add card to preview.",
                       textAlign: TextAlign.center,
                     ),
                   ),
                 );
                }
                return Container(
                  height: 1.sh,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
          }),
        ),
      ),
      floatingActionButton: OpenContainer(
        closedShape: CircleBorder(),
        transitionDuration: const Duration(milliseconds: 400),
        closedBuilder: (context, action) {
          return FloatingActionButton(
            focusColor: Colors.black,
            child: Icon(Icons.add),
            onPressed: action,
          );
        },
        openBuilder: (context, action) {
          return AddCardView();
        },
      ),
    );
  }
}
