// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:bloc_clean_coding/bloc/invite_bloc/invite_user_bloc.dart';
import 'package:bloc_clean_coding/configs/components/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimePicker extends StatelessWidget {
  TimePicker({super.key});

  TimeOfDay? timeOfDay = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InviteUserBloc, InviteUserState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Please select time:'),
            const Spacer(),
            NormalButton(
                text: timeOfDay != null ? timeOfDay!.toString() : 'Select Time',
                onPressed: () async {
                  final TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: timeOfDay ?? TimeOfDay.now(),
                      initialEntryMode: TimePickerEntryMode.dial);
                      timeOfDay = time;    
                  if (time != null) {
                    context
                        .read<InviteUserBloc>()
                        .add(InviteUserTime(time: time.toString()));
                  }
                  
                })
          ],
        );
      },
    );
  }
}
