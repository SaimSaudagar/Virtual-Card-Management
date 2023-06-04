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
  int index_color = 0;
  List Screen = [UserHomeUI(), const MyCards(), const UpdateUI()];

  @override
  void initState() {
    super.initState();
    index_color = widget.index_color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen[index_color],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (builder) => const Add()));
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xff368983),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 0;
                  });
                },
                child: Icon(
                  Icons.home,
                  size: 30,
                  color:
                      index_color == 0 ? const Color(0xff368983) : Colors.grey,
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       index_color = 1;
              //     });
              //   },
              //   child: Icon(Icons.bar_chart_outlined,
              //       size: 30,
              //       color: index_color == 1
              //           ? const Color(0xff368983)
              //           : Colors.grey),
              // ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 1;
                  });
                },
                child: Icon(Icons.account_balance_wallet_outlined,
                    size: 30,
                    color: index_color == 1
                        ? const Color(0xff368983)
                        : Colors.grey),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 2;
                  });
                },
                child: Icon(
                  Icons.person_outlined,
                  size: 30,
                  color:
                      index_color == 2 ? const Color(0xff368983) : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
