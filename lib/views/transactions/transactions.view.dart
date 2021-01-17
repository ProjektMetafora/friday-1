import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:friday/widgets/dropdown.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:friday/widgets/creditcards.dart';

class TransactionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Column(
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
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.1.sw, vertical: 20),
                    child: Text(
                      "Transactions",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
                Container(
                  height: 0.25.sh,
                  // width: 0.9.sw,
                  child: CardsWidget(),
                ),
                SizedBox(
                  height: 0.03.sh,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircularTransactionIndicator(
                      percentage: 0.8,
                      amount: "1,07,548",
                    ),
                    CircularTransactionIndicator(
                      percentage: 0.15,
                      isDown: true,
                      amount: "10,000",
                    ),
                  ],
                )
              ],
            ),
            Transactions(),
          ],
        ),
      ),
    );
  }
}

class CircularTransactionIndicator extends StatelessWidget {
  final double percentage;
  final bool isDown;
  final String amount;
  const CircularTransactionIndicator({
    Key key,
    this.percentage = 0,
    this.isDown = false,
    this.amount = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.4.sw,
      height: 0.1.sh,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircularPercentIndicator(
            radius: 50.0,
            lineWidth: 5.0,
            animation: true,
            percent: percentage,
            center: Icon(
              isDown ? Icons.arrow_downward : Icons.arrow_upward,
              color: isDown
                  ? Colors.pinkAccent[100]
                  : Colors.deepPurpleAccent[100],
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor:
                isDown ? Colors.pinkAccent[100] : Colors.deepPurpleAccent[100],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                isDown ? "Credit" : "Debit",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              AutoSizeText(amount,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }
}

class Transactions extends StatelessWidget {
  const Transactions({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DirectSelectContainer(
      decoration: BoxDecoration(color: Colors.black),
      child: Container(
        child: DraggableScrollableSheet(
          initialChildSize: 0.3,
          minChildSize: 0.3,
          maxChildSize: 0.82,
          builder: (BuildContext context, myscrollController) {
            return Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                controller: myscrollController,
                child: Column(children: [
                  DirectSelectFeild(
                    label: "",
                    onSelect: (val, i, context) {

                    },
                    data: ["All", "Debit", "Credit"],
                  ),
                  // CustomDropDownTwo(
                  //   value: "All",
                  //   name: "Transactions",
                  //   listFeild: ["All", "Credit", "Debit"],
                  //   onChanged: (val) {},
                  // ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    // controller: myscrollController,
                    shrinkWrap: true,
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          title: Text(
                        'Transaction $index',
                        style: TextStyle(color: Colors.black54),
                      ));
                    },
                  ),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CardsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 3,
      itemBuilder: (contex, index) {
        return VirtualCard(
          name: "Sumit Roy",
          cardNumber: "5120 4200 0000 0000",
          validThru: "4/25",
          image: "assets/Group 10768.svg",
        );
      },
      options: CarouselOptions(
          height: 0.3.sh, viewportFraction: 0.8, enableInfiniteScroll: false),
    );
  }
}
