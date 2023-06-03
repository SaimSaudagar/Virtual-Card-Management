import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/blocs/card/addCardUI.dart';
import 'package:project/blocs/card/bloc/cardBloc.dart';
import 'package:project/blocs/card/bloc/cardEvents.dart';
import 'package:project/blocs/card/bloc/cardStates.dart';
import 'package:project/blocs/card/model/cardModel.dart';
import 'package:project/blocs/card/repo/cardRepo.dart';
import 'package:intl/intl.dart';

class MyCards extends StatefulWidget {
  const MyCards({super.key});

  @override
  State<MyCards> createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {
  String? selectedcard;
  final List<String> _card = [
    'CreditCard',
    'DebitCard',
  ];
  List<String> _selectedCards = [];

  //GET THE DATA OF CARD FROM FIRESTORE AND SAVE IT IN THE RESPECTIVE LIST
  List<String> _creditCards = ['Card C1', 'Card C2', 'Card C3'];
  List<String> _debitCards = ['Card D1', 'Card D2', 'Card D3'];
  String Heading = '';

  String _onCardTypeSelected() {
    setState(() {
      if (selectedcard == 'CreditCard') {
        Heading = 'Your Credit Cards';
      } else if (selectedcard == 'DebitCard') {
        _selectedCards = _debitCards;
      } else {
        _selectedCards = [];
      }
    });
    return Heading;
  }

  List<String> _onListSelected() {
    setState(() {
      if (selectedcard == 'CreditCard') {
        _selectedCards = _creditCards;
      } else if (selectedcard == 'DebitCard') {
        _selectedCards = _debitCards;
      } else {
        _selectedCards = [];
      }
    });
    return _selectedCards;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CardBloc>(
          create: (BuildContext context) => CardBloc(CardRepository()),
        ),
      ],
      child: Scaffold(
        body: blocBody(),
      ),
    );
  }

  Widget blocBody() {
    return BlocBuilder<CardBloc, CardState>(builder: (context, state) {
      if (state is CardLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is CardLoadedState) {
        return Scaffold(
            backgroundColor: Colors.grey.shade100,
            body: SafeArea(
                child: Stack(alignment: AlignmentDirectional.center, children: [
              background_container(context, state),
              card_display(context),
            ])));
      }
      if (state is CardErrorState) {
        return Center(
          child: Text(state.message),
        );
      }
      return Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: SafeArea(
              child: Stack(alignment: AlignmentDirectional.center, children: [
            background_container_empty(context),
            card_display(context),
          ])));
    });
  }

  card_show(CardModel cardModel, String selectedCardType, int length) {
    if (cardModel.cardType != selectedCardType) {
      // Return an empty container or null if you don't want to show anything
      return Container();
    }
    if (length == 0) {
      return const Text(
        'No cards added',
        style: TextStyle(fontSize: 16),
      );
    }
    return Container(
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            height: 120,
            width: 170,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    cardModel.cardNumber,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: const [
                      SizedBox(
                        width: 31,
                      ),
                      Align(
                        child: Text(
                          'Expiry Date',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 31,
                      ),
                      Text(
                        DateFormat('yyyy-MM-dd').format(cardModel.expiryDate),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    cardModel.cardHolder,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(cardModel.virtualNumber.toString()),
        ],
      ),
    );
  }

  Positioned card_display(BuildContext context) {
    return Positioned(
        top: 130,
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
              color: const Color.fromARGB(255, 54, 156, 149),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(children: [
                    const Text(
                      'Select Card Type',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    card_dropdown(context),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => AddCard()));
                          },
                          child: const Text(
                            '               Add a new card?         ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 17),
                          ),
                        )
                      ],
                    )
                  ]),
                ),
              ),
            ],
          ),
        ));
  }

  Widget card_dropdown(BuildContext context) {
    return Stack(children: [
      Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: const Color(0XFF00B686))),
            child: DropdownButton<String>(
              value: selectedcard,
              onChanged: ((value) {
                setState(() {
                  selectedcard = value!;
                  if (selectedcard == 'CreditCard') {
                    BlocProvider.of<CardBloc>(context).add(GettingCards());
                    _selectedCards = _creditCards;
                  } else if (selectedcard == 'DebitCard') {
                    BlocProvider.of<CardBloc>(context).add(GettingCards());
                    _selectedCards = _debitCards;
                  } else {
                    _selectedCards = [];
                  }
                });
              }),
              items: _card
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Text(e,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ))
                            ],
                          ),
                        ),
                      ))
                  .toList(),
              selectedItemBuilder: (BuildContext context) => _card
                  .map((e) => Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Text(e)
                        ],
                      ))
                  .toList(),
              hint: const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text('Card Type', style: TextStyle(color: Colors.white)),
              ),
              dropdownColor: Colors.white,
              isExpanded: true,
              underline: Container(),
            ),
          ),
        ],
      ),
    ]);
  }

  Column background_container(BuildContext context, CardLoadedState state) {
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
                  children: const [
                    Text(
                      'My Cards',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.attach_file_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.grey.shade100,
            child: Padding(
              padding: const EdgeInsets.only(top: 59),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Your cards",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.cards.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Container(
                                      height: 250,
                                      width: 500,
                                      decoration: const BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color(0XFF00B686),
                                            Color(0XFF00838F)
                                          ]),
                                          borderRadius: BorderRadius.only(
                                              // topLeft: Radius.circular(20),
                                              // topRight: Radius.circular(20),
                                              )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Card Holder: ${state.cards[index].cardHolder}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Card Type: ${state.cards[index].cardType}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Card Number: ${state.cards[index].cardNumber}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Cvv: ${state.cards[index].cvv}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Expiry Date: ${DateFormat('yyyy-MM-dd').format(state.cards[index].expiryDate)}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Virtual Map Number: ${state.cards[index].virtualNumber}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Alert!'),
                                                            content: const Text(
                                                                'Are you sure you want to freeze this card. You will no longer be able to use it.'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                        'Close'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                              TextButton(
                                                                child: const Text(
                                                                    'Continue'),
                                                                onPressed:
                                                                    () async {},
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    style: TextButton.styleFrom(
                                                      side: const BorderSide(
                                                          width: 1,
                                                          color: Colors.grey),
                                                      minimumSize:
                                                          const Size(100, 40),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      primary: Colors.white,
                                                      backgroundColor:
                                                          Color(0XFF00838F),
                                                    ),
                                                    child: const Text(
                                                        '  Freeze',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ))),
                                                TextButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Alert!'),
                                                            content: const Text(
                                                                'Are you sure you want to delete this card. Once you delete the card it will no longer be shown to you for use.'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                        'Close'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                              TextButton(
                                                                child: const Text(
                                                                    'Continue'),
                                                                onPressed:
                                                                    () async {},
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    style: TextButton.styleFrom(
                                                      side: const BorderSide(
                                                          width: 1,
                                                          color: Colors.grey),
                                                      minimumSize:
                                                          const Size(100, 40),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      primary: Colors.white,
                                                      backgroundColor:
                                                          Color(0XFF00B686),
                                                    ),
                                                    child: const Text(
                                                        '  Delete',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ))),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          title: Column(
                            children: [
                              Row(
                                children: [
                                  card_show(state.cards[index], selectedcard!,
                                      state.cards.length),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Column background_container_empty(BuildContext context) {
  return Column(
    children: [
      Container(
        height: 250,
        width: 500,
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0XFF00B686), Color(0XFF00838F)]),
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
                children: const [
                  Text(
                    'My Cards',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.attach_file_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.only(top: 59),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
