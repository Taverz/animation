import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shimmer/shimmer.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  bool _enabled = true;
  List<Widget> listt = [];

  Timer scheduleTimeout([int milliseconds = 10000]) =>
      Timer(Duration(milliseconds: milliseconds), _handleTimeout);

  _handleTimeout() {
    setState(() {
      _enabled = false;
    });
  }

  @override
  void initState() {
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //   scheduleTimeout(4 * 1000);
    // },);
    _loadinglist();

    super.initState();
  }

  _loadinglist() {
    listt = List.generate(13, (index) {
      return Container(
        // width: MediaQuery.of(context).size.width - 100,
        height: 120,
        child: Row(
          children: [
            Container(
              width: 180,
              height: 90,
              color: Colors.amber,
              child: CachedNetworkImage(
                height: 80,
                imageUrl:
                    "https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg",
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageBuilder: (context, obj) => Container(
                  width: 100,
                  // color: Colors.amber,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: obj,
                      fit: BoxFit.cover,
                      // colorFilter: const ColorFilter.mode(
                      //   Colors.red,
                      //   BlendMode.colorBurn,
                      // ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              // width:200,
              // height: 100,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    color: Colors.amber,
                    height: 15,
                    width: 100,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    color: Colors.amber,
                    height: 15,
                    width: 120,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    color: Colors.amber,
                    height: 15,
                    width: 140,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
    WidgetsBinding.instance!.addPostFrameCallback(
      (timeStamp) {
        scheduleTimeout(4 * 1000);
      },
    );
  }

  @override
  void dispose() {
    // TODO: dispose timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width - 10,
          child: _enabled == true
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: _enabled,
                  child: AnimationLimiter(
                    child: ListView.builder(
                        itemCount: 13,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 875),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  height: 120,
                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                180,
                                        height: 90,
                                        color: Colors.amber,
                                        child: CachedNetworkImage(
                                          height: 80,
                                          imageUrl:
                                              "https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg",
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                          imageBuilder: (context, obj) =>
                                              Container(
                                            width: 100,
                                            // color: Colors.amber,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: obj,
                                                fit: BoxFit.cover,
                                                // colorFilter: const ColorFilter.mode(
                                                //   Colors.red,
                                                //   BlendMode.colorBurn,
                                                // ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // width:200,
                                        // height: 100,
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(10),
                                              color: Colors.amber,
                                              height: 15,
                                              width: 100,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(10),
                                              color: Colors.amber,
                                              height: 15,
                                              width: 120,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(10),
                                              color: Colors.amber,
                                              height: 15,
                                              width: 140,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                          // return Container(
                          //   width: MediaQuery.of(context).size.width- 100,
                          //   height: 120,
                          //   child: Row(children: [
                          //     Container(
                          //       width: MediaQuery.of(context).size.width- 180,
                          //       height: 90,
                          //       child: CachedNetworkImage(
                          //         height: 80,
                          //           imageUrl: "https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg",
                          //           placeholder: (context, url) => CircularProgressIndicator(),
                          //           errorWidget: (context, url, error) => Icon(Icons.error),
                          //           imageBuilder: (context, obj)=> Container(
                          //             width: 100,
                          //     decoration: BoxDecoration(
                          //       image: DecorationImage(
                          //         image: obj,
                          //         fit: BoxFit.cover,
                          //         // colorFilter: const ColorFilter.mode(
                          //         //   Colors.red,
                          //         //   BlendMode.colorBurn,
                          //         // ),
                          //       ),
                          //     ),
                          //   ),
                          //       ),
                          //     ),
                          //     Column(children: [
                          //       Text("Title ${index}"),
                          //       Text("description ${index}"),
                          //       Text("data ${index}"),
                          //     ],)
                          //   ],),
                          // );
                        }),
                  ),
                )
              :
              // AnimationLimiter(
              //   child:
              ListView.builder(
                  itemCount: listt.length,
                  itemBuilder: (context, index) {
                    return
                        //   AnimationConfiguration.staggeredList(
                        // position: index,
                        // duration: const Duration(milliseconds: 375),
                        // child: SlideAnimation(
                        //   verticalOffset: 50.0,
                        //   child: FadeInAnimation(
                        // child:
                        listt[index];
                    //     ,
                  }),
          // )
          // ,
          // )
          // ;
          // return Container(
          //   width: MediaQuery.of(context).size.width- 100,
          //   height: 120,
          //   child: Row(children: [
          //     Container(
          //       width: MediaQuery.of(context).size.width- 180,
          //       height: 90,
          //       child: CachedNetworkImage(
          //         height: 80,
          //           imageUrl: "https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg",
          //           placeholder: (context, url) => CircularProgressIndicator(),
          //           errorWidget: (context, url, error) => Icon(Icons.error),
          //           imageBuilder: (context, obj)=> Container(
          //             width: 100,
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //         image: obj,
          //         fit: BoxFit.cover,
          //         // colorFilter: const ColorFilter.mode(
          //         //   Colors.red,
          //         //   BlendMode.colorBurn,
          //         // ),
          //       ),
          //     ),
          //   ),
          //       ),
          //     ),
          //     Column(children: [
          //       Text("Title ${index}"),
          //       Text("description ${index}"),
          //       Text("data ${index}"),
          //     ],)
          //   ],
        ),
      ),
      // );
      // }
      // ),
      // ),
      // ),
      // ),
    );
    // );
  }
}
