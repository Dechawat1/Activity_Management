import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/style/app_style.dart';

Widget noteCard(Function()? ontap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: ontap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[doc['color_id']],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(doc["note_title"],
            style: AppStyle.mainTitle,
          ),
          Text(doc["creation_date"],
            style: AppStyle.dateTitle,
          ),
          Text(doc["note_content"],
            style: AppStyle.mainContent,
          ),
        ],
      ),
    ),
  );
}