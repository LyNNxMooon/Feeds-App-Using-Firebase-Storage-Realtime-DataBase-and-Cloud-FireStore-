import 'dart:io';

import 'package:feeds/bloc/add_feed_page_bloc.dart';
import 'package:feeds/constants/colors.dart';
import 'package:feeds/constants/dimensions.dart';
import 'package:feeds/constants/strings.dart';

import 'package:feeds/utils/enums.dart';
import 'package:feeds/utils/file_picker_utils.dart';
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
          builder: (context) => FloatingActionButton(
            onPressed: () {
              final bloc = context.read<AddFeedPageBloc>();
              bloc.saveFeed(_captionController.text);
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
                  const PhotoView()
                ],
              )),
        ),
      )),
    );
  }
}

class PhotoView extends StatelessWidget {
  const PhotoView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<AddFeedPageBloc, File?>(
      builder: (_, file, __) => file != null
          ? Stack(
              children: [
                SizedBox(
                    width: kUploadImageWidth,
                    height: kUploadImageHeight,
                    child: Image.file(
                      file,
                      fit: BoxFit.cover,
                    )),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.delete,
                      color: kDeleteColor,
                      size: 28,
                    ),
                  ),
                )
              ],
            )
          : const Center(
              child: Text(kUploadFileNullText),
            ),
      selector: (_, bloc) => bloc.getSelectFile,
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
        final image = await FilePickerUtils.getImage();
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
