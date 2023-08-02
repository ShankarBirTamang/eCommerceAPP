// ignore_for_file: avoid_print

import 'dart:io';

import 'package:e_commerce/services/config.dart';
import 'package:flutter/services.dart' as my_bundle;
import 'package:e_commerce/models/sneakers_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

// This class fetches the data from the JSON file and return it to the app

class Helper {

  Future<List<Sneakers>> getMaleSneakers() async {
    var url = Uri.http(Config.apiUrl, Config.sneakers);
    final  client = http.Client();

    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        final sneakerList = sneakersFromJson(response.body);
        var maleSneakers = sneakerList
            .where((element) => element.category == "Men's Running")
            .toList();
        return maleSneakers;
      } else {
        throw Exception(
            "Failed to get sneakers List.Status Code: ${response.statusCode}, Response: ${response.body}");
      }
    } on SocketException catch (e) {
  print('SocketException: ${e.message}');
  // Handle the socket exception, e.g., show an error to the user.
  http.Client().close();
  rethrow;
} on ClientException catch (e) {
  print('ClientException: ${e.message}');
  // Handle the client exception, e.g., show an error to the user.
  http.Client().close();
  rethrow;
} catch (e) {
  http.Client().close();
  rethrow;
  // Handle other exceptions, if any.
}
  }

  Future<List<Sneakers>> getFeMaleSneakers() async {
     var url = Uri.http(Config.apiUrl, Config.sneakers);
      final  client = http.Client();

    try {
      var response = await client.get(url);
      // final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final sneakerList = sneakersFromJson(response.body);
        var femaleSneakers = sneakerList
            .where((element) => element.category == "Women's Running")
            .toList();
        return femaleSneakers;
      } else {
        throw Exception(
            "Failed to get sneakers List.Status Code: ${response.statusCode}, Response: ${response.body}");
      }
    } catch (e) {
      http.Client().close();
      rethrow;
    }
  }

  Future<List<Sneakers>> getKidsSneakers() async {
    var url = Uri.http(Config.apiUrl, Config.sneakers);
    final client = http.Client();

    try {
      var response = await client.get(url);
      // final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final sneakerList = sneakersFromJson(response.body);
        var maleSneakers = sneakerList
            .where((element) => element.category == "Kids' Running")
            .toList();
        return maleSneakers;
      } else {
        throw Exception(
            "Failed to get sneakers List.Status Code: ${response.statusCode}, Response: ${response.body}");
      }
    } catch (e) {
      http.Client().close();
      rethrow;
    }
  }

  //Single Men
  Future<Sneakers> getMaleSneakersbyID(String id) async {
    final data =
        await my_bundle.rootBundle.loadString("assets/json/men_shoes.json");

    final maleList = sneakersFromJson(data);
    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }

  //Single Women
  Future<Sneakers> getFemaleSneakersbyID(String id) async {
    final data =
        await my_bundle.rootBundle.loadString("assets/json/women_shoes.json");

    final femaleList = sneakersFromJson(data);
    final sneaker = femaleList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }

  //Single Kids
  Future<Sneakers> getKidsSneakersbyID(String id) async {
    final data =
        await my_bundle.rootBundle.loadString("assets/json/kids_shoes.json");

    final maleList = sneakersFromJson(data);
    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }
}
