import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone_flutter/common/common.dart';
import 'package:twitter_clone_flutter/contants/assets_constants.dart';
import 'package:twitter_clone_flutter/features/home/view/home_view.dart';
import 'package:twitter_clone_flutter/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone_flutter/models/user_model.dart';
import 'package:twitter_clone_flutter/theme/theme.dart';
import 'package:twitter_clone_flutter/core/core.dart';

class CreateTweetView extends ConsumerStatefulWidget {
  const CreateTweetView({super.key});
  static route() =>
      MaterialPageRoute(builder: (context) => const CreateTweetView());

  @override
  ConsumerState<CreateTweetView> createState() => _CreateTweetViewState();
}

class _CreateTweetViewState extends ConsumerState<CreateTweetView> {
  bool isLoading = true;
  final tweetTextController = TextEditingController();
  List<File> images = [];

  @override
  void dispose() {
    super.dispose();
    tweetTextController.dispose();
  }

  void backToHomeView() {
    Navigator.pop(context);
  }

  void onPickImages() async {
    images = await pickImages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentUserProfileProvider).when(
        data: (data) {
          if (data == null) return const HomeView();
          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: backToHomeView,
                    icon: const Icon(
                      Icons.close,
                      size: 30,
                    )),
                actions: [
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          backgroundColor: Pallete.blueColor,
                          foregroundColor: Pallete.whiteColor,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                        child: const Text('Tweet'),
                      )),
                ],
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Left
                        const SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(Icons.person),
                        ),
                        //Right
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              Text(data.email.toString()),
                              TextField(
                                controller: tweetTextController,
                                autofocus: true,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "What's happening ?",
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    CarouselSlider(
                        items: images
                            .map((image) => Image.network(
                                  image.path,
                                  height: 300,
                                ))
                            .toList(),
                        options: CarouselOptions(
                          height: 400,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          enableInfiniteScroll: false,
                          enlargeCenterPage: false,
                        )),
                  ],
                )),
              ),
              bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Pallete.blueColor, width: 0.3))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: onPickImages,
                            child:
                                SvgPicture.asset(AssetsConstants.galleryIcon),
                          ),
                          const SizedBox(width: 15),
                          SvgPicture.asset(AssetsConstants.gifIcon),
                          const SizedBox(width: 15),
                          const Icon(
                            Icons.list,
                            color: Pallete.blueColor,
                          ),
                          const SizedBox(width: 15),
                          const Icon(
                            Icons.location_on_sharp,
                            color: Pallete.blueColor,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(AssetsConstants.galleryIcon),
                          const SizedBox(width: 15),
                          const Icon(
                            Icons.add_circle_rounded,
                            color: Pallete.blueColor,
                          ),
                          const SizedBox(width: 15),
                        ],
                      )
                    ],
                  ),
                ),
              ));
        },
        error: (error, stackTrace) => ErrorPage(errorMessage: error.toString()),
        loading: () => const LoadingPage());
  }
}
