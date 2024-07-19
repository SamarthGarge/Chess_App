import 'package:flutter/material.dart';
import 'package:flutter_chess/constants.dart';
import 'package:flutter_chess/main_screens/change_password.dart';
import 'package:flutter_chess/main_screens/contact_support.dart';
import 'package:flutter_chess/main_screens/profile_screen.dart';
import 'package:flutter_chess/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          // logout button
          IconButton(
              onPressed: () {
                context
                    .read<AuthenticationProvider>()
                    .signOutUser()
                    .whenComplete(() {
                  // navigate to the login screen
                  Navigator.pushNamedAndRemoveUntil(
                      context, Constants.loginScreen, (route) => false);
                });
              },
              icon: const Icon(Icons.logout),
              ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
          
          
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Change Password'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
            },
          ),
          
          
           ListTile(
            leading: const Icon(Icons.contact_support),
            title: const Text('Contact Support'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactSupportScreen()));
            },
          ),
          
          // ListTile(
          //   leading: Icon(Icons.help),
          //   title: Text('Help Center'),
          //   onTap: () {
          //     // Navigator.push(context, MaterialPageRoute(builder: (context) => HelpCenterScreen()));
          //   },
          // ),
     ],
    ),
    );
  }
}

