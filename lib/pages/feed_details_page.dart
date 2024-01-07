import 'package:feeds/bloc/feed_details_page_bloc.dart';
import 'package:feeds/constants/colors.dart';
import 'package:feeds/data/vos/feed_vo.dart';
import 'package:feeds/utils/enums.dart';
import 'package:feeds/utils/extension.dart';
import 'package:feeds/widgets/dialog_widget.dart';
import 'package:feeds/widgets/error_widget.dart';
import 'package:feeds/widgets/feed_body_widget.dart';
import 'package:feeds/widgets/loading_state_widget.dart';
import 'package:feeds/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedDetailsPage extends StatelessWidget {
  FeedDetailsPage({super.key, required this.feedID});

  final int feedID;

  final _editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FeedDetailsPageBloc>(
      create: (context) => FeedDetailsPageBloc(feedID: feedID),
      child: SafeArea(
          child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kSecondaryColor,
          title: Text("Feed Details"),
          centerTitle: true,
        ),
        floatingActionButton: Builder(
          builder: (buttonContext) => FloatingActionButton(
            onPressed: () {
              final bloc = buttonContext.read<FeedDetailsPageBloc>();
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const LoadingWidget());
              bloc
                  .saveFeed(_editController.text, bloc.getFeed!.id,
                      bloc.getFeed!.fileURL, bloc.getFeed!.fileType)
                  .then((value) {
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
            },
            child: Icon(Icons.edit),
          ),
        ),
        body: Selector<FeedDetailsPageBloc, LoadingState>(
          selector: (_, bloc) => bloc.getLoadingState,
          builder: (_, loadingState, __) => LoadingStateWidget(
              loadingState: loadingState,
              loadingSuccessWidget:
                  FeedDetailItemView(editController: _editController),
              errorWidget: FeedDetailErrorWidget()),
        ),
      )),
    );
  }
}

class FeedDetailItemView extends StatelessWidget {
  const FeedDetailItemView({super.key, required this.editController});

  final TextEditingController editController;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FeedDetailsPageBloc>();
    return Selector<FeedDetailsPageBloc, FeedVO?>(
      builder: (_, feed, __) => FeedBodyWidget(
          onPressDelete: () {
            context.navigateBack();
            context.navigateBack();
            bloc.deleteFeed(feed?.id ?? -1);
          },
          feed: feed,
          isEdit: true,
          editController: editController),
      selector: (_, bloc) => bloc.getFeed,
    );
  }
}

class FeedDetailErrorWidget extends StatelessWidget {
  const FeedDetailErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<FeedDetailsPageBloc, String?>(
      builder: (_, error, __) => ShowErrorWidget(errorMessage: error ?? ''),
      selector: (_, bloc) => bloc.getErrorMessage,
    );
  }
}
