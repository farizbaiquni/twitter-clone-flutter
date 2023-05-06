import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone_flutter/contants/constants.dart';
import 'package:twitter_clone_flutter/theme/pallete.dart';

class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomeView());
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _indexPage = 0;
  final appBar = UIConstans.appBar();

  void onChangePage(int indexPage) {
    setState(() {
      _indexPage = indexPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: IndexedStack(
        index: _indexPage,
        children: UIConstans.pageScreenList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
          size: 29,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexPage,
        onTap: onChangePage,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _indexPage == 0
                    ? AssetsConstants.homeFilledIcon
                    : AssetsConstants.homeOutlinedIcon,
                colorFilter:
                    const ColorFilter.mode(Pallete.whiteColor, BlendMode.srcIn),
              ),
              label: "home"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AssetsConstants.searchIcon,
                colorFilter:
                    const ColorFilter.mode(Pallete.whiteColor, BlendMode.srcIn),
              ),
              label: "search"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _indexPage == 2
                    ? AssetsConstants.notifFilledIcon
                    : AssetsConstants.notifOutlinedIcon,
                colorFilter:
                    const ColorFilter.mode(Pallete.whiteColor, BlendMode.srcIn),
              ),
              label: "notification")
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
