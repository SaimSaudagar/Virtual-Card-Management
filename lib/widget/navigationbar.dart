import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      // primary: const Color.fromARGB(255, 51, 50, 50),
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          margin: EdgeInsets.only(bottom: 1.0),
          arrowColor: Colors.black,
          accountName: const Text('Syeda Maham Jafri',
              style: TextStyle(fontSize: 15.0, color: Colors.black)),
          accountEmail: const Text('smjafri2002@gmail.com',
              style: TextStyle(fontSize: 15.0, color: Colors.black)),
          currentAccountPicture: CircleAvatar(
              child: ClipOval(
                  child: Image.network(
            'https://cdn5.vectorstock.com/i/1000x1000/01/69/businesswoman-character-avatar-icon-vector-12800169.jpg',
            height: 90,
            width: 90,
            fit: BoxFit.cover,
          ))),
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(
                'https://static.vecteezy.com/system/resources/previews/000/140/571/original/lowpoly-grey-gradient-vector.png'),
            fit: BoxFit.cover,
          )),
        ),
        ListTile(
          tileColor: Colors.grey,
          leading: const Icon(Icons.favorite, color: Colors.black),
          title:
              const Text('Favourites', style: TextStyle(color: Colors.black)),
          onTap: () => null,
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          tileColor: Colors.grey,
          leading: const Icon(Icons.add, color: Colors.black),
          title: const Text('Add', style: TextStyle(color: Colors.black)),
          onTap: () => null,
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          tileColor: Colors.grey,
          leading: const Icon(Icons.update, color: Colors.black),
          title: const Text('Update', style: TextStyle(color: Colors.black)),
          onTap: () => null,
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          tileColor: Colors.grey,
          leading: const Icon(Icons.help, color: Colors.black),
          title: const Text('Help', style: TextStyle(color: Colors.black)),
          onTap: () => null,
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          tileColor: Colors.grey,
          leading: const Icon(Icons.settings, color: Colors.black),
          title: const Text('Settings', style: TextStyle(color: Colors.black)),
          onTap: () => null,
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          tileColor: Colors.grey,
          leading: const Icon(Icons.description, color: Colors.black),
          title: const Text('Policies', style: TextStyle(color: Colors.black)),
          onTap: () => null,
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          tileColor: Colors.grey,
          leading: const Icon(Icons.exit_to_app, color: Colors.black),
          title: const Text('Exit', style: TextStyle(color: Colors.black)),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Exit'),
                  content: const Text('Are you sure you want to exit?'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Continue'),
                      onPressed: () {
                        //signout from the user account
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        const Divider(
          height: 1,
        ),
        ListTile(
          tileColor: Colors.grey,
          onTap: () => null,
        ),
        const Divider(
          height: 1,
        ),
        ListTile(
          tileColor: Colors.grey,
          onTap: () => null,
        ),
        const Divider(
          height: 1,
        ),
        ListTile(
          tileColor: Colors.grey,
          onTap: () => null,
        ),
        const Divider(
          height: 1,
        ),
        ListTile(
          tileColor: Colors.grey,
          onTap: () => null,
        ),
        const Divider(
          height: 1,
        ),
        ListTile(
          tileColor: Colors.grey,
          onTap: () => null,
        ),
      ],
    ));
  }
}
