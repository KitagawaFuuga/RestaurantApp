import 'package:flutter/material.dart';
import 'package:restran/Function.dart';

Widget PrintText(dynamic restaurant){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('店名: ${restaurant['name']}',style: TextStyle(fontSize: FontSizeMedium)),
      Text('住所: ${restaurant['address']}',style: TextStyle(fontSize: FontSizeMedium)),
      Text('営業時間: ${restaurant['open']}',style: TextStyle(fontSize: FontSizeMedium)),
      Text('カード利用: ${restaurant['card']}',style: TextStyle(fontSize: FontSizeMedium)),
      Text('禁煙・喫煙: ${restaurant['non_smoking']}',style: TextStyle(fontSize: FontSizeMedium)),
      Text('子ども連れ: ${restaurant['child']}',style: TextStyle(fontSize: FontSizeMedium)),
      Text('wifi: ${restaurant['wifi']}',style: TextStyle(fontSize: FontSizeMedium)),
      Text('個室: ${restaurant['private_room']}',style: TextStyle(fontSize: FontSizeMedium)),
      Text('価格帯: ${restaurant['budget']['name']}',style: TextStyle(fontSize: FontSizeMedium)),
    ]
  );
}

Widget GetLocationAndPermissionText(bool isLocation, isPermission){
  return Text(
    (isLocation && isPermission) ? '位置情報を取得しました' :
                   isPermission  ? '位置情報を取得できるまで少々お待ちください。':
                                   '位置情報を取得できません。再起動して位置情報の利用を許可してください。',
    style: TextStyle(fontSize: FontSizeMedium),
  );
}

Widget GetLocationAndPermissionButtonText(bool isLocation, isPermission){
  return Text(
    (isLocation && isPermission) ? 'さあ、検索しよう！これをクリック！' : 
                   isPermission  ? '位置情報が取れるまで待ってね。':
                                   '位置情報の利用を許可してね。',
    style: TextStyle(fontSize: FontSizeBig),
  );
}

Widget SliderWidget(double value, Function(double) changeSlider){
  return Slider(
    min: 1,
    max: 5,
    divisions: 4,
    value: value,
    onChanged: changeSlider
  );
}
