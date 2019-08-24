import 'dart:typed_data';
import 'dart:convert';
import 'package:intl/intl.dart';


Uint8List convertToImage(String encodedImage){
  Uint8List bytes = base64Decode(encodedImage);
  return bytes;
}

String formatDate(String date){
  DateTime dateTime = DateTime.parse(date);
  DateFormat dateFormat = DateFormat("MMMM dd, yyyy 'at' hh:mm a");
  return dateFormat.format(dateTime);

}