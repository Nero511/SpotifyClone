import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone/common/widgets/appbar/app_bar.dart';
import 'package:spotify_clone/common/widgets/button/basic_app_button.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/presentation/auth/pages/signup.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signupText(context),
      appBar: BasicAppbar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 30
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _signinText(),
            const SizedBox(height: 70,),
            _userField(context),
            const SizedBox(height: 20,),
            _passwordField(context),
            const SizedBox(height: 50,),
            BasicAppButton(
              onPressed: (){}, 
              title: 'Sign In'
            ),
          ],
        ),
      ),
    );
  }

  Widget  _signinText() {
    return const Text(
      'Sign In',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _userField(BuildContext context){
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Enter username or email',
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme
      ),
    );
  }

  Widget _passwordField(BuildContext context){
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Password',
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme
      ),
    );
  }

  Widget _signupText(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Not a member?',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14
            ),
          ),
          TextButton(
              onPressed: (){
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (BuildContext context) => const SignupPage())
                );
              }, 
              child: const Text(
                'Register now'
              )
            )
        ],
      ),
    );
  }
}