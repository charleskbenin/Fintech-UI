import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:test/response_sample.dart';
import 'package:test/styles/styles.dart';
import 'package:test/styles/theme.dart';
import 'package:test/widgets/widget.dart';

import '../../functions/functions.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "Hello. Oscar",
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.fast,
          parent: FixedExtentScrollPhysics(),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Divider(),
              const Padding(padding: EdgeInsets.only(top: 20)),
              cardTypeSlider(),
              transactionOptions(),
              const SizedBox(
                height: 30,
              ),
              const Divider(),
              const SizedBox(
                height: 32,
              ),
              SizedBox(height: 350, child: transactions())
            ],
          ),
        ),
      ),
    );
  }

  Widget cardTypeSlider() {
    return CarouselSlider.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.black,
            ],
          ),
        ),
        // width: MediaQuery.of(context).size.width,
        width: 255,
        height: 166,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    CardTypes[itemIndex]['card_type'],
                    style: welcomeText(
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/ContPayment.svg',
                    width: 13.39,
                    height: 16.91,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  // Text(
                  //   CardTypes[itemIndex]['card_number'],
                  //   style: ccNumber(),
                  // ),
                  Text(
                    obscureCreditCard(CardTypes[itemIndex]['card_number']),
                    style: ccNumber(),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/White 01.svg',
                    width: 21.66,
                    height: 19.02,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              accountBalance(
                balance: formatAmount(CardTypes[itemIndex]['amount']),
                color: Colors.white,
                fontSize: 28.0,
                offSet: const Offset(1, -10),
                currencyOffSet: const Offset(1, -10),
              ),
            ],
          ),
        ),
      ),
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 0.7,
        aspectRatio: 2.0,
        initialPage: 2,
      ),
    );
  }

  Widget transactions() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: Transactions.length,
      itemBuilder: (_, index) {
        final date = DateTime.parse(Transactions[index]['date']);
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day - 3);
        final yesterday = DateTime(now.year, now.month, now.day - 2);
        final isToday = date == today;
        final isYesterday = date == yesterday;
        final formattedDate = isToday
            ? 'Yesterday'
            : (isYesterday
                ? 'Today'
                : '${date.day}/${date.month}/${date.year}');
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                formattedDate.toString(),
                style: smallText(),
              ),
            ),
            ListView.builder(
              itemCount: Transactions[index]['children'].length,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xFFF8F9FD),
                    ),
                    child: Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(top: 0, bottom: 0)),
                        transactionList(i: i, index: index)
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }

  Widget transactionList({index, i}) {
    return ListTile(
      horizontalTitleGap: 0,
      leading: Transactions[index]['children'][i]['type'] != 'transfer'
          ? Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: AppColors.green,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                Icons.arrow_downward,
                color: AppColors.green,
                size: 20,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: AppColors.red,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                Icons.arrow_upward,
                color: AppColors.red,
                size: 20,
              ),
            ),
      title: Text(
        Transactions[index]['children'][i]['name'],
        style: bodyText(
          color: Colors.black,
        ),
      ),
      trailing: RichText(
        text: TextSpan(children: [
          WidgetSpan(
            child: Transform.translate(
              offset: const Offset(1, -6),
              child: const Text(
                '£',
                textScaleFactor: 0.9,
                style:
                    TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 12),
              ),
            ),
          ),
          TextSpan(
            text: formatAmount(Transactions[index]['children'][i]['amount']),
            style: bodyText(
              color: const Color(0xff000E24),
            ),
            recognizer: null,
          ),
          WidgetSpan(
            child: Transform.translate(
              offset: const Offset(1, -6),
              child: Text(
                '.${double.parse(Transactions[index]['children'][i]['amount'].toString()).toStringAsFixed(2).split('.')[1]}',
                textScaleFactor: 0.9,
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
