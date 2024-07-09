import 'package:flutter/material.dart';
import 'package:flutter_chess/constants.dart';
import 'package:flutter_chess/helper/helper_methods.dart';
import 'package:flutter_chess/service/assets_manager.dart';
import 'package:flutter_chess/widgets/main_auth_button.dart';
import 'package:flutter_chess/widgets/social_button.dart';
import 'package:flutter_chess/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 15,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(AssetsManager.chessIcon),
                ),
            
                const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
            
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: textFormDecoration.copyWith(
                    labelText: 'Enter your Email',
                    hintText: 'Enter your Email',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: textFormDecoration.copyWith(
                    labelText: 'Enter your Password',
                    hintText: 'Enter your Password',
                  ),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // forgot password method here
                    },
                    child: const Text('Forgot Password ?'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MainAuthButton(
                  lable: 'LOGIN',
                  onPressed: () {
                    // login the user with Email and password
                  },
                  fontSize: 24.0,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '- OR - \n Sign in with',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialButton(
                      label: 'Guest',
                      assetImage: AssetsManager.userIcon,
                      height: 55.0,
                      width: 55.0,
                      onTap: () {},
                    ),
                    SocialButton(
                      label: 'Google',
                      assetImage: AssetsManager.googleIcon,
                      height: 55.0,
                      width: 55.0,
                      onTap: () {},
                    ),
                    SocialButton(
                      label: 'Facebook',
                      assetImage: AssetsManager.facebookIcon,
                      height: 55.0,
                      width: 55.0,
                      onTap: () {},
                    ),
                  ],
                ),
            
                const SizedBox(
                  height: 40,
                ),
            
                HaveAccountWidget(
                  label: 'Don\'t have an account?', 
                  labelAction: 'Sign Up', 
                  onPressed: (){
                      // navigate to sign up screen
                  Navigator.pushNamed(context, Constants.signUpScreen);
                   },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


