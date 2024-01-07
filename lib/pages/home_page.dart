import 'package:feeds/bloc/home_page_bloc.dart';
import 'package:feeds/constants/colors.dart';
import 'package:feeds/data/vos/feed_vo.dart';
import 'package:feeds/pages/add_feed_page.dart';
import 'package:feeds/pages/feed_details_page.dart';
import 'package:feeds/utils/enums.dart';
import 'package:feeds/widgets/error_widget.dart';
import 'package:feeds/widgets/feed_body_widget.dart';
import 'package:feeds/widgets/loading_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageBloc>(
      create: (context) => HomePageBloc(),
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kSecondaryColor,
          title: const Text("Feeds"),
          centerTitle: true,
        ),
        backgroundColor: kPrimaryColor,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddFeedPage(),
              )),
        ),
        body: Selector<HomePageBloc, LoadingState>(
            selector: (_, bloc) => bloc.getLoadingState,
            builder: (_, loadingState, __) => LoadingStateWidget(
                loadingState: loadingState,
                loadingSuccessWidget: const HomePageItemView(),
                errorWidget: const HomePageErrorStateItemView())),
      )),
    );
  }
}

class HomePageItemView extends StatelessWidget {
  const HomePageItemView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomePageBloc>();
    return Selector<HomePageBloc, List<FeedVO>?>(
        selector: (_, bloc) => bloc.getFeedList,
        builder: (_, feedList, __) => ListView.separated(
            itemBuilder: (_, index) => GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FeedDetailsPage(feedID: feedList![index].id),
                      )),
                  child: FeedBodyWidget(
                    isEdit: false,
                    feed: feedList?[index],
                    onPressDelete: () =>
                        bloc.deleteFeed(feedList?[index].id ?? -1),
                  ),
                ),
            separatorBuilder: (_, index) => const Divider(),
            itemCount: feedList?.length ?? 0));
  }
}

class HomePageErrorStateItemView extends StatelessWidget {
  const HomePageErrorStateItemView();

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, String?>(
        selector: (_, bloc) => bloc.getErrorMessage,
        builder: (_, errorMessage, __) =>
            ShowErrorWidget(errorMessage: errorMessage ?? ''));
  }
}
