import 'package:bloc_clean_coding/bloc/signup_bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A widget representing the password input field.
class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key, required this.focusNode});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextFormField(
          focusNode: focusNode,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Colors.black,
                width: 2
              )
            ),
            icon: Icon(Icons.lock), 
            helperText: "Password should be at least 8 characters with at least one letter and number",
            helperMaxLines: 2, 
            labelText: "Password",
            errorMaxLines: 2, 
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter password';
            }
            if (value.length < 6) {
              return 'please enter password greater than 6 char';
            }
            return null;
          },
          onChanged: (value) {
            context.read<SignupBloc>().add(PasswordChanged(password: value));
          },
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}
