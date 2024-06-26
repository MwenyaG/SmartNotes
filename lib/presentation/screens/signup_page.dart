import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/bloc/auth/authentication_cubit.dart';
import 'package:todo_app/bloc/connectivity/connectivity_cubit.dart';
import 'package:todo_app/presentation/widgets/mybutton.dart';
import 'package:todo_app/presentation/widgets/myindicator.dart';
import 'package:todo_app/presentation/widgets/mysnackbar.dart';
import 'package:todo_app/presentation/widgets/mytextfield.dart';
import 'package:todo_app/shared/constants/assets_path.dart';
import 'package:todo_app/shared/constants/strings.dart';
import 'package:todo_app/shared/styles/colors.dart';
import 'package:todo_app/shared/validators.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namecontroller;
  late TextEditingController _emailcontroller;
  late TextEditingController _passwordcontroller;

  @override
  void initState() {
    super.initState();
    _namecontroller = TextEditingController();
    _emailcontroller = TextEditingController();
    _passwordcontroller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _namecontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationCubit authcubit = BlocProvider.of(context);
    ConnectivityCubit connectivitycubit = BlocProvider.of(context);
    return Scaffold(
      backgroundColor: Appcolors.white,
      appBar: AppBar(
        backgroundColor: Appcolors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: Appcolors.black,
            size: 30,
          ),
        ),
      ),
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationErrortate) {
            // Showing the error message if the user has entered invalid credentials
            MySnackBar.error(
                message: state.error.toString(),
                color: Colors.red,
                context: context);
          }

          if (state is AuthenticationSuccessState) {
            Navigator.pushReplacementNamed(context, homepage);
          }
        },
        builder: (context, state) {
          if (state is AuthenticationLoadingState) {
            return const MyCircularIndicator();
          }
          if (state is! AuthenticationSuccessState) {
            return SafeArea(
                child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Form(
                  key: _formKey,
                  child: BounceInDown(
                    duration: const Duration(milliseconds: 1500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi There!',
                          style:
                              Theme.of(context).textTheme.headline2?.copyWith(
                                    fontSize: 20.sp,
                                    letterSpacing: 2,
                                  ),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          'Lets get you started with an account',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                  fontSize: 12.sp,
                                  letterSpacing: 1,
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        MyTextfield(
                          hint: 'Full Name',
                          icon: Icons.person_add_alt,
                          keyboardtype: TextInputType.name,
                          validator: (value) {
                            return value!.length < 3 ? 'This is not a valid name' : null;
                          },
                          textEditingController: _namecontroller,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        MyTextfield(
                          hint: 'Email Address',
                          icon: Icons.alternate_email_outlined,
                          keyboardtype: TextInputType.emailAddress,
                          validator: (value) {
                            return !Validators.isValidEmail(value!)
                                ? 'Enter a valid email'
                                : null;
                          },
                          textEditingController: _emailcontroller,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        MyTextfield(
                          hint: 'Password',
                          icon: Icons.keyboard_alt,
                          obscure: true,
                          keyboardtype: TextInputType.text,
                          validator: (value) {
                            return value!.length < 6
                                ? "Enter min. 6 characters"
                                : null;
                          },
                          textEditingController: _passwordcontroller,
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        MyButton(
                          color: Colors.grey,
                          width: 80.w,
                          title: 'Sign Up',
                          func: () {
                            if (connectivitycubit.state
                                is ConnectivityOnlineState) {
                              _signupewithemailandpass(context, authcubit);
                            } else {
                              MySnackBar.error(
                                  message:
                                      'There is something wrong with your internet',
                                  color: Colors.red,
                                  context: context);
                            }
                          },
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already signed in ?',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                      fontSize: 8.sp,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, loginpage);
                              },
                              child: Text(
                                'Login',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(
                                      fontSize: 9.sp,
                                      color: Colors.deepPurple,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _myDivider(),
                            const SizedBox(
                              width: 15,
                            ),


                            _myDivider(),
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                if (connectivitycubit.state
                                    is ConnectivityOnlineState) {
                                  authcubit.googleSignIn();
                                } else {
                                  MySnackBar.error(
                                      message:
                                          'Please Check Your Internet Conection',
                                      color: Colors.red,
                                      context: context);
                                }
                              },
                              child: Image.asset(
                                MyAssets.googleicon,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    'Authentication error',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                            fontSize: 11.sp,
                                            color: Appcolors.white),
                                  ),
                                  backgroundColor: Colors.red,
                                ));
                              },
                              child: Image.asset(
                                MyAssets.facebookicon,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
          }
          return Container();
        },
      ),
    );
  }

  Container _myDivider() {
    return Container(
      width: 27.w,
      height: 0.2.h,
      color: Appcolors.black,
    );
  }

  void _signupewithemailandpass(context, AuthenticationCubit cubit) {
    if (_formKey.currentState!.validate()) {
      cubit.register(
          fullname: _namecontroller.text,
          email: _emailcontroller.text,
          password: _passwordcontroller.text);
    }
  }
}
