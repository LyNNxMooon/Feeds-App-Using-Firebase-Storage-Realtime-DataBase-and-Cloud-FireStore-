import 'package:feeds/constants/dimensions.dart';
import 'package:feeds/data/vos/feed_vo.dart';
import 'package:feeds/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FeedBodyWidget extends StatelessWidget {
  const FeedBodyWidget(
      {super.key, required this.onPressDelete, required this.feed});

  final Function onPressDelete;
  final FeedVO? feed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            builder: (_) =>
                BottomSheetDeleteItemView(onPressDelete: onPressDelete()),
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
                Text(
                  feed?.feedTitle ?? '',
                ),
                Gap(kSP20x),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: feed?.fileURL ?? '',
                      placeholder: (_, __) => const LoadingWidget(),
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class BottomSheetDeleteItemView extends StatelessWidget {
  const BottomSheetDeleteItemView({super.key, required this.onPressDelete});

  final Function onPressDelete;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: kSP10x),
      height: MediaQuery.of(context).size.height * 0.1,
      child: GestureDetector(
        onTap: () {
          onPressDelete();
        },
        child: const Text("Delete Feed"),
      ),
    );
  }
}
