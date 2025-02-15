import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gnc_dao_envisagerapp/common/common.dart';

part 'nft_summary_model.freezed.dart';
part 'nft_summary_model.g.dart';

@freezed
class NftSummaryModel with _$NftSummaryModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory NftSummaryModel({
    required int id,
    required String tokenName,
    required int tokenId,
    required String tokenidUri,
    required String imageUrl,
    required String artistName,
    required String qrcodeUrl,
    @JsonKey(fromJson: NftSummaryModel.soldFlagFromJson) required bool soldFlag,
  }) = _NftSummaryModel;

  factory NftSummaryModel.fromJson(Json json) => _$NftSummaryModelFromJson(json);
  
  static bool soldFlagFromJson(data) => data == "0";
}
