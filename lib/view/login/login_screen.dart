import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login_bloc/login_bloc.dart';
import '../../main.dart';
import 'widget/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBlocs;

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loginBlocs = LoginBloc(authApiRepository: getIt());
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _loginBlocs.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => _loginBlocs,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                EmailInput(focusNode: _emailFocusNode), // Widget for email input field
                const SizedBox(height: 10),
                PasswordInput(focusNode: _passwordFocusNode), // Widget for password input field
                const SizedBox(
                  height: 10,
                ),
                SubmitButton(
                  formKey: _formKey,
                ), // Widget for submit button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
