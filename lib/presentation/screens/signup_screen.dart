import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bussiness_logic/signing_bloc/cubit.dart';
import '../../bussiness_logic/signing_bloc/states.dart';
import '../../shared/navigate.dart';
import '../../shared/styels.dart';
import '../components/custom_elevated_button.dart';
import '../components/custom_textField.dart';
import '../components/hight_sized_box.dart';
import '../components/toast_with_icon.dart';
import 'signin_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: BlocConsumer<SingingCubit, SigningStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessgState) {
            showToast(
                msg: 'Account Created Successfully',
                state: ToastStates.SUCCRSS);
            navigateAndFinish(context, const SigninScreen());
          } else if (state is CreateUserErrorState) {
            showToast(
                msg: 'This user is enterd before', state: ToastStates.ERROR);
          }
        },
        builder: (context, state) => Scaffold(
            backgroundColor: Colors.grey.shade200,
            body: Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .69,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'CREATE ACCOUNT',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: primaryColor),
                              ),
                              const HightSizedBox(height: 0.05),
                              CustomTextField(
                                  isName: true,
                                  hint: 'Enter Your username',
                                  prefixIcon: Icons.person_rounded,
                                  controller: emailController,
                                  error: 'Please Enter username'),
                              const HightSizedBox(height: 0.015),
                              CustomTextField(
                                  isPassword: true,
                                  hint: 'Enter Your Password',
                                  prefixIcon: Icons.lock,
                                  controller: passwordController,
                                  error: 'Please Enter Your Password'),
                              const HightSizedBox(height: 0.015),
                              CustomTextField(
                                  isPassword: true,
                                  hint: 'Confirm Password',
                                  prefixIcon: Icons.lock,
                                  controller: confirmPasswordController,
                                  error: 'Confirm Password'),
                              const HightSizedBox(height: 0.03),
                              state is CreateUserLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : CustomElevatedButton(
                                      fontSize: 20,
                                      text: 'SinUp',
                                      color: primaryColor,
                                      horizantalValue: 70,
                                      onPressed: () {
                                        if (formKey.currentState!.validate() &&
                                            passwordController.text ==
                                                confirmPasswordController
                                                    .text) {
                                          SingingCubit.get(context)
                                              .createNewUser(
                                                  userEmail:
                                                      emailController.text,
                                                  password:
                                                      passwordController.text);
                                        } else if (formKey.currentState!
                                                .validate() &&
                                            passwordController.text !=
                                                confirmPasswordController
                                                    .text) {
                                          showToast(
                                              msg:
                                                  'The password is not the same',
                                              state: ToastStates.ERROR);
                                        }
                                      }),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Do you have an account ?'),
                                  TextButton(
                                      onPressed: () => navigateAndFinish(
                                          context, const SigninScreen()),
                                      child: const Text('Signin'))
                                ],
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
