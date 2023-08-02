// To parse this JSON data, do
//
//     final sneakers = sneakersFromJson(jsonString);

import 'dart:convert';

List<Sneakers> sneakersFromJson(String str) => List<Sneakers>.from(json.decode(str).map((x) => Sneakers.fromJson(x)));

String sneakersToJson(List<Sneakers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sneakers {
    final String id;
    final String sneakerId;
    final String name;
    final String category;
    final List<String> imageUrl;
    final String oldPrice;
    final List<Sizes> sizes;
    final String price;
    final String description;
    final String title;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    Sneakers({
        required this.id,
        required this.sneakerId,
        required this.name,
        required this.category,
        required this.imageUrl,
        required this.oldPrice,
        required this.sizes,
        required this.price,
        required this.description,
        required this.title,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Sneakers.fromJson(Map<String, dynamic> json) => Sneakers(
        id: json["_id"],
        sneakerId: json["id"],
        name: json["name"],
        category: json["category"],
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        oldPrice: json["oldPrice"],
        sizes: List<Sizes>.from(json["sizes"].map((x) => Sizes.fromJson(x))),
        price: json["price"],
        description: json["description"],
        title: json["title"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "id": sneakerId,
        "name": name,
        "category": category,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        "oldPrice": oldPrice,
        "sizes": List<dynamic>.from(sizes.map((x) => x.toJson())),
        "price": price,
        "description": description,
        "title": title,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class Sizes {
    final String size;
    final String id;

    Sizes({
        required this.size,
        required this.id,
    });

    factory Sizes.fromJson(Map<String, dynamic> json) => Sizes(
        size: json["size"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "size": size,
        "_id": id,
    };
}
