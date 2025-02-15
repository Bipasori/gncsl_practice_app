import 'dart:io';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gnc_dao_envisagerapp/nft/nft.dart';

class NftRepository {
  NftRepository(this._client);
  final Dio _client;

  Future<List<NftSummaryModel>> getNftMeseum() async {
    final response = await _client.get(
      "get-nft-museum",
    );
    return (response.data["data"] as List).map((json) => NftSummaryModel.fromJson(json)).toList();
  }

  Future<String> getImageCaption({required String imageUrl}) async {
    final response = await _client.post(
      "images/caption/",
      data: {"link": imageUrl},
    );
    return (response.data["result"] as List).first as String;
  }

  Future<String> getPictureCaption({
    required File picture,
    Position? position,
  }) async {
    final response = await _client.post(
      "image/picture/",
      data: {
        "image": picture.readAsBytesSync(),
        if (position != null) "latitude": position.latitude,
        if (position != null) "longitude": position.longitude,
      },
    );
    return (response.data["result"] as List).first as String;
  }
}
