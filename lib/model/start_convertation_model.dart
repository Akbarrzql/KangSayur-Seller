// To parse this JSON data, do
//
//     final startConvertationModel = startConvertationModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

StartConvertationModel startConvertationModelFromJson(String str) => StartConvertationModel.fromJson(json.decode(str));

String startConvertationModelToJson(StartConvertationModel data) => json.encode(data.toJson());

class StartConvertationModel {
  final int status;
  final int convoId;

  StartConvertationModel({
    required this.status,
    required this.convoId,
  });

  factory StartConvertationModel.fromJson(Map<String, dynamic> json) => StartConvertationModel(
    status: json["status"],
    convoId: json["convo_id"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "convo_id": convoId,
  };
}
