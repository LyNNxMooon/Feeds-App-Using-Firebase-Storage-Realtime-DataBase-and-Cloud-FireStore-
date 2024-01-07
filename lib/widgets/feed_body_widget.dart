import 'package:feeds/constants/dimensions.dart';
import 'package:feeds/data/vos/feed_vo.dart';
import 'package:feeds/utils/enums.dart';
import 'package:feeds/utils/url_launcher_utils.dart';
import 'package:feeds/widgets/loading_widget.dart';
import 'package:feeds/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FeedBodyWidget extends StatefulWidget {
  FeedBodyWidget(
      {super.key,
      required this.onPressDelete,
      required this.feed,
      required this.isEdit,
      this.editController});

  final VoidCallback onPressDelete;

  final FeedVO? feed;
  final bool isEdit;
  final TextEditingController? editController;

  @override
  State<FeedBodyWidget> createState() => _FeedBodyWidgetState();
}

class _FeedBodyWidgetState extends State<FeedBodyWidget> {
  @override
  void initState() {
    widget.editController?.text = widget.feed?.feedTitle ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            builder: (bottomSheetContext) => BottomSheetDeleteItemView(
                onPressDelete: widget.onPressDelete,
                bottomSheetContext: bottomSheetContext),
          );
        },
        child: Card(
          margin:
              const EdgeInsets.symmetric(horizontal: kSP10x, vertical: kSP10x),
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kSP20x)),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            padding: const EdgeInsets.symmetric(
                horizontal: kSP10x, vertical: kSP10x),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.isEdit
                    ? TextField(
                        controller: widget.editController,
                        decoration: InputDecoration(
                            hintText: "Caption",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none)),
                      )
                    : Text(
                        widget.feed?.feedTitle ?? '',
                      ),
                Gap(kSP20x),
                if (widget.feed?.fileType == FileType.image.name) ...[
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: widget.feed?.fileURL ?? '',
                        placeholder: (_, __) => const LoadingWidget(),
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
                if (widget.feed?.fileType == FileType.video.name) ...[
                  Expanded(
                    child: VideoPlayerWidget(
                      filePath: widget.feed?.fileURL ?? '',
                      isFileNetwork: true,
                    ),
                  )
                ],
                if (widget.feed?.fileType == FileType.file.name) ...[
                  Expanded(
                      child: FeedFileView(fileURL: widget.feed?.fileURL ?? ''))
                ]
              ],
            ),
          ),
        ));
  }
}

class BottomSheetDeleteItemView extends StatelessWidget {
  const BottomSheetDeleteItemView(
      {super.key,
      required this.onPressDelete,
      required this.bottomSheetContext});

  final VoidCallback onPressDelete;
  final BuildContext bottomSheetContext;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: kSP30x, left: kSP20x),
      height: MediaQuery.of(context).size.height * 0.1,
      child: GestureDetector(
        onTap: () {
          onPressDelete();
          Navigator.pop(bottomSheetContext);
        },
        child: const Text(
          "Delete Feed",
          style: TextStyle(fontSize: kFontSize16x),
        ),
      ),
    );
  }
}

class FeedFileView extends StatelessWidget {
  const FeedFileView({required this.fileURL});

  final String fileURL;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: 30,
        child: GestureDetector(
          onTap: () {
            UrlLauncherUtils.launchURLToBrowser(fileURL);
          },
          child: const Icon(
            Icons.file_present,
            size: 32,
          ),
        ),
      ),
    );
  }
}
