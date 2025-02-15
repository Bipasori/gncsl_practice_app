import 'package:freezed_annotation/freezed_annotation.dart';

part 'picture_caption_get_state.freezed.dart';

@freezed
class PictureCaptionGetState with _$PictureCaptionGetState {
  const factory PictureCaptionGetState.init() = _Init;
  const factory PictureCaptionGetState.loading() = _Loading;
  const factory PictureCaptionGetState.loaded(String caption) = _Loaded;
  const factory PictureCaptionGetState.error(String message) = _Error;
}
