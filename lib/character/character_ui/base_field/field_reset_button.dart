import 'package:flutter/material.dart';

class FieldResetButton extends StatelessWidget {
  const FieldResetButton({super.key, this.resetValue});

  final Function()? resetValue;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: resetValue == null
          ? null
          : () async {
              var result = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Reset Field"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "This will reset the field to the calculated value.",
                        ),
                        Text("Are you sure you want to do this?"),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text("No"),
                      ),
                      FilledButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text("Yes"),
                      ),
                    ],
                  );
                },
              );
              if (result != true) {
                return;
              }

              resetValue?.call();
            },
      icon: Icon(Icons.replay, color: ColorScheme.of(context).tertiary),
    );
  }
}
