import 'dart:io';

import 'package:feeds/bloc/add_feed_page_bloc.dart';
import 'package:feeds/constants/colors.dart';
import 'package:feeds/constants/dimensions.dart';
import 'package:feeds/utils/enums.dart';
import 'package:feeds/utils/extension.dart';
import 'package:feeds/utils/file_picker_utils.dart';
import 'package:feeds/widgets/dialog_widget.dart';
import 'package:feeds/widgets/loading_widget.dart';
import 'package:feeds/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class AddFeedPage extends StatefulWidget {
  const AddFeedPage({super.key});

  @override
  State<AddFeedPage> createState() => _AddFeedPageState();
}

class _AddFeedPageState extends State<AddFeedPage> {
  final _captionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddFeedPageBloc>(
      create: (_) => AddFeedPageBloc(),
      child: SafeArea(
          child: Scaffold(
        floatingActionButton: Builder(
          builder: (buttonContext) => FloatingActionButton(
            onPressed: () {
              final bloc = buttonContext.read<AddFeedPageBloc>();
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const LoadingWidget());
              bloc.saveFeed(_captionController.text).then((value) {
                context.navigateBack();
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => DialogWidget(
                          content: 'Success',
                          onTapOK: () {
                            context.navigateBack();
                            context.navigateBack();
                          },
                        ));
              }).catchError((error) {
                context.navigateBack();
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => DialogWidget(
                          content: error.toString(),
                          isSuccessDialog: false,
                          onTapOK: () {
                            context.navigateBack();
                          },
                        ));
              });
              _captionController.clear();
            },
            child: const Icon(Icons.upload),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios)),
          backgroundColor: kSecondaryColor,
          title: const Text("Add to Feed"),
          centerTitle: true,
        ),
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding:
              const EdgeInsets.only(top: kSP20x, left: kSP20x, right: kSP20x),
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UploadButtonSessionView(),
                  const Gap(kSP40x),
                  SizedBox(
                      width: kCaptionTextFieldWidth,
                      child: TextField(
                        controller: _captionController,
                        decoration: const InputDecoration(hintText: "Caption"),
                      )),
                  const Gap(kSP20x),
                  Selector<AddFeedPageBloc, FileType>(
                    builder: (_, fileType, __) =>
                        FileTypeView(fileType: fileType),
                    selector: (_, bloc) => bloc.getFileType,
                  ),
                ],
              )),
        ),
      )),
    );
  }
}

class FileTypeView extends StatelessWidget {
  const FileTypeView({super.key, required this.fileType});

  final FileType fileType;

  @override
  Widget build(BuildContext context) {
    return Selector<AddFeedPageBloc, File?>(
      builder: (_, file, __) => Container(
        width: kUploadImageWidth,
        height: kUploadImageHeight,
        child: file != null && fileType == FileType.image
            ? PhotoView(filePath: file.path)
            : file != null && fileType == FileType.video
                ? VideoPlayerWidget(
                    filePath: file.path,
                    onTapRemove: () {
                      final bloc = context.read<AddFeedPageBloc>();
                      bloc.setSelectFile = null;
                    },
                    icon: Icon(
                      Icons.delete,
                      color: kDeleteColor,
                      size: kSP28x,
                    ),
                  )
                : file != null && fileType == FileType.file
                    ? FileView(
                        filePath: file.path.split('/').last,
                      )
                    : const SizedBox(),
      ),
      selector: (_, bloc) => bloc.getSelectFile,
    );
  }
}

class PhotoView extends StatelessWidget {
  const PhotoView({
    super.key,
    required this.filePath,
  });

  final String filePath;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddFeedPageBloc>();
    return Stack(
      children: [
        Positioned.fill(
          child: Image.file(
            File(filePath),
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              bloc.setSelectFile = null;
            },
            child: const Icon(
              Icons.delete,
              color: kDeleteColor,
              size: kSP28x,
            ),
          ),
        )
      ],
    );
  }
}

class FileView extends StatelessWidget {
  const FileView({super.key, required this.filePath});

  final String filePath;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddFeedPageBloc>();
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: kSP30x,
                child: Icon(
                  Icons.file_present,
                  size: kSP32x,
                ),
              ),
              const SizedBox(
                height: kSP20x,
              ),
              Text(filePath)
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              bloc.setSelectFile = null;
            },
            child: const Icon(
              Icons.delete,
              color: kDeleteColor,
              size: kSP28x,
            ),
          ),
        )
      ],
    );
  }
}

class UploadButtonSessionView extends StatelessWidget {
  const UploadButtonSessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: FileType.values
            .map((e) => Expanded(child: UploadButtonItemView(fileType: e)))
            .toList());
  }
}

class UploadButtonItemView extends StatelessWidget {
  const UploadButtonItemView({super.key, required this.fileType});

  final FileType fileType;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddFeedPageBloc>();
    return GestureDetector(
      onTap: () async {
        final image = fileType == FileType.image
            ? await FilePickerUtils.getImage()
            : fileType == FileType.video
                ? await FilePickerUtils.getVideo()
                : await FilePickerUtils.getFile();
        bloc.setFileType = fileType;
        bloc.setSelectFile = image;
      },
      child: Container(
        width: kUploadButtonWidth,
        height: kUploadButtonHeight,
        decoration: BoxDecoration(
            border: Border.all(width: 3, color: kSecondaryColor),
            borderRadius: BorderRadius.circular(kSP20x)),
        child: Center(
          child: Text(fileType.name),
        ),
      ),
    );
  }
}
