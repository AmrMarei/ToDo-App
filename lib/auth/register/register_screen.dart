import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_color.dart';
import 'package:todo_app/auth/register/custom_text_form_field.dart';
import 'package:todo_app/dialog_utils.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/home/home_screen.dart';
import 'package:todo_app/model/my_user.dart';
import 'package:todo_app/provider/auth_user_provider.dart';

class RegisterScreen extends StatelessWidget {
  static const String RoutName = 'register_screen';
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
            title: Text('Create Account'),
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
                  CustomTextFormField(
                    label: 'User Name ',
                    controller: nameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter User Name';
                      }
                      return null;
                    },
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
                  CustomTextFormField(
                    label: 'Confirm Password',
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter Confirm Password';
                      }
                      if (text != passwordController.text) {
                        return "Confirm Password doesn't Match.";
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          register(context);
                        },
                        child: Text(
                          'Create Account',
                          style: Theme.of(context).textTheme.titleLarge,
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void register(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context: context, message: 'Loading...');
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text);
        var authProvider =
            Provider.of<AuthUserProvider>(context, listen: false);
        authProvider.updateUser(myUser);
        await FirebaseUtils.addUserToFireStore(myUser);
        DialogUtils.hideDialog(context);
        DialogUtils.showMessage(
            context: context,
            content: 'Register Successfully',
            posActionName: 'Ok',
            title: Icon(Icons.check_circle_outline_outlined,
                color: Colors.green, size: 35),
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routName);
            });
        print('Register Successfully.');
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideDialog(context);
          DialogUtils.showMessage(
              context: context,
              content: 'The password provided is too weak',
              posActionName: 'Ok',
              title: Text(
                'Error!',
                style: TextStyle(color: Colors.black),
              ));
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideDialog(context);
          DialogUtils.showMessage(
              context: context,
              content: 'The account already exists for that email.',
              posActionName: 'Ok',
              title: Text(
                'Error!',
                style: TextStyle(color: Colors.black),
              ));
          print('The account already exists for that email.');
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
            title: Text(
              'Error!',
              style: TextStyle(color: Colors.black),
            ));
        print(e);
      }
    }
  }
}
