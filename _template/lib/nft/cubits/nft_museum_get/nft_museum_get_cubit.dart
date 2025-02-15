import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnc_dao_envisagerapp/common/common.dart';
import 'package:gnc_dao_envisagerapp/nft/nft.dart';

class NftMuseumGetCubit extends Cubit<NftMuseumGetState> {
  NftMuseumGetCubit(this._repository) : super(const NftMuseumGetState.init());
  final NftRepository _repository;
  
  Future<void> getNftMeseum() async {
    emit(const NftMuseumGetState.loading());
    try {
      final List<NftSummaryModel> nfts = await _repository.getNftMeseum();
      emit(NftMuseumGetState.loaded(nfts));
    } catch (e) {
      emit(NftMuseumGetState.error(getErrorMessage(e)));
    }
  }
}
