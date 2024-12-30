import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/signup_bloc/signup_bloc.dart';
// Importing app localizations for translated text


/// A widget representing the email input field.
class NameInput extends StatelessWidget {
  const NameInput({super.key, required this.focusNode});

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
            icon: Icon(Icons.person), // Icon for email input field
            labelText: 'Name', // Label text for email input field
          ),
          keyboardType: TextInputType.name, // Setting keyboard type to email address
          onChanged: (value) {
            context.read<SignupBloc>().add(NameChanged(name: value));
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter Name';
            }
            return null;
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}
