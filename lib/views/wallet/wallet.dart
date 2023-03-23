import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:test/response_sample.dart';
import 'package:test/styles/styles.dart';
import 'package:test/styles/theme.dart';

import '../../functions/functions.dart';
import '../../widgets/widget.dart';
import 'barChart.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

String amountt = '25000.00';
// int _selectedIndex = 0;
const double width = 20;

late List<BarChartGroupData> rawBarGroups;
late List<BarChartGroupData> showingBarGroups;

int touchedGroupIndex = -1;
const Color leftBarColor = Colors.lightBlue;
final Color rightBarColor = Colors.lightBlue.shade100;
const Color avgColor = Colors.green;

class _WalletPageState extends State<WalletPage> {
  @override
  void initState() {
    final week1 = makeGroupData(0, 7, 5);
    final week2 = makeGroupData(1, 8, 10);
    final week3 = makeGroupData(2, 10, 12);
    final week4 = makeGroupData(3, 14, 20);

    final items = [
      week1,
      week2,
      week3,
      week4,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "Wallet",
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
              const Padding(padding: EdgeInsets.only(top: 30)),
              Text(
                'Account Balance',
                style: smallText(),
              ),
              const SizedBox(
                height: 10,
              ),
              accountBalance(
                balance: formatAmount(amountt),
                color: AppColors.black,
                fontSize: 36.0,
                offSet: const Offset(1, -15),
                currencyOffSet: const Offset(1, -20),
              ),
              transactionOptions(),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 33),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Analytics",
                          style: welcomeText(
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset('assets/Iconly.svg'),
                            ),
                            Text(
                              "January 2023",
                              style: smallText(),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: BarChart(
                        BarChartData(
                          maxY: 20,
                          barTouchData: BarTouchData(
                            touchCallback: (FlTouchEvent event, response) {
                              if (response == null || response.spot == null) {
                                setState(() {
                                  touchedGroupIndex = -1;
                                  showingBarGroups = List.of(rawBarGroups);
                                });
                                return;
                              }

                              touchedGroupIndex =
                                  response.spot!.touchedBarGroupIndex;

                              setState(() {
                                if (!event.isInterestedForInteractions) {
                                  touchedGroupIndex = -1;
                                  showingBarGroups = List.of(rawBarGroups);
                                  return;
                                }
                                showingBarGroups = List.of(rawBarGroups);
                                if (touchedGroupIndex != -1) {
                                  var sum = 0.0;
                                  for (final rod
                                      in showingBarGroups[touchedGroupIndex]
                                          .barRods) {
                                    sum += rod.toY;
                                  }
                                  final avg = sum /
                                      showingBarGroups[touchedGroupIndex]
                                          .barRods
                                          .length;

                                  showingBarGroups[touchedGroupIndex] =
                                      showingBarGroups[touchedGroupIndex]
                                          .copyWith(
                                    barRods: showingBarGroups[touchedGroupIndex]
                                        .barRods
                                        .map((rod) {
                                      return rod.copyWith(
                                          toY: avg, color: avgColor);
                                    }).toList(),
                                  );
                                }
                              });
                            },
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: bottomTitles,
                                reservedSize: 42,
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 18,
                                interval: 1,
                                getTitlesWidget: leftTitles,
                              ),
                            ),
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          barGroups: showingBarGroups,
                          gridData:
                              FlGridData(show: true, drawVerticalLine: false),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 39,
              ),
              SizedBox(
                height: 340,
                child: expenseAndIncome(),
              )
            ],
          ),
        ),
      ),
    );
  }

  expenseAndIncome() {
    return ListView.builder(
      itemCount: wallet.length,
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
                const Padding(padding: EdgeInsets.only(top: 0, bottom: 0)),
                ListTile(
                  horizontalTitleGap: 0,
                  leading: wallet[i]['statement'] == 'Expense'
                      ? const CircleAvatar(
                          radius: 12,
                        )
                      : const CircleAvatar(
                          radius: 12,
                          backgroundColor: Color.fromARGB(255, 13, 73, 126),
                        ),
                  title: Text(
                    wallet[i]['statement'],
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      // height: 1.7,
                      color: const Color(0xff000C20),
                    ),
                  ),
                  trailing: Text(
                    wallet[i]['percent'],
                    style: bodyText(
                      color: const Color(0xff000C20),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    // Switch case can also be used for this
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '0';
    } else if (value == 6) {
      text = '2K';
    } else if (value == 13) {
      text = '4K';
    } else if (value == 19) {
      text = '6K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>[
      'Week 1',
      'Week 2',
      'Week 3',
      'Week 4',
    ];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: AppColors.primary,
          // leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: Colors.lightBlue.shade100,
          // widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
