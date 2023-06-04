import 'package:flutter/material.dart';
import 'package:project/blocs/add/addUI.dart';
import 'package:project/blocs/card/cardUI.dart';
import 'package:project/blocs/update/updateUI.dart';
import 'package:project/blocs/userhome/userHomeUI.dart';

class bottomNavigation extends StatefulWidget {
  final int index_color;
  const bottomNavigation({Key? key, required this.index_color})
      : super(key: key);

  @override
  State<bottomNavigation> createState() => _bottomNavigationState();
}

class _bottomNavigationState extends State<bottomNavigation> {
  int indexColor = 0;
  List<Widget> screens = [
    UserHomeUI(),
    const MyCards(),
    const UpdateUI(),
  ];

  @override
  void initState() {
    super.initState();
    indexColor = widget.index_color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: indexColor,
            children: screens,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 60,
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        indexColor = 0;
                      });
                    },
                    icon: Icon(
                      Icons.home,
                      size: 30,
                      color: indexColor == 0
                          ? const Color(0xff368983)
                          : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        indexColor = 1;
                      });
                    },
                    icon: Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 30,
                      color: indexColor == 1
                          ? const Color(0xff368983)
                          : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        indexColor = 2;
                      });
                    },
                    icon: Icon(
                      Icons.person_outlined,
                      size: 30,
                      color: indexColor == 2
                          ? const Color(0xff368983)
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment(0, 0.87),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (builder) => const Add()),
            );
          },
          child: const Icon(Icons.add),
          backgroundColor: const Color(0xff368983),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
