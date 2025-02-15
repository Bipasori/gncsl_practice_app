import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gnc_dao_envisagerapp/nft/nft.dart';

part 'nft_museum_get_state.freezed.dart';

@freezed
class NftMuseumGetState with _$NftMuseumGetState {
  const factory NftMuseumGetState.init() = _Init;
  const factory NftMuseumGetState.loading() = _Loading;
  const factory NftMuseumGetState.loaded(List<NftSummaryModel> nfts) = _Loaded;
  const factory NftMuseumGetState.error(String message) = _Error;
}
