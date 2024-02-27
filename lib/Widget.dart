import 'package:flutter/material.dart';

Widget PrintText(dynamic restaurant){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('店名: ${restaurant['name']}'),
      Text('住所: ${restaurant['address']}'),
      Text('営業時間: ${restaurant['open']}'),
      Text('カード利用: ${restaurant['card']}'),
      Text('禁煙・喫煙: ${restaurant['non_smoking']}'),
      Text('子ども連れ: ${restaurant['child']}'),
      Text('wifi: ${restaurant['wifi']}'),
      Text('個室: ${restaurant['private_room']}'),
      Text('価格帯: ${restaurant['budget']['name']}'),
    ]
  );
}

Widget GetLocationAndPermissionText(bool isLocation, isPermission){
  return Text(
    (isLocation && isPermission) ? '位置情報を取得しました' :
                   isPermission  ? '少々お待ちください。':
                                   '位置情報を取得できません。再起動して位置情報の利用を許可してください。',
  );
}

Widget GetLocationAndPermissionButtonText(bool isLocation, isPermission){
  return Text(
    (isLocation && isPermission) ? 'さあ、検索しよう！これをクリック！' : 
                   isPermission  ? '位置情報が取れるまで待ってね。':
                                   '位置情報の利用を許可してね。',
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
