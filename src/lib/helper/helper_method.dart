import 'package:cloud_firestore/cloud_firestore.dart';


String formatData(Timestamp timestamp){
  DateTime dateTime =timestamp.toDate();

  String year= dateTime.year.toString();

  String month = dateTime.month.toString();

  String day = dateTime.day.toString();

  String minute = dateTime.minute.toString();
 
   String hour= dateTime.hour.toString();

  String formatedDate = '$hour:$minute $day/$month/$year';

  return formatedDate;
}