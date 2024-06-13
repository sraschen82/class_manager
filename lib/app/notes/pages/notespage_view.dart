import 'package:asp/asp.dart';
import 'package:class_manager_two/app/home_page/atoms/page_status_atoms.dart';
import 'package:class_manager_two/app/home_page/home_page_states.dart';
import 'package:class_manager_two/app/notes/atoms/todo_atoms.dart';
import 'package:class_manager_two/app/notes/models/todomodel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotesPageView extends StatefulWidget {
  const NotesPageView({super.key});

  @override
  State<NotesPageView> createState() => _NotesPageViewState();
}

class _NotesPageViewState extends State<NotesPageView> {
  @override
  void initState() {
    super.initState();

    fetchToTodosAction();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    context.select(() => {toDoListAtom, checkAction.value});
    List<ToDoModel> inList = [];
    inList.addAll(toDoListAtom.value);
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 50, 8, 15),
      child: Column(
        children: [
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(padding: EdgeInsets.only(left: 30)),
                SizedBox(
                  child: Card(
                    color: Colors.black.withOpacity(0),
                    child: const Text(
                      'NOTES',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color.fromARGB(255, 245, 1, 1)),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      pageStatusAtom.setValue(PageStates.HOME_PAGE),
                  icon: const Icon(Icons.home),
                  alignment: Alignment.centerRight,
                ),
              ],
            ),
          ),
          const Spacer(flex: 1),
          Flexible(
            flex: 20,
            child: ReorderableListView.builder(
                itemCount: inList.length,
                onReorder: ((oldIndex, newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final item = inList.removeAt(oldIndex);
                    inList.insert(newIndex, item);
                    toDoListAtom.setValue(inList);
                  });
                  reorderListAction();
                }),
                itemBuilder: (BuildContext context, index) {
                  return Slidable(
                    key: Key('$index'),
                    startActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      closeThreshold: 0.1,
                      openThreshold: 0.1,
                      children: [
                        SlidableAction(
                          onPressed: (_) => deleteToDoAction.setValue(index),
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                          borderRadius: BorderRadius.circular(15),
                          padding: const EdgeInsets.all(8),
                        ),
                        SlidableAction(
                          onPressed: (context) => editToDoAction
                              .setValue((context: context, index: index)),
                          backgroundColor: const Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Edit',
                          borderRadius: BorderRadius.circular(15),
                          padding: const EdgeInsets.all(8),
                        ),
                      ],
                    ),
                    child: Card(
                      key: Key('$index'),
                      color: toDoListAtom.value[index].check
                          ? Colors.blueAccent[100]
                          : Colors.white,
                      child: CheckboxListTile(
                        value: toDoListAtom.value[index].check,
                        onChanged: (v) {
                          checkAction.setValue((index: index, check: v!));
                        },
                        title: Text(toDoListAtom.value[index].title,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle:
                            Text(toDoListAtom.value[index].description ?? ''),
                      ),
                    ),
                  );
                }),
          ),
          FloatingActionButton(
            onPressed: () => createNewToDoAction.setValue(context),
            backgroundColor: Colors.white,
            elevation: 30,
            child: const Icon(Icons.add, color: Colors.black),
          )
        ],
      ),
    );
  }
}
