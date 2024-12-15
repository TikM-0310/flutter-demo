// ignore_for_file: sort_child_properties_last, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Todotitle extends StatelessWidget {
  final String taskName;
  final bool taskCheck;
  Function(bool?)? onchanged;
  Function(BuildContext)? deleteFunction;

  Todotitle({
    super.key,
    required this.taskName,
    required this.taskCheck,
    required this.onchanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25,right: 25,top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(), 
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ]),
        child: Container(
          padding: EdgeInsets.all(24.0),
          child: Row(
            children: [
              Checkbox(
                value: taskCheck, 
                onChanged: onchanged,
                activeColor: Colors.black,
              ),
              Text(
                taskName,
                style: TextStyle(decoration: taskCheck ? TextDecoration.lineThrough : TextDecoration.none),
              )
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.yellow, 
              borderRadius: BorderRadius.circular(12)
          ),
        ),
      ),
    );
  }
}
