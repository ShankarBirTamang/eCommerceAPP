import 'package:flutter/services.dart' as my_bundle;
import 'package:e_commerce/models/sneakers_model.dart';

// This class fetches the data from the JSON file and return it to the app

class Helper {
  Future<List<Sneakers>> getMaleSneakers() async {
    final data =
        await my_bundle.rootBundle.loadString("assets/json/men_shoes.json");

    final maleList = sneakersFromJson(data);
    return maleList;
  }

  Future<List<Sneakers>> getFeMaleSneakers() async {
    final data =
        await my_bundle.rootBundle.loadString("assets/json/women_shoes.json");

    final femaleList = sneakersFromJson(data);
    return femaleList;
  }

  Future<List<Sneakers>> getKidsSneakers() async {
    final data =
        await my_bundle.rootBundle.loadString("assets/json/kids_shoes.json");

    final kidsList = sneakersFromJson(data);
    return kidsList;
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
