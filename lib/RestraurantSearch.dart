import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:restran/Widget.dart';
import 'RestraurantResult.dart';
import 'Function.dart';


class RestraurantSearch extends StatefulWidget {
  @override
  _RestraurantSearch createState() => _RestraurantSearch();
}

class _RestraurantSearch extends State<RestraurantSearch>{
  bool IsLocation = false;
  bool IsPermission = false;
  Position? GetPosition;
  double DistanceValue = 3;

  @override
  void initState() {
    super.initState();
    CheckLocationPermission();
  }

  // setStateを使う関数たちなのでここで宣言
  void ChangeSlider(double e){
    setState(() { DistanceValue = e.roundToDouble(); });
  }

  Future<void> CheckLocationPermission() async {
    var status = await Geolocator.checkPermission();
    if (status == LocationPermission.always || status == LocationPermission.whileInUse) {
      setState(() { IsPermission = true; });
      await UpdateLocation();
    } else {
      await RequestLocationPermission();
    }
  }

  Future<void> RequestLocationPermission() async {
    var permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      setState(() { IsPermission = true; });
      await UpdateLocation();
    }
  }

  Future<void> UpdateLocation() async {
    var pos = await GetUserPosition();
    setState(() {
      IsLocation = true;
      GetPosition = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Center(child: Text('トップページ')),
      ),

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(height: ScreenSize.height / 20),

            GetLocationAndPermissionText(IsLocation, IsPermission),

            SizedBox(height: ScreenSize.height / 20),

            Text('距離はどうする？'),

            SizedBox(height: ScreenSize.height / 20),

            SliderWidget(DistanceValue, ChangeSlider),

            Text(GetDistanceText(DistanceValue)),

            SizedBox(height: ScreenSize.height / 20),

            Container(

              height: ScreenSize.height / 3,

              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return CheckboxListTile(
                    title: Text(CheckListValue[index]),
                    value: RestrauntFavoriteList[index],
                    onChanged: (bool? DistanceValue) {
                      setState(() {
                        RestrauntFavoriteList[index] = DistanceValue!;
                      });
                    },
                  );
                },

                separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.black),

                itemCount: CheckListValue.length
              ),
            ),

            SizedBox(height: ScreenSize.height / 20),

            TextButton(
              child: GetLocationAndPermissionButtonText(IsLocation, IsPermission),
              onPressed: (){
                if(IsLocation){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RestaurantSearch(UserGPS: GetPosition!, SearchDistance: DistanceValue)),
                  );
                }
              },
            ),

            SizedBox(height: ScreenSize.height / 20),

            RecruitUrlImage(),

          ],
        ),
      )
    );
  }
}
