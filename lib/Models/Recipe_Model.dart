// To parse this JSON data, do
//
//     final recipes = recipesFromJson(jsonString);

import 'dart:convert';

List<Recipes> recipesFromJson(String str) =>
    List<Recipes>.from(json.decode(str).map((x) => Recipes.fromJson(x)));

String recipesToJson(List<Recipes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Recipes {
  int id;
  String title;
  String image;
  ImageType imageType;
  int usedIngredientCount;
  int missedIngredientCount;
  List<SedIngredient> missedIngredients;
  List<SedIngredient> usedIngredients;
  List<SedIngredient> unusedIngredients;
  int likes;

  Recipes({
    required this.id,
    required this.title,
    required this.image,
    required this.imageType,
    required this.usedIngredientCount,
    required this.missedIngredientCount,
    required this.missedIngredients,
    required this.usedIngredients,
    required this.unusedIngredients,
    required this.likes,
  });

  factory Recipes.fromJson(Map<String, dynamic> json) => Recipes(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        imageType: imageTypeValues.map[json["imageType"]]!,
        usedIngredientCount: json["usedIngredientCount"],
        missedIngredientCount: json["missedIngredientCount"],
        missedIngredients: List<SedIngredient>.from(
            json["missedIngredients"].map((x) => SedIngredient.fromJson(x))),
        usedIngredients: List<SedIngredient>.from(
            json["usedIngredients"].map((x) => SedIngredient.fromJson(x))),
        unusedIngredients: List<SedIngredient>.from(
            json["unusedIngredients"].map((x) => SedIngredient.fromJson(x))),
        likes: json["likes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "imageType": imageTypeValues.reverse[imageType],
        "usedIngredientCount": usedIngredientCount,
        "missedIngredientCount": missedIngredientCount,
        "missedIngredients":
            List<dynamic>.from(missedIngredients.map((x) => x.toJson())),
        "usedIngredients":
            List<dynamic>.from(usedIngredients.map((x) => x.toJson())),
        "unusedIngredients":
            List<dynamic>.from(unusedIngredients.map((x) => x.toJson())),
        "likes": likes,
      };
}

enum ImageType { JPG, PNG }

final imageTypeValues =
    EnumValues({"jpg": ImageType.JPG, "png": ImageType.PNG});

class SedIngredient {
  int id;
  double amount;
  String unit;
  String unitLong;
  String unitShort;
  Aisle aisle;
  String name;
  String original;
  String originalName;
  List<String> meta;
  String image;
  String? extendedName;

  SedIngredient({
    required this.id,
    required this.amount,
    required this.unit,
    required this.unitLong,
    required this.unitShort,
    required this.aisle,
    required this.name,
    required this.original,
    required this.originalName,
    required this.meta,
    required this.image,
    this.extendedName,
  });

  factory SedIngredient.fromJson(Map<String, dynamic> json) => SedIngredient(
        id: json["id"],
        amount: json["amount"]?.toDouble(),
        unit: json["unit"],
        unitLong: json["unitLong"],
        unitShort: json["unitShort"],
        aisle: aisleValues.map[json["aisle"]]!,
        name: json["name"],
        original: json["original"],
        originalName: json["originalName"],
        meta: List<String>.from(json["meta"].map((x) => x)),
        image: json["image"],
        extendedName: json["extendedName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "unit": unit,
        "unitLong": unitLong,
        "unitShort": unitShort,
        "aisle": aisleValues.reverse[aisle],
        "name": name,
        "original": original,
        "originalName": originalName,
        "meta": List<dynamic>.from(meta.map((x) => x)),
        "image": image,
        "extendedName": extendedName,
      };
}

enum Aisle {
  ALCOHOLIC_BEVERAGES,
  BAKERY_BREAD,
  BAKING,
  BEVERAGES,
  CANNED_AND_JARRED,
  CEREAL,
  CHEESE,
  CONDIMENTS,
  DRIED_FRUITS,
  ETHNIC_FOODS,
  FROZEN,
  GLUTEN_FREE,
  HEALTH_FOODS,
  MEAT,
  MILK_EGGS_OTHER_DAIRY,
  NUTS,
  NUT_BUTTERS_JAMS_AND_HONEY,
  OIL_VINEGAR_SALAD_DRESSING,
  ONLINE,
  PASTA_AND_RICE,
  PRODUCE,
  REFRIGERATED,
  SAVORY_SNACKS,
  SPICES_AND_SEASONINGS,
  SWEET_SNACKS,
  TEA_AND_COFFEE
}

final aisleValues = EnumValues({
  "Alcoholic Beverages": Aisle.ALCOHOLIC_BEVERAGES,
  "Bakery/Bread": Aisle.BAKERY_BREAD,
  "Baking": Aisle.BAKING,
  "Beverages": Aisle.BEVERAGES,
  "Canned and Jarred": Aisle.CANNED_AND_JARRED,
  "Cereal": Aisle.CEREAL,
  "Cheese": Aisle.CHEESE,
  "Condiments": Aisle.CONDIMENTS,
  "Dried Fruits": Aisle.DRIED_FRUITS,
  "Ethnic Foods": Aisle.ETHNIC_FOODS,
  "Frozen": Aisle.FROZEN,
  "Gluten Free": Aisle.GLUTEN_FREE,
  "Health Foods": Aisle.HEALTH_FOODS,
  "Meat": Aisle.MEAT,
  "Milk, Eggs, Other Dairy": Aisle.MILK_EGGS_OTHER_DAIRY,
  "Nuts": Aisle.NUTS,
  "Nut butters, Jams, and Honey": Aisle.NUT_BUTTERS_JAMS_AND_HONEY,
  "Oil, Vinegar, Salad Dressing": Aisle.OIL_VINEGAR_SALAD_DRESSING,
  "Online": Aisle.ONLINE,
  "Pasta and Rice": Aisle.PASTA_AND_RICE,
  "Produce": Aisle.PRODUCE,
  "Refrigerated": Aisle.REFRIGERATED,
  "Savory Snacks": Aisle.SAVORY_SNACKS,
  "Spices and Seasonings": Aisle.SPICES_AND_SEASONINGS,
  "Sweet Snacks": Aisle.SWEET_SNACKS,
  "Tea and Coffee": Aisle.TEA_AND_COFFEE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
