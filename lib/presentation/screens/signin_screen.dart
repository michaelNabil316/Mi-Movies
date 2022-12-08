import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharma_tv/presentation/screens/welcome_screen.dart';
import '../../bussiness_logic/signing_bloc/cubit.dart';
import '../../bussiness_logic/signing_bloc/states.dart';
import '../../shared/cashHelper/chash_helper.dart';
import '../../shared/navigate.dart';
import '../../shared/styels.dart';
import '../components/custom_elevated_button.dart';
import '../components/custom_textField.dart';
import '../components/hight_sized_box.dart';
import '../components/toast_with_icon.dart';
import 'signup_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: BlocConsumer<SingingCubit, SigningStates>(
        listener: (context, state) {
          if (state is LoginSuccessgState) {
            CashHelper.saveData(key: 'name', value: nameController.text);
            showToast(msg: 'Signin Successfully', state: ToastStates.SUCCRSS);
            navigateAndFinish(context, const WelcomeScreen());
          }
          if (state is LoginErrorState) {
            showToast(msg: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          final singingCubit = SingingCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey.shade300,
            body: Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Material(
                      elevation: 2,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'SIGNIN',
                                style: signInStyle,
                              ),
                              const HightSizedBox(height: 0.03),
                              SizedBox(
                                  height: 450.h,
                                  child: Image.asset('assets/cinema.jpg')),
                              const HightSizedBox(height: 0.02),
                              CustomTextField(
                                isName: true,
                                hint: 'Enter Your user name',
                                prefixIcon: Icons.person_rounded,
                                controller: nameController,
                                error: 'Please Enter Your user name',
                              ),
                              const HightSizedBox(height: 0.015),
                              CustomTextField(
                                  isPassword: true,
                                  hint: 'Enter Your Password',
                                  prefixIcon: Icons.lock,
                                  controller: passwordController,
                                  error: 'Please Enter Your Password'),
                              const HightSizedBox(height: .03),
                              singingCubit.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : CustomElevatedButton(
                                      fontSize: 20,
                                      text: 'Signin',
                                      color: primaryColor,
                                      horizantalValue: 70,
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                        if (formKey.currentState!.validate()) {
                                          SingingCubit.get(context).login(
                                              name: nameController.text,
                                              password:
                                                  passwordController.text);
                                        }
                                      }),
                              const Text(
                                ' ______________ OR ______________',
                                style: TextStyle(color: Colors.black45),
                              ),
                              const HightSizedBox(height: 0.01),
                              CustomElevatedButton(
                                  fontSize: 20,
                                  text: 'SignUp',
                                  color: Colors.white,
                                  horizantalValue: 70,
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    navigateTo(context, const SignupScreen());
                                  }),
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
