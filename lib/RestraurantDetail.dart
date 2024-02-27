import 'package:flutter/material.dart';
import 'package:restran/Function.dart';
import 'Widget.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantDetail extends StatelessWidget {
  final dynamic Restaurant;

  RestaurantDetail(this.Restaurant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          Restaurant['name'],
          overflow: TextOverflow.ellipsis, 
          maxLines: 1,
        ),
      ),
    
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Center(
            child: Image.network(Restaurant['photo']['mobile']['l']),
          ),

          Padding(
            padding: EdgeInsets.all(ScreenSize.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrintText(Restaurant),
                SizedBox(height: ScreenSize.height / 40),

                Center(child: Text('Webページに飛ぶ？')),
                SizedBox(height: ScreenSize.height / 40),

                Center(
                  child: FilledButton(
                    onPressed:() {
                      launchUrl(Uri.parse(Restaurant['urls']['pc']));
                    },

                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),

                    child: Text('Webページへ'),
                  )

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


