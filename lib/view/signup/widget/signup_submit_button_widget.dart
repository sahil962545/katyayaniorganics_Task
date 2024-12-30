// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:bloc_clean_coding/bloc/signup_bloc/signup_bloc.dart';
import 'package:bloc_clean_coding/configs/color/color.dart';
import 'package:bloc_clean_coding/utils/extensions/flush_bar_extension.dart';
import 'package:bloc_clean_coding/utils/extensions/general_ectensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../configs/routes/routes_name.dart';
import '../../../utils/enums.dart';

class SubmitButtonSignup extends StatelessWidget {
  final formKey;
  const SubmitButtonSignup({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    final height = context.mediaQueryHeight;
    final width = context.mediaQueryWidth;
    return BlocListener<SignupBloc, SignupState>(
      listenWhen: (current, previous) => current.postApiStatus != previous.postApiStatus,
      listener: (context, state) {
        if (state.postApiStatus == PostApiStatus.error) {
          context.flushBarErrorMessage(message: state.message.toString());
        }

        if (state.postApiStatus == PostApiStatus.success) {
          Navigator.pushNamedAndRemoveUntil(context, RoutesName.userScreen, (route) => false);
        }
      },
      child: BlocBuilder<SignupBloc, SignupState>(
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
                    if (formKey.currentState.validate()) {
                      context.read<SignupBloc>().add(SigupApi());
                    }
                  },
                  child: state.postApiStatus == PostApiStatus.loading ? const CircularProgressIndicator(
                    color: Colors.white,
                  ) : const Text('Sign Up' , style: 
                  TextStyle(
                    color: Colors.white,
                  ),)),
            );
          }),
    );
  }
}
