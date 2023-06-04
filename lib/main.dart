import 'package:flutter/material.dart';
import 'package:project/blocs/login/loginUI.dart';
import 'package:project/google_signin.dart';
import 'package:provider/provider.dart';
import 'widget/MainButton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: const MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          home: MyHomePage(),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      body: Stack(
        children: [
          SizedBox(
            height: height / 1.3,
            child: Image.asset(
              key: Key('applogo'),
              "assets/images/applogo.png",
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: height / 2.5,
              width: double.infinity,
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        key: Key('appname'),
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'CardMate',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      const Text(
                        key: Key('catchline1'),
                        'Where Smart Spending ',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0XFF00B686),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3.0,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      const Text(
                        key: Key('catchline2'),
                        'Meets Financial Success',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0XFF00838F),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3.0,
                        ),
                      ),
                      const SizedBox(
                        height: 100.0,
                      ),
                      MainButton(
                        key: Key('getstartbutton'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => const LoginPageUI(),
                            ),
                          );
                        },
                        btncolor: const Color.fromARGB(0, 14, 14, 14),
                        text: const Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
