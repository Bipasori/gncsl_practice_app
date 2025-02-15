import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_check_state.freezed.dart';

@freezed
class UpdateCheckState with _$UpdateCheckState {
  const factory UpdateCheckState.init() = _Init;
  const factory UpdateCheckState.loading() = _Loading;
  const factory UpdateCheckState.lastest(String version) = _Lastest;
  const factory UpdateCheckState.old(String version, String newVersion) = _Old;
  const factory UpdateCheckState.error(String message) = _Error;
}
