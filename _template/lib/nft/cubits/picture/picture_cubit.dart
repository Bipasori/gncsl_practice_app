import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnc_dao_envisagerapp/common/common.dart';
import 'package:gnc_dao_envisagerapp/nft/nft.dart';
import 'package:image_picker/image_picker.dart';

class PictureCubit extends Cubit<PictureState> {
  PictureCubit() : super(const PictureState.init());

  Future<void> getPicture() async {
    emit(const PictureState.loading());
    try {
      final picker = ImagePicker();
      final xFile = await picker.pickImage(source: ImageSource.camera);
      if (xFile == null) return emit(const PictureState.cancel());

      emit(PictureState.loaded(File(xFile.path)));
    } catch (e) {
      emit(PictureState.error(getErrorMessage(e)));
    }
  }
}
