part of 'upload_images_bloc.dart';

class UploadImagesState extends Equatable {
  const UploadImagesState({this.images = const []});

  final List<XFile> images;

  UploadImagesState copyWith({List<XFile>? images}) {
    return UploadImagesState(images: images ?? this.images);
  }

  @override
  List<Object?> get props => [images];
}
