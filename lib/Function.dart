import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<bool> RestrauntFavoriteList = List.generate(CheckListValue.length, (index) => false);
final List<String> CheckListValue = ['Wifiあり', '子どもOK', 'カード利用可', '個室あり'];
Size ScreenSize = Size(0, 0);
double FontSizeBig = 20;
double FontSizeMedium = 20;

Future<SharedPreferences> GetSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}

Future<dynamic> GetRestaurants(double GetDistance, Position GetGPS) async {
  String ApiKey = '932df98c4ee5d709';
  String BaseUrl = 'https://webservice.recruit.co.jp/hotpepper/gourmet/v1/';
  String Radius = GetDistance.toInt().toString();
  String Url =
      '$BaseUrl?key=$ApiKey&lat=${GetGPS.latitude.toString()}&lng=${GetGPS.longitude.toString()}&range=${Radius}&count=50&format=json';

  http.Response response = await http.get(Uri.parse(Url));

  if (response.statusCode == 200) {
    List<dynamic> allRestaurants = json.decode(response.body)['results']['shop'];
    List<dynamic> filteredRestaurants = [];

    if (RestrauntFavoriteList.any((element) => element)) {
      filteredRestaurants = List.from(allRestaurants);

      if (RestrauntFavoriteList[0]) {
        filteredRestaurants = filteredRestaurants.where((restaurant) => restaurant['wifi'] == 'あり').toList();
      }
      if (RestrauntFavoriteList[1]) {
        filteredRestaurants = filteredRestaurants.where((restaurant) => restaurant['child'] == 'お子様連れ歓迎').toList();
      }
      if (RestrauntFavoriteList[2]) {
        filteredRestaurants = filteredRestaurants.where((restaurant) => restaurant['card'] == '利用可').toList();
      }
      if (RestrauntFavoriteList[3]) {
        filteredRestaurants = filteredRestaurants.where((restaurant) => restaurant['private_room'] == 'あり').toList();
      }
    } else {
      filteredRestaurants = List.from(allRestaurants);
    }
    return filteredRestaurants;
  }
}


void ToggleFavorite(int index, SharedPreferences prefs, List<dynamic> restaurants) {
  bool isFavorite = prefs.getBool(restaurants[index]['id']) ?? false;
  prefs.setBool(restaurants[index]['id'], !isFavorite);
  restaurants[index]['isFavorite'] = !isFavorite;
  RestaurantSort(restaurants, prefs); // ここでリストを再ソート
}

void RestaurantSort(List<dynamic> restaurants, SharedPreferences prefs){
  restaurants.sort((a, b) {
    bool aFavorite = prefs.getBool(a['id']) ?? false;
    bool bFavorite = prefs.getBool(b['id']) ?? false;
    if (aFavorite && !bFavorite) {
      return -1;
    } else if (!aFavorite && bFavorite) {
      return 1;
    } else {
      return 0;
    }
  });
}

String GetDistanceText(double value) {
  switch (value.toInt()) {
    case 1:
      return '300m';
    case 2:
      return '500m';
    case 3:
      return '1000m';
    case 4:
      return '2000m';
    case 5:
      return '3000m';
    default:
      return '';
  }
}

Future<Position> GetUserPosition() async {
  bool ServiceEnabled;
  LocationPermission Permission;

  ServiceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!ServiceEnabled) {
    throw Exception('Location services are disabled.');
  }

  Permission = await Geolocator.checkPermission();
  
  if (Permission == LocationPermission.denied) {
    Permission = await Geolocator.requestPermission();
    if (Permission == LocationPermission.denied) {
      throw Exception('Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  if (Permission == LocationPermission.deniedForever) {
    throw Exception('Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}

Widget RecruitUrlImage(){
  return InkWell(
    onTap: () {
      launchUrl(Uri.parse('http://webservice.recruit.co.jp/'));
    },
    child: Image.network(
      'http://webservice.recruit.co.jp/banner/hotpepper-s.gif',
    )
  );
}