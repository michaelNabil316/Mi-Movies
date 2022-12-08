import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharma_tv/presentation/models/movie_model.dart';
import 'package:pharma_tv/shared/styels.dart';
import '../../../shared/constants.dart';
import '../../../shared/navigate.dart';
import '../../screens/movie_details.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15.h),
        padding: EdgeInsets.all(15.h),
        decoration: cardDecoration,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                        "$baseImgUrl${imgUrlSize}${movie.posterPath}"),
                    fit: BoxFit.fill,
                  )),
              height: 370.h,
              width: 260.w,
            ),
            SizedBox(width: 50.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 540.w,
                    child: Text(
                      "${movie.title}",
                      style: titleTxtStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                SizedBox(height: 10.h),
                Text("${movie.releaseDate}"),
                SizedBox(height: 10.h),
                Text("Popularity: ${movie.popularity}"),
                SizedBox(height: 10.h),
                Text("vote: ${movie.voteAverage}"),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        navigateTo(context, MovieDetailsScreen(movie: movie));
      },
    );
  }
}
