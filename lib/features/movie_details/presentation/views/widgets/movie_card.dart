import 'package:movie_app/core/theming/color_manager.dart';
import 'package:movie_app/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theming/styles_manager.dart';

class MovieCard extends StatefulWidget {
  final String starImg;
  final String loveImg;
  final String clockImg;
  final String ratingNum;
  final String loveNum;
  final String clockNum;
  final String title;
  final String year;
   final String coverImg;
   final bool? isFav ;
  final VoidCallback onPressedSaved;

  const MovieCard({super.key, required this.starImg, required this.loveImg, required this.clockImg, required this.ratingNum, required this.loveNum, required this.clockNum, required this.title, required this.year, required this.coverImg,required this.onPressedSaved,  this.isFav = false, });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: height*0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black,
      ),
      child: Stack(
        children: [
          // Background Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Opacity(
              opacity: 0.4,
              child: Image.network(
                widget.coverImg,
                width: double.infinity,
                height: height,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const ImageIcon(
                  AssetImage(AssetManager.arrowBack),color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: widget.onPressedSaved,
                icon: Icon(
                    widget.isFav == true
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ],
          )),

          // Play button in center
          Align(
            alignment: Alignment.center,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  size: 40,
                  color: Colors.yellow,
                ),
              ),
            ),
          ),

          // Text and button overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration:  BoxDecoration(
                color: ColorManager.blackColor.withValues(alpha: 0.4),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: Styles.textStyle24w5.copyWith(
                            color: Colors.white,
                            decoration: TextDecoration.none
                        )
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.year,
                      textAlign: TextAlign.center,
                      style: Styles.textStyle24w5.copyWith(
                          color: ColorManager.grey3,
                          decoration: TextDecoration.none
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Watch button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('Watch' ,
                          style: Styles.textStyle20w7.copyWith(color: Colors.white),),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildIconStat(widget.loveImg, widget.loveNum),
                        _buildIconStat(widget.clockImg, widget.clockNum),
                        _buildIconStat(widget.starImg, widget.ratingNum),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconStat(String image, String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: ColorManager.grey,
          border: Border.all(
              color: ColorManager.grey
          ),
          borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        children: [
          Image.asset(image),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              decoration: TextDecoration.none

          )),
        ],
      ),
    );
  }
}

