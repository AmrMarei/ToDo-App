import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_color.dart';
import 'package:todo_app/auth/register/custom_text_form_field.dart';
import 'package:todo_app/auth/register/register_screen.dart';
import 'package:todo_app/dialog_utils.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/home/home_screen.dart';

import '../../provider/auth_user_provider.dart';

class LoginScreen extends StatelessWidget {
  static const String RoutName = 'Login_Screen';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            color: AppColors.backgroundLightColor,
            child: Image.asset(
              'assets/image/background.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            )),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Login'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Welcome Back ! ',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: AppColors.blackColor),
                    ),
                  ),
                  CustomTextFormField(
                    label: 'Email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter Email';
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if (!emailValid) {
                        return 'Please enter valid Email.';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    label: 'Password',
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter Password';
                      }
                      if (text.length < 6) {
                        return 'Please should be at least 6 character';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Login(context);
                        },
                        child: Text(
                          'Login',
                          style: Theme.of(context).textTheme.titleLarge,
                        )),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(RegisterScreen.RoutName);
                      },
                      child: Text('Or Create Account')),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(color: AppColors.blackColor),
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void Login(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context: context, message: 'Waiting...');
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        var user = await FirebaseUtils.readUserFromFireStore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        var authProvider =
            Provider.of<AuthUserProvider>(context, listen: false);
        authProvider.updateUser(user);
        DialogUtils.hideDialog(context);
        DialogUtils.showMessage(
            context: context,
            content: 'Login Successfully.',
            posActionName: 'Ok',
            title: Icon(Icons.check_circle_outline_outlined,
                color: Colors.green, size: 35),
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routName);
            });
        print('Login Successfully.');
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          DialogUtils.hideDialog(context);
          DialogUtils.showMessage(
              context: context,
              content:
                  'The supplied auth credential is incorrect, malformed or has expired , you can create Account.',
              posActionName: 'Ok',
              title: Text('Error!'));
          print(
              'The supplied auth credential is incorrect, malformed or has expired.');
        } else if (e.code == 'network-request-failed') {
          DialogUtils.hideDialog(context);
          DialogUtils.showMessage(
              context: context,
              content: 'A network error!',
              posActionName: 'Ok',
              title: Text(
                'Error!',
                style: TextStyle(color: Colors.black),
              ));
          print('A network error!');
        }
      } catch (e) {
        DialogUtils.hideDialog(context);
        DialogUtils.showMessage(
            context: context,
            content: e.toString(),
            posActionName: 'Ok',
            title: Text('Error!'));
        print(e);
      }
    }
  }
}
