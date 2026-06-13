import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:image_picker/image_picker.dart';

part 'upload_images_event.dart';
part 'upload_images_state.dart';

class UploadImagesBloc extends Bloc<UploadImagesEvent, UploadImagesState> {
  final ImagePicker _picker = ImagePicker();

  UploadImagesBloc() : super(const UploadImagesState()) {
    on<TakePhotoEvent>(_onTakePhoto);
    on<ChooseGalleryEvent>(_onChooseGallery);
    on<RemoveImageEvent>(_onRemoveImage);
  }

  Future<void> _onTakePhoto(
    TakePhotoEvent event,
    Emitter<UploadImagesState> emit,
  ) async {
    if (state.images.length >= 3) {
      Fluttertoast.showToast(msg: 'msg_max_images_reached'.tr);
      return;
    }

    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo == null) return;

      final updatedImages = List<XFile>.from(state.images)..add(photo);
      emit(state.copyWith(images: updatedImages));
    } catch (_) {
      Fluttertoast.showToast(msg: 'msg_failed_to_take_photo'.tr);
    }
  }

  Future<void> _onChooseGallery(
    ChooseGalleryEvent event,
    Emitter<UploadImagesState> emit,
  ) async {
    if (state.images.length >= 3) {
      Fluttertoast.showToast(msg: 'msg_max_images_reached'.tr);
      return;
    }

    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles.isEmpty) return;

      final updatedImages = List<XFile>.from(state.images);
      for (final file in pickedFiles) {
        if (updatedImages.length >= 3) {
          Fluttertoast.showToast(msg: 'msg_max_images_reached'.tr);
          break;
        }
        updatedImages.add(file);
      }

      emit(state.copyWith(images: updatedImages));
    } catch (_) {
      Fluttertoast.showToast(msg: 'msg_failed_to_pick_images'.tr);
    }
  }

  void _onRemoveImage(
    RemoveImageEvent event,
    Emitter<UploadImagesState> emit,
  ) {
    if (event.index < 0 || event.index >= state.images.length) return;

    final updatedImages = List<XFile>.from(state.images);
    updatedImages.removeAt(event.index);
    emit(state.copyWith(images: updatedImages));
  }
}
