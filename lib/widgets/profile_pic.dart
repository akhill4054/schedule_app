import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    @required this.width,
    @required this.imgUrl,
  });

  final double width;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    final placeHolderImage = CircleAvatar(
      radius: width / 2,
      backgroundImage: AssetImage('assets/image/profile_placeholder.jpg'),
    );

    return (imgUrl?.isNotEmpty == true)
        ? CachedNetworkImage(
            width: width,
            height: width,
            imageUrl: imgUrl,
            imageBuilder: (_, imageProvider) => CircleAvatar(
              radius: width / 2,
              backgroundImage: imageProvider,
            ),
            placeholder: (_, __) => placeHolderImage,
            errorWidget: (_, __, ___) => placeHolderImage,
          )
        : placeHolderImage;
  }
}
