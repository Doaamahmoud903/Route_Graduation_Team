import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/assets_manager.dart';

class WatchHistoryPage extends StatefulWidget {
  final int initialTab; // 0 for Watch List, 1 for History
  const WatchHistoryPage({super.key, this.initialTab = 0});

  @override
  State<WatchHistoryPage> createState() => _WatchHistoryPageState();
}

class _WatchHistoryPageState extends State<WatchHistoryPage> {
  @override
  void initState() {
    super.initState();
    // TODO: Trigger data fetching for the relevant tab if needed.
    // e.g., context.read<WatchListCubit>().fetchWatchList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(AssetManager.empty));
  }
}









/*import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/assets_manager.dart';
import 'package:movie_app/features/account/presentation/views/widgets/tab_item.dart';

import '../../../../core/theming/color_manager.dart';
import '../../../../core/theming/styles_manager.dart';
import '../../../../l10n/app_localizations.dart';


class WatchHistoryPage extends StatefulWidget {
  final int initialTab; // 0 for Watch List, 1 for History

  const WatchHistoryPage({super.key, this.initialTab = 0});

  @override
  State<WatchHistoryPage> createState() => _WatchHistoryPageState();
}

class _WatchHistoryPageState extends State<WatchHistoryPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialTab);
    _tabController.addListener(_handleTabSelection);

    // Initial data load for the first tab
    _loadDataForCurrentTab();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      _loadDataForCurrentTab();
    }
  }

  void _loadDataForCurrentTab() {}

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.blackProfileColor,
        bottom: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: ColorManager.orangeColor,
            indicatorWeight: 3,
            dividerColor: ColorManager.transparentColor,
            labelColor: ColorManager.whiteColor,
            labelStyle: Styles.textStyle20w4White,
            tabs: [
              TabItem(
                imgPath: AssetManager.watchList,
                text: AppLocalizations.of(context)!.watch_list,
                isSelected: true,
                selectedTextStyle: Styles.textStyle20w4White,
                unSelectedTextStyle: Styles.textStyle20w4White,
              ),
              TabItem(
                  imgPath: AssetManager.history,
                  text: AppLocalizations.of(context)!.history,
                  isSelected: true,
                  selectedTextStyle: Styles.textStyle20w4White,
                  unSelectedTextStyle: Styles.textStyle20w4White)
            ]
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Image.asset(AssetManager.empty)),
          Center(child: Image.asset(AssetManager.empty)),
        ],
      ),
    );
  }

}*/