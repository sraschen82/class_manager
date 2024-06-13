import 'package:asp/asp.dart';

import 'package:class_manager_two/app/comum/my_colors.dart';
import 'package:class_manager_two/app/notes/atoms/page_atoms.dart';
import 'package:class_manager_two/app/notes/pages/notespage_view.dart';
import 'package:class_manager_two/app/notes/states/note_states.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.select(() => {notesStatusAtom.value});
    return Container(
      decoration: BoxDecoration(gradient: MyColors().gradientAuth()),
      child: switch (notesStatusAtom.value) {
        (NoteStates.INITIAL) => const Center(child: Text('initial')),
        (NoteStates.HOME_PAGE) => const NotesPageView(),
        (NoteStates.LOADING) => const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          )),
        (NoteStates.ERROR) => const Center(child: Text('Error')),
      },
    );
  }
}
