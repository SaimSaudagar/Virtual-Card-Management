import 'package:flutter/material.dart';
class AlertDialogBox extends StatelessWidget {
  const AlertDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Recovery Email Sent!'),
          content: const Text("The email to recover the password has been sent. Please check your email."),
          actions: <Widget>[
            TextButton(
              onPressed: () =>  Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () =>  Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}
