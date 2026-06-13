import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/upload_images/bloc/upload_images_bloc.dart';

class UploadImagesScreen extends StatelessWidget {
  const UploadImagesScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<UploadImagesBloc>(
      create: (context) => UploadImagesBloc(),
      child: const UploadImagesScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.otherBackground,
      appBar: CustomAppBar(
        title: 'lbl_upload_photo'.tr,
        centerTitle: true,
        backgroundColor: appTheme.blue900,
        toolbarHeight: 64.h,
      ),
      body: BlocBuilder<UploadImagesBloc, UploadImagesState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 20.h,
              children: [
                const _ActionButtons(),
                if (state.images.isNotEmpty)
                  ...([
                    _ImagePreviewSection(images: state.images),
                    CustomElevatedButton(
                      text: 'lbl_submit'.tr,
                      onPressed: () => Navigator.pop(context, state.images),
                    ),
                  ]),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16.w,
      children: [
        Expanded(
          child: CustomElevatedButton(
            text: 'lbl_take_photo'.tr,
            leftIcon:
                Icon(Icons.camera_alt, color: appTheme.otherWhite, size: 20.h),
            onPressed: () {
              context.read<UploadImagesBloc>().add(const TakePhotoEvent());
            },
          ),
        ),
        Expanded(
          child: CustomElevatedButton(
            text: 'lbl_choose_gallery'.tr,
            buttonStyle: CustomButtonStyle.outlinedButtonTheme,
            textColor: theme.colorScheme.primary,
            leftIcon: Icon(Icons.photo_library,
                color: theme.colorScheme.primary, size: 20.h),
            onPressed: () {
              context.read<UploadImagesBloc>().add(const ChooseGalleryEvent());
            },
          ),
        ),
      ],
    );
  }
}

class _ImagePreviewSection extends StatelessWidget {
  const _ImagePreviewSection({required this.images});

  final List<XFile> images;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: List.generate(
        images.length,
        (index) => _SelectedImageTile(index: index, file: images[index]),
      ),
    );
  }
}

class _SelectedImageTile extends StatelessWidget {
  const _SelectedImageTile({required this.index, required this.file});

  final int index;
  final XFile file;

  @override
  Widget build(BuildContext context) {
    final double size = (MediaQuery.sizeOf(context).width - 40.w - 16.w) / 3;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.h),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              border: Border.all(color: appTheme.otherBorder),
              image: DecorationImage(
                image: FileImage(File(file.path)),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: -6.h,
          right: -6.w,
          child: GestureDetector(
            onTap: () {
              context
                  .read<UploadImagesBloc>()
                  .add(RemoveImageEvent(index: index));
            },
            child: Container(
              padding: EdgeInsets.all(4.h),
              decoration: BoxDecoration(
                color: appTheme.black900.withValues(alpha: 0.6),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: appTheme.otherWhite,
                size: 14.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
