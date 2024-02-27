import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Function.dart';
import 'RestraurantDetail.dart';


class RestaurantSearch extends StatefulWidget {
  Position UserGPS;
  double SearchDistance;

  RestaurantSearch({required this.UserGPS, required this.SearchDistance, Key? key}) : super(key: key);

  @override
  _RestaurantSearchState createState() => _RestaurantSearchState();
}

class _RestaurantSearchState extends State<RestaurantSearch> {
  late SharedPreferences UserPrefs;
  List<dynamic> ApplyRestaurants = [];
  bool ResturantGetFlag = true;

  void initializeData() async {
    UserPrefs = await GetSharedPreferences();
    ApplyRestaurants = await GetRestaurants(widget.SearchDistance, widget.UserGPS);
    if (mounted) {
      setState(() {
        if (ApplyRestaurants.isEmpty) {
          ResturantGetFlag = false;
        }
      });
    }
  }

  @override
  void initState(){
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Center(child: Text('検索結果'))),

      body:

        ResturantGetFlag == false ? //if(ResturantGetFlag == false)
        Center(child: Text('検索結果がありません')) :

        ApplyRestaurants.isEmpty  ? //if(ApplyRestaurants.isEmpty && ResturantGetFlag == true)
        Center(child: Text('検索中...')) :

        ListView.builder(
        itemCount: ApplyRestaurants.length,

        itemBuilder: (context, index) {
          bool isFavorite = UserPrefs.getBool(ApplyRestaurants[index]['id']) ?? false;
          RestaurantSort(ApplyRestaurants, UserPrefs);
          return Column(
            children: <Widget>[

              const Divider(
                  thickness: 1.0,
                  color: Colors.black,
              ),

              ListTile(
                title: Text(ApplyRestaurants[index]['name']),

                subtitle: Text(ApplyRestaurants[index]['address']),

                leading: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.network(
                    ApplyRestaurants[index]['photo']['mobile']['l'],
                    width: ScreenSize.width / 2,
                    height: ScreenSize.height / 9,
                  ),
                ),

                trailing: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    ToggleFavorite(index, UserPrefs, ApplyRestaurants);
                    setState(() {
                      ApplyRestaurants[index]['isFavorite'] = !isFavorite;
                    });
                  },
                ),

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RestaurantDetail(ApplyRestaurants[index]),
                    ),
                  );
                },
              ),

            ],
          );
        },
      ),
    );
  }
}