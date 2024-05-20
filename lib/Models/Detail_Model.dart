// To parse this JSON data, do
//
//     final details = detailsFromJson(jsonString);

import 'dart:convert';

List<Details> detailsFromJson(String str) =>
    List<Details>.from(json.decode(str).map((x) => Details.fromJson(x)));

String detailsToJson(List<Details> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Details {
  String id;
  String title;
  String ingredients;
  String description;
  String nutrients;
  int v;

  Details({
    required this.id,
    required this.title,
    required this.ingredients,
    required this.description,
    required this.nutrients,
    required this.v,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["_id"],
        title: json["Title"],
        ingredients: json["Ingredients"],
        description: json["Description"],
        nutrients: json["Nutrients"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "Title": title,
        "Ingredients": ingredients,
        "Description": description,
        "Nutrients": nutrients,
        "__v": v,
      };
}
