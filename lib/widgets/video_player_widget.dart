import 'dart:io';

import 'package:feeds/constants/colors.dart';
import 'package:feeds/constants/dimensions.dart';
import 'package:feeds/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget(
      {super.key,
      required this.filePath,
      this.onTapRemove,
      this.isFileNetwork = false,
      this.icon});

  final String filePath;
  final Function? onTapRemove;
  final bool isFileNetwork;
  final Icon? icon;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.isFileNetwork
        ? VideoPlayerController.networkUrl(Uri.parse(widget.filePath))
        : VideoPlayerController.file(File(widget.filePath));

    _controller.initialize().whenComplete(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {});
      }
    });

    _controller.addListener(() {
      if (mounted) {
        setState(() {
          isPlay = _controller.value.isPlaying;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(
            children: [
              Positioned.fill(child: VideoPlayer(_controller)),
              Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: () {
                      if (isPlay) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    },
                    icon: Icon(
                      isPlay ? Icons.pause : Icons.play_arrow,
                      size: kSP48x,
                      color: kPrimaryColor,
                    ),
                  )),
              if (widget.icon != null) ...[
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                      onTap: () {
                        widget.onTapRemove!();
                      },
                      child: widget.icon),
                )
              ]
            ],
          )
        : const LoadingWidget();
  }
}
