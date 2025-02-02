import 'package:bloc_clean_coding/bloc/signup_bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../main.dart';
import '../../utils/helper_function.dart';
import 'widget/widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late SignupBloc _signupBloc;
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    notificationService.requestNotificationPermission();
    notificationService.isTokenRefersh();
    firebaseInit(context);
    notificationService.firebaseInit();
    notificationService.getDeviceToken();
    _signupBloc = SignupBloc(authApiRepository: getIt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => _signupBloc,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                NameInput(focusNode: _nameFocusNode),
                const SizedBox(height: 10),
                SignupEmailInput(
                    focusNode: _emailFocusNode), // Widget for email input field
                const SizedBox(height: 10),
                PasswordInput(
                    focusNode:
                        _passwordFocusNode), // Widget for password input field
                 const SizedBox(
                  height: 10,
                 ),       
                SubmitButtonSignup(
                  formKey: _formKey,
                ), 
                const SizedBox(height: 10),
                const AlreadyUser()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
