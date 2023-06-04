import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/blocs/card/bloc/cardBloc.dart';
import 'package:project/blocs/card/bloc/cardEvents.dart';
import 'package:project/blocs/card/bloc/cardStates.dart';
import 'package:project/blocs/card/model/cardModel.dart';
import 'package:project/blocs/card/repo/cardRepo.dart';
import 'package:project/widget/MainButton.dart';
import 'package:project/widget/bottom_navigation.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  TextEditingController cardNumber = TextEditingController();
  TextEditingController cvv = TextEditingController();
  TextEditingController cardHolder = TextEditingController();
  DateTime date = new DateTime.now();
  String? selectedcard;

  final List<String> _card = [
    'CreditCard',
    'DebitCard',
  ];

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
    return BlocBuilder<CardBloc, CardState>(
      builder: (context, state) {
        if (state is CardLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CardSuccessState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => const bottomNavigation(index_color: 0),
              ),
            );
          });
        }
        if (state is CardErrorState) {
          return AlertDialog(
            title: const Text('Card limit reached'),
            content: const Text(
              'You can only add 3 cards',
            ),
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // SizedBox(height: 200), // Space for the top content
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      background_top_container(context),
                    ],
                  ),
                  main_container(
                      context), // Positioned widget replaced with main_container
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Container card_show() {
    return Container(
      key: const Key('dummycarddisplay'),
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
            const Text(
              '**** **** **** ****',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: const [
                Text(
                  'Expiry Date',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              children: const [
                Text(
                  '**/**',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 14,
                ),
              ],
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              'User Name',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Container card_dropdown() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: const Color(0XFF00B686))),
      child: DropdownButton<String>(
        value: selectedcard,
        onChanged: ((value) {
          setState(() {
            selectedcard = value!;
          });
        }),
        items: _card
            .map((e) => DropdownMenuItem(
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
                  value: e,
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
          child: Text('  Card Type', style: TextStyle(color: Colors.grey)),
        ),
        dropdownColor: Colors.white,
        isExpanded: true,
        underline: Container(),
      ),
    );
  }

  Container date_time() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: const Color(0XFF00B686))),
      width: 300,
      child: TextButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now().add(const Duration(days: 30)),
              firstDate: DateTime.now().add(const Duration(days: 30)),
              lastDate: DateTime(2100));
          if (newDate == null) return;
          setState(() {
            date = newDate;
          });
        },
        child: Text(
          key: const Key('selectddate'),
          'Date : ${date.year} / ${date.month}',
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Container main_container(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        height: 520,
        width: 340,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [card_input_form(context)],
          ),
        ));
  }

  Form card_input_form(BuildContext context) {
    return Form(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 10,
      ),
      const Text(
          key: Key('instruction'),
          'Fill Your Card Details Below',
          style: TextStyle(
            color: Color(0XFF00B686),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          )),
      const SizedBox(
        height: 10,
      ),
      card_dropdown(),
      const SizedBox(
        height: 20,
      ),
      TextFormField(
          key: const Key('cardnumber'),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
            CardNumberInputFormatter(),
          ],
          controller: cardNumber,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 2, color: Color(0XFF00B686))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 2, color: Color(0XFF00838F))),
              hintText: 'Card Number',
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Image.asset(
                  'assets/images/CreditCard.png',
                  height: 20,
                  width: 20,
                ),
              ))),
      const SizedBox(
        height: 20,
      ),
      TextFormField(
          key: const Key('cvv'),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(4),
          ],
          controller: cvv,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 2, color: Color(0XFF00B686))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 2, color: Color(0XFF00838F))),
              hintText: 'CVV',
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Image.asset(
                  'assets/images/line.png',
                  height: 20,
                  width: 20,
                ),
              ))),
      const SizedBox(
        height: 20,
      ),
      const Text('Expiry Date',
          style: TextStyle(
            color: Color(0XFF00B686),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          )),
      const SizedBox(
        height: 4,
      ),
      date_time(),
      const SizedBox(
        height: 20,
      ),
      TextFormField(
          key: const Key('cardholder'),
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
            LengthLimitingTextInputFormatter(30),
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
          ],
          controller: cardHolder,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 2, color: Color(0XFF00B686))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 2, color: Color(0XFF00838F))),
              hintText: 'Card Holder',
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Icon(Icons.person),
              ))),
      const SizedBox(
        height: 20,
      ),
      AddButton(context),
    ]));
  }

  MainButton AddButton(BuildContext context) {
    return MainButton(
      key: const Key('addbutton'),
      onTap: () {
        if (selectedcard == null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Please select card type'),
                content: const Text('Card type is not selected'),
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
        } else if (cardNumber.text.length < 16) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Please enter correct card number'),
                content: const Text('Card number is not correct'),
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
        } else if (cvv.text.length < 4) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Please enter correct cvv number'),
                content: const Text('CVV number is not correct'),
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
        } else if (cardHolder.text.isEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Please enter card holder name'),
                content: const Text('Card holder name is not entered'),
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
          Random random = Random();
          String virtualNumber = '';

          for (int i = 0; i < 16; i++) {
            virtualNumber += random.nextInt(10).toString();
          }
          BlocProvider.of<CardBloc>(context).add(AddButtonPressed(CardModel(
              cardNumber: cardNumber.text,
              cardHolder: cardHolder.text,
              cardType: selectedcard!,
              cvv: cvv.text,
              expiryDate: date,
              virtualNumber: virtualNumber)));
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

  Column background_top_container(BuildContext context) {
    return Column(
      key: const Key('backgroundcontainer'),
      children: [
        Container(
          height: 210,
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
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    const SizedBox(
                      width: 100,
                    ),
                    const Text(
                        key: Key('addscreenheading'),
                        'Add Your Card',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              card_show()
            ],
          ),
        )
      ],
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldvalue, TextEditingValue newvalue) {
    if (newvalue.selection.baseOffset == 0) {
      return newvalue;
    }

    String inputData = newvalue.text;
    StringBuffer Buffer = StringBuffer();

    for (var i = 0; i < inputData.length; i++) {
      Buffer.write(inputData[i]);
      int index = i + 1;

      if (index % 4 == 0 && inputData.length != index) {
        Buffer.write(" ");
      }
    }

    return TextEditingValue(
        text: Buffer.toString(),
        selection: TextSelection.collapsed(
          offset: Buffer.toString().length,
        ));
  }
}
