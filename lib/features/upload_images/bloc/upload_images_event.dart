part of 'upload_images_bloc.dart';

abstract class UploadImagesEvent extends Equatable {
  const UploadImagesEvent();

  @override
  List<Object?> get props => [];
}

class TakePhotoEvent extends UploadImagesEvent {
  const TakePhotoEvent();
}

class ChooseGalleryEvent extends UploadImagesEvent {
  const ChooseGalleryEvent();
}

class RemoveImageEvent extends UploadImagesEvent {
  final int index;

  const RemoveImageEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class SubmitImagesEvent extends UploadImagesEvent {
  const SubmitImagesEvent();
}
