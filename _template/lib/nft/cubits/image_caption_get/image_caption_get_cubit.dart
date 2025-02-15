import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnc_dao_envisagerapp/common/common.dart';
import 'package:gnc_dao_envisagerapp/nft/nft.dart';

class ImageCaptionGetCubit extends Cubit<ImageCaptionGetState> {
  ImageCaptionGetCubit(this._repository) : super(const ImageCaptionGetState.init());
  final NftRepository _repository;

  Future<void> getImageCaption(String imageUrl) async {
    emit(const ImageCaptionGetState.loading());
    try {
      final caption = await _repository.getImageCaption(imageUrl: imageUrl);
      emit(ImageCaptionGetState.loaded(caption));
    } catch (e) {
      emit(ImageCaptionGetState.error(getErrorMessage(e)));
    }
  }
}
