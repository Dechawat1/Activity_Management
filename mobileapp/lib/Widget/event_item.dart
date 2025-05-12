import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/event.dart';

class EventItem extends StatelessWidget {
  final Event event;
  final Function() onDelete;
  final Function()? onTap;
  const EventItem({
    Key? key,
    required this.event,
    required this.onDelete,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(event.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
      ),
      leading: Icon(CupertinoIcons.clock_solid,color: Colors.orange.shade400,size: 25,),
      subtitle: Text( DateFormat('EEEE, dd MMMM,yyyy').format(event.date),style:TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Colors.white),),
      onTap: onTap,
      trailing: IconButton(
        icon: const Icon(Icons.delete,color: Colors.red,),
        onPressed: onDelete,
      ),
    );

  }
}