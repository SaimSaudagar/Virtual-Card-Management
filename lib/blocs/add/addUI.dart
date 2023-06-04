import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/blocs/add/bloc/addBloc.dart';
import 'package:project/blocs/add/bloc/addEvents.dart';
import 'package:project/blocs/add/bloc/addStates.dart';
import 'package:project/blocs/add/model/addModel.dart';
import 'package:project/blocs/add/repo/addRepo.dart';
import 'package:project/blocs/card/bloc/cardBloc.dart';
import 'package:project/blocs/card/bloc/cardEvents.dart';
import 'package:project/blocs/card/bloc/cardStates.dart';
import 'package:project/blocs/card/repo/cardRepo.dart';
import 'package:project/widget/MainButton.dart';
import 'package:project/widget/bottom_navigation.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _Add();
}

class _Add extends State<Add> {
  @override
  String? selectedItem;
  String? selectedcard;
  DateTime date = DateTime.now();
  // String? selectedItems;
  final TextEditingController explain = TextEditingController();
  FocusNode ex = FocusNode();
  final TextEditingController amount_transacted = TextEditingController();
  FocusNode _amount = FocusNode();
  final List<String> _item = [
    'Food',
    'Education',
    'Utility',
    'Upwork',
    'Starbucks'
  ];
  // final List<String> _card = [
  //   'CreditCard',
  //   'DebitCard',
  // ];
  // final List<String> _items = ['Income', 'Expense'];

  @override
  void initState() {
    super.initState();
    ex.addListener(() {
      setState(() {});
    });
    _amount.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddBloc>(
          create: (BuildContext context) => AddBloc(AddRepository()),
        ),
        BlocProvider<CardBloc>(
          create: (BuildContext context) => CardBloc(CardRepository()),
        ),
      ],
      child: Scaffold(
        body: blocBody(context),
      ),
    );
  }

  Widget blocBody(BuildContext buildContext) {
    return BlocBuilder<AddBloc, AddState>(builder: (context, state) {
      if (state is LoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is SuccessState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) =>
                      const bottomNavigation(index_color: 0)));
        });
      }
      if (state is AddErrorState) {
        return AlertDialog(
          title: const Text('Insufficient Balance'),
          content: const Text(
              'You do not have enough balance in your account to make this transaction'),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
      return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
            child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            background_container(context),
            Positioned(
                top: 120,
                child: Column(
                  children: [
                    main_container(context),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                )),
          ],
        )),
      );
    });
  }

  Container main_container(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        height: 600,
        width: 340,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            name(),
            const SizedBox(
              height: 30,
            ),
            explanation(),
            const SizedBox(
              height: 30,
            ),
            amount(),
            const SizedBox(
              height: 30,
            ),
            how(),
            const SizedBox(
              height: 30,
            ),
            date_time(),
            const SizedBox(
              height: 30,
            ),
            // card(),
            const Spacer(),
            AddButton(context),
          ],
        ));
  }

  MainButton AddButton(BuildContext context) {
    return MainButton(
      onTap: () {
        if (selectedItem == null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('No Name Selected'),
                content:
                    const Text('Please select a name from the drop down menu'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else if (amount_transacted.text.isEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('No Amount Entered'),
                content: const Text('Please enter an amount'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else if (selectedcard == null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('No Card Selected'),
                content:
                    const Text('Please select a card from the drop down menu'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          BlocProvider.of<AddBloc>(context)
              .add(TransactionAddButtonPressed(AddModel(
            amountTransacted: amount_transacted.text,
            selectedCard: selectedcard!,
            date: date,
            explanation: explain.text,
            selectedItem: selectedItem,
          )));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Transaction Successful'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      btncolor: const Color.fromARGB(0, 14, 14, 14),
      text: const Text('Add',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          )),
    );
  }

  Container date_time() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: const Color(0XFF00B686))),
      width: 300,
      child: TextButton(
        onPressed: () async {},
        child: Text(
          'Date : ${date.year} / ${date.day} / ${date.month}',
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Padding how() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: BlocProvider(
        create: (context) => CardBloc(
          CardRepository(),
        )..add(GettingCards()),
        child: BlocBuilder<CardBloc, CardState>(
          builder: (context, state) {
            if (state is CardLoadedState) {
              return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(width: 2, color: const Color(0XFF00B686))),
                  child: DropdownButton<String>(
                    value: selectedcard,
                    onChanged: ((value) {
                      setState(() {
                        selectedcard = value!;
                      });
                    }),
                    items: state.cards
                        .where((card) => card.status == 'Active')
                        .map((e) => DropdownMenuItem(
                              value: e.cardNumber,
                              child: Container(
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(e.cardNumber,
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ))
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                    selectedItemBuilder: (BuildContext context) => state.cards
                        .map((e) => Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(e.cardNumber)
                              ],
                            ))
                        .toList(),
                    hint: const Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Text('Card', style: TextStyle(color: Colors.grey)),
                    ),
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    underline: Container(),
                  ));
            }
            return Container();
          },
        ),
      ),
    );
  }

  Padding amount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        keyboardType: TextInputType.number,
        focusNode: _amount,
        controller: amount_transacted,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'Amount',
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.grey.shade500,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 2, color: Color(0XFF00B686))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 2, color: Color(0XFF00838F)))),
      ),
    );
  }

  Padding explanation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        focusNode: ex,
        controller: explain,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'Explain',
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.grey.shade500,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 2, color: Color(0XFF00B686))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 2, color: Color(0XFF00838F)))),
      ),
    );
  }

  Padding name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: 300,
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: const Color(0XFF00B686))),
          child: DropdownButton<String>(
            value: selectedItem,
            onChanged: ((value) {
              setState(() {
                selectedItem = value!;
              });
            }),
            items: _item
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              child: Image.asset('assets/images/${e}.png'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(e,
                                style: const TextStyle(
                                  fontSize: 18,
                                ))
                          ],
                        ),
                      ),
                    ))
                .toList(),
            selectedItemBuilder: (BuildContext context) => _item
                .map((e) => Row(
                      children: [
                        Container(
                          width: 42,
                          child: Image.asset('assets/images/${e}.png'),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(e)
                      ],
                    ))
                .toList(),
            hint: const Padding(
              padding: EdgeInsets.only(top: 12),
              child: Text('Name', style: TextStyle(color: Colors.grey)),
            ),
            dropdownColor: Colors.white,
            isExpanded: true,
            underline: Container(),
          )),
    );
  }

  Column background_container(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 250,
          width: 500,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0XFF00B686), Color(0XFF00838F)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const Text('Adding',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600)),
                    const Icon(
                      Icons.attach_file_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
