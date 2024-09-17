import 'package:flutter/material.dart';
import 'package:winter_gemini_ai/model/message.dart';

class MessaegItem extends StatelessWidget {
  const MessaegItem({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: message.isUser
          ? const EdgeInsets.only(left: 32)
          : const EdgeInsets.only(right: 32),
      child: ListTile(
        title: Align(
          alignment:
              message.isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: message.isUser
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
                  borderRadius: message.isUser
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20))
                      : const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
              child: Text(message.text.trim(),
                  style: message.isUser
                      ? Theme.of(context).textTheme.bodyMedium
                      : Theme.of(context).textTheme.bodySmall)),
        ),
      ),
    );
  }
}
