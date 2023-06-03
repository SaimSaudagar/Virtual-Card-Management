import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/blocs/add/bloc/addBloc.dart';
import 'package:project/blocs/add/bloc/addEvents.dart';
import 'package:project/blocs/add/bloc/addStates.dart';
import 'package:project/blocs/add/repo/addRepo.dart';
import 'package:project/blocs/login/loginUI.dart';
import 'package:project/blocs/userhome/bloc/userHomeBloc.dart';
import 'package:project/blocs/userhome/bloc/userHomeEvents.dart';
import 'package:project/blocs/userhome/bloc/userHomeStates.dart';
import 'package:project/blocs/userhome/repo/userHomeRepo.dart';
import 'package:project/widget/navigationbar.dart';

List<String> list = <String>['One', 'Two', 'Three', 'Four'];
bool found = false;

class UserHomeUI extends StatelessWidget {
  User user = FirebaseAuth.instance.currentUser!;

  String dropdownValue = list.first;
  get index => null;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserHomeBloc>(
          create: (BuildContext context) => UserHomeBloc(UserHomeRepository()),
        ),
        BlocProvider<AddBloc>(
          create: (BuildContext context) => AddBloc(AddRepository()),
        ),
      ],
      child: Scaffold(
        body: blocBody(),
      ),
    );
  }

  Widget blocBody() {
    // final _cardlist = ['Debit Card', 'Credit Card', 'Pre-Paid Card'];
    // String? _selectedvalue = "";
    return BlocProvider(
      create: (context) => UserHomeBloc(
        UserHomeRepository(),
      )..add(FetchDataEvent()),
      child:
          BlocBuilder<UserHomeBloc, UserHomeState>(builder: (context, state) {
        if (state is UserHomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserHomeFailure) {
          return Center(child: Text(state.errorMessage));
        } else if (state is UserHomeSuccess) {
          return Scaffold(
            drawer: const SideBar(),
            backgroundColor: Colors.white,
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 490,
                      child: _head(state, context),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Transaction History',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'See more',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: BlocBuilder<AddBloc, AddState>(
                      builder: (context, state) {
                        if (state is InitalState) {
                          found = true;
                          BlocProvider.of<AddBloc>(context)
                              .add(GetTransactions());
                        }
                        if (state is LoadingState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is AddErrorState) {
                          return Center(child: Text(state.message));
                        } else if (state is LoadedState && found == true) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.add.length,
                            itemBuilder: (context, index) {
                              final item = state.add[index];
                              return ListTile(
                                leading: ClipRect(
                                  child: Image.asset(
                                    'assets/images/${item.selectedItem!}.png',
                                    height: 40,
                                  ),
                                ),
                                title: Text(
                                  item.selectedItems!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  item.explanation,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                trailing: Text(
                                  item.amountTransacted as String,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19,
                                    color: Colors.red,
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      }),
    );
  }

  Widget _head(UserHomeSuccess state, BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
                height: 300,
                width: 500,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0XFF00B686), Color(0XFF00838F)])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPageUI()),
                                (route) => false,
                              );
                            },
                            icon: Icon(Icons.arrow_back),
                            color: Colors.white,
                          ),
                          const Text(
                            'Available Balance',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                            ),
                          ),
                          const Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                color: Color(0XFF00B686),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.1),
                                    blurRadius: 8,
                                    spreadRadius: 3,
                                  )
                                ],
                                border: Border.all(
                                  width: 1.5,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(40.0)),
                            padding: const EdgeInsets.all(5.0),
                            child: CircleAvatar(
                              backgroundImage: state.user.gender == 'male'
                                  ? const NetworkImage(
                                      'https://cdn.vectorstock.com/i/1000x1000/16/88/bearded-man-face-avatar-happy-smiling-male-vector-46221688.webp')
                                  : const NetworkImage(
                                      'https://cdn5.vectorstock.com/i/1000x1000/01/69/businesswoman-character-avatar-icon-vector-12800169.jpg'),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${state.user.firstName} ${state.user.lastName}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.grey.shade100,
                child: ListView(
                  padding: const EdgeInsets.only(top: 55),
                  children: [
                    const Text('Activity',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildActivity(
                            Icons.card_membership,
                            "My Card",
                            Colors.blue.withOpacity(0.2),
                            const Color(0XFF01579B)),
                        buildActivity(
                            Icons.transfer_within_a_station,
                            "Transfer",
                            Colors.cyanAccent.withOpacity(0.2),
                            const Color(0XFF0097A7)),
                        buildActivity(
                            Icons.pie_chart,
                            "Statistics",
                            const Color(0XFFD7CCC8).withOpacity(0.4),
                            const Color(0XFF9499b7)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
            top: 165,
            left: 37,
            child: Container(
              height: 170,
              width: 320,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(47, 125, 121, 0.3),
                      offset: Offset(0, 6),
                      blurRadius: 12,
                      spreadRadius: 6,
                    )
                  ],
                  color: const Color.fromARGB(255, 47, 125, 121),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text('Total Balance',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('\$ ${state.user.balance}',
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: const [
                            CircleAvatar(
                              radius: 13,
                              backgroundColor:
                                  Color.fromARGB(255, 85, 145, 141),
                              child: Icon(Icons.arrow_upward,
                                  color: Colors.white, size: 19),
                            ),
                            SizedBox(width: 7),
                            Text('Expenses',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 216, 216, 216))),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('\$${state.user.expense}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }
}

Container buildActivity(
    IconData icon, String title, Color backgroundColor, Color iconColor) {
  return Container(
    height: 90,
    width: 90,
    decoration: BoxDecoration(
        color: backgroundColor, borderRadius: BorderRadius.circular(10)),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(
        icon,
        color: iconColor,
      ),
      const SizedBox(
        height: 5,
      ),
      TextButton(
          onPressed: () {},
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.black54, fontWeight: FontWeight.bold),
          ))
    ]),
  );
}