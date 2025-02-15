import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_caption_get_state.freezed.dart';

@freezed
class ImageCaptionGetState with _$ImageCaptionGetState {
  const factory ImageCaptionGetState.init() = _Init;
  const factory ImageCaptionGetState.loading() = _Loading;
  const factory ImageCaptionGetState.loaded(String caption) = _Loaded;
  const factory ImageCaptionGetState.error(String message) = _Error;
}