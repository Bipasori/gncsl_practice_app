import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'picture_state.freezed.dart';

@freezed
class PictureState with _$PictureState {
  const factory PictureState.init() = _Init;
  const factory PictureState.loading() = _Loading;
  const factory PictureState.loaded(File imageFile) = _Loaded;
  const factory PictureState.cancel() = _Cancel;
  const factory PictureState.error(String message) = _Error;
}
