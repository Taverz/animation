

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({ Key? key }) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(children: [
            CachedNetworkImage(
                imageUrl: "http://via.placeholder.com/350x150",
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Text("Title "),
            Text("description "),
            Text("data "),
          ]),
        ),
      ),
    );
  }
}