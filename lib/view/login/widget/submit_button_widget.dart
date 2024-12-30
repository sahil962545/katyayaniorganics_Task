// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:bloc_clean_coding/utils/extensions/flush_bar_extension.dart';
import 'package:bloc_clean_coding/utils/extensions/general_ectensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/login_bloc/login_bloc.dart';
import '../../../configs/color/color.dart';
import '../../../configs/routes/routes_name.dart';
import '../../../utils/enums.dart';

/// A widget representing the submit button for the login form.
class SubmitButton extends StatelessWidget {
  final formKey;
  const SubmitButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    var height = context.mediaQueryHeight;  
    var width = context.mediaQueryWidth;
    return BlocListener<LoginBloc, LoginStates>(
      listenWhen: (current, previous) => current.postApiStatus != previous.postApiStatus,
      listener: (context, state) {
        if (state.postApiStatus == PostApiStatus.error) {
          context.flushBarErrorMessage(message: state.message.toString());
        }

        if (state.postApiStatus == PostApiStatus.success) {
          Navigator.pushNamedAndRemoveUntil(context, RoutesName.userScreen, (route) => false);
        }
      },
      child: BlocBuilder<LoginBloc, LoginStates>(
          buildWhen: (current, previous) => current.postApiStatus != previous.postApiStatus,
          builder: (context, state) {
            return SizedBox(
              width: width*0.9,
              height: height*0.05,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: tsawBlue
                ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    if (formKey.currentState.validate()) {
                      context.read<LoginBloc>().add(LoginApi());
                    }
                  },
                  child: state.postApiStatus == PostApiStatus.loading ? const CircularProgressIndicator(
                    color: Colors.white,
                  ) : const Text('Login' , style: TextStyle(
                    color: Colors.white
                  ),)),
            );
          }),
    );
  }
}
