import 'package:bottom_indicator_bar_svg/bottom_indicator_bar_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:test/utils/exports.dart';
import 'package:test/views/transactions/transactions.dart';

import '../styles/styles.dart';
import '../styles/theme.dart';
import '../views/home/Homepage.dart';
import '../views/profile/profile.dart';
import '../views/wallet/wallet.dart';

// AppBar

AppBar appBar({title}) {
  return AppBar(
    title: Text(
      title,
      style: welcomeText(
        color: AppColors.black,
      ),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    centerTitle: false,
  );
}

// -------------Custom Nav

class BottomNav extends StatefulWidget {
  int? valueset;
  @override
  State createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;
  final List<BottomIndicatorNavigationBarItem> items = [
    BottomIndicatorNavigationBarItem(
      icon: 'assets/Home.svg',
      label: Text(
        'Home',
        style: transactionOpt(),
      ),
    ),
    BottomIndicatorNavigationBarItem(
      icon: 'assets/Swap.svg',
      label: Text(
        'Transactions',
        style: transactionOpt(),
      ),
    ),
    BottomIndicatorNavigationBarItem(
        icon: 'assets/Wallet.svg',
        label: Text(
          'Wallet',
          style: transactionOpt(),
        ),
        iconSize: 28),
    BottomIndicatorNavigationBarItem(
        icon: 'assets/Profile.svg',
        label: Text(
          'Profile',
          style: transactionOpt(),
        ),
        iconSize: 28),
  ];

  late List<Widget> pages;

  void _onItemTap(int selectedItem) {
    setState(() {
      currentIndex = selectedItem;
    });
  }

  @override
  void initState() {
    pages = [
      const Homepage(),
      const Transactions(),
      const WalletPage(),
      const Profile()
    ];
    super.initState();
    currentIndex = (widget.valueset ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: pages.length,
      child: Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: BottomIndicatorBar(
          onTap: _onItemTap,
          items: items,
          iconSize: 30.0,
          indicatorHeight: 3, // Set to 0 to hide the indicator bar
          activeColor: AppColors.primary,
          inactiveColor: Colors.grey,
          indicatorColor: AppColors.primary,
          currentIndex: currentIndex,
        ),
      ),
    );
  }
}

accountBalance({
  balance,
  color,
  fontSize,
  offSet,
  currencyOffSet,
}) {
  return RichText(
    text: TextSpan(children: [
      WidgetSpan(
        child: Transform.translate(
          offset: currencyOffSet,
          child: Text(
            '£',
            textScaleFactor: 0.9,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ),
      ),
      TextSpan(
        text: balance,
        style: GoogleFonts.inter(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: color,
        ),
        recognizer: null,
      ),
      WidgetSpan(
        child: Transform.translate(
          offset: offSet,
          child: Text(
            '.${double.parse(amountt).toStringAsFixed(2).split('.')[1]}',
            textScaleFactor: 0.9,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ),
      )
    ]),
  );
}

Widget transactionOptionButton({icon, title}) {
  return Column(
    children: [
      CircleAvatar(
        backgroundColor: AppColors.primary,
        radius: 25,
        child: SvgPicture.asset(
          icon,
          width: 17,
          height: 15,
          color: Colors.white,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        title,
        style: transactionOpt(),
      )
    ],
  );
}

Widget transactionOptions() {
  return Padding(
    padding: const EdgeInsets.only(top: 30),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        transactionOptionButton(icon: 'assets/Download.svg', title: 'Withdraw'),
        transactionOptionButton(icon: 'assets/Send.svg', title: 'Transfer'),
        transactionOptionButton(icon: 'assets/WalletP.svg', title: 'Deposit'),
      ],
    ),
  );
}
