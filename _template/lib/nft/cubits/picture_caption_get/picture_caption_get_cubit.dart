import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnc_dao_envisagerapp/common/common.dart';
import 'package:gnc_dao_envisagerapp/nft/nft.dart';

class PictureCaptionGetCubit extends Cubit<PictureCaptionGetState> {
  PictureCaptionGetCubit(this._repository) : super(const PictureCaptionGetState.init());
  final NftRepository _repository;

  Future<void> getPictureCaption(File picture) async {
    emit(const PictureCaptionGetState.loading());
    try {
      final position = await getLocation();
      final caption = await _repository.getPictureCaption(picture: picture, position: position);
      emit(PictureCaptionGetState.loaded(caption));
    } catch (e) {
      emit(PictureCaptionGetState.error(getErrorMessage(e)));
    }
  }

  Future<Position?> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }
    if (permission == LocationPermission.deniedForever) return null;

    final position = await Geolocator.getCurrentPosition();
    return position;
  }
}
