import 'package:flutter/material.dart';
import 'individual_frame_painter.dart';
import 'user_profile_image_clipper.dart';

class IndividualFrame extends StatelessWidget {
  final double width;
  final double height;
  final String imageUrl;

  const IndividualFrame({
    super.key,
    required this.width,
    required this.height,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipPath(
            clipper: UserProfileImageFrameClipper(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black
              ),
              child: imageUrl.isNotEmpty
                  ? Image.asset(
                imageUrl,
                width: width / 1.1,
                height: height / 1.1,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                'assets/profiles/golem2.png',
                width: width / 1.1,
                height: height / 1.1,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 0.1,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/bg_images/playerprofilebg.png"))
              ),
              child: CustomPaint(
                size: Size(width, height),
                // painter: IndividualFramePainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}