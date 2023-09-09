import 'package:flutter/material.dart';

class NoteFieldWidget extends StatefulWidget {
  NoteFieldWidget({Key? key, required this.noteController}) : super(key: key);
  final TextEditingController noteController;
  @override
  State<NoteFieldWidget> createState() => _NoteFieldWidgetState();
}

class _NoteFieldWidgetState extends State<NoteFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.noteController,
      maxLines: 4, // Allows unlimited lines of text
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        hintText: 'Note for service (optional)',
        border: OutlineInputBorder(),
      ),
    );
  }
}
