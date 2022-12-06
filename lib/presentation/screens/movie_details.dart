import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharma_tv/presentation/models/movie_model.dart';
import '../../bussiness_logic/movie_bloc/cubit.dart';
import '../../bussiness_logic/movie_bloc/states.dart';
import '../../shared/constants.dart';
import '../../shared/styels.dart';
import '../components/details_components/custom_text.dart';
import '../components/toast_with_icon.dart';

class MovieDetailsScreen extends StatefulWidget {
  final MovieModel movie;
  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    MovieCubit.get(context).getMovieDetails(widget.movie.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieCubit, MovieStates>(listener: (context, state) {
      if (state is ErrorLoadingMovieState) {
        showToast(msg: state.error, state: ToastStates.ERROR);
      }
    }, builder: (context, state) {
      final movieBloc = MovieCubit.get(context);

      return Scaffold(
          backgroundColor: lightPrimeColor,
          body: SafeArea(
            child: movieBloc.selectedMovie == null
                ? const Center(child: CircularProgressIndicator())
                : CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        floating: true,
                        expandedHeight: 700.h,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(
                            '${widget.movie.title}',
                            style: titleTxtStyle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          background: Image.network(
                            "$baseImgUrl${imgUrlSize}${widget.movie.backdropPath}",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                            padding: EdgeInsets.all(20.0.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                          Text(
                                            "● ${movieBloc.selectedMovie!.releaseDate}  ●",
                                            style: detailsStyle,
                                          ),
                                        ] +
                                        movieBloc.selectedMovie!.genres!
                                            .map((e) => Text(
                                                  " ${e.name} ",
                                                  style: detailsStyle,
                                                ))
                                            .toList()),
                                SizedBox(height: 10.h),
                                DetailsText(txt: "Languages: "),
                                SizedBox(height: 10.h),
                                SizedBox(
                                  height: 50.h,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: movieBloc
                                        .selectedMovie!.spokenLanguages!.length,
                                    itemBuilder: ((context, index) => DetailsText(
                                        txt:
                                            "● ${movieBloc.selectedMovie!.spokenLanguages![index].name} ")),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.48,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          DetailsText(
                                              txt:
                                                  "popularity: ${movieBloc.selectedMovie!.popularity}"),
                                          SizedBox(height: 10.h),
                                          DetailsText(
                                              txt:
                                                  "vote average: ${movieBloc.selectedMovie!.voteAverage}"),
                                          SizedBox(height: 10.h),
                                          DetailsText(
                                              txt:
                                                  "vote revenue: ${movieBloc.selectedMovie!.revenue}"),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DetailsText(
                                            txt:
                                                "vote runtime: ${movieBloc.selectedMovie!.runtime}"),
                                        SizedBox(height: 10.h),
                                        DetailsText(
                                            txt:
                                                "vote count: ${movieBloc.selectedMovie!.voteCount}"),
                                        SizedBox(height: 10.h),
                                        DetailsText(
                                            txt:
                                                "${widget.movie.video == true ? 'Video available' : 'video Not available'}"),
                                      ],
                                    )
                                  ],
                                ),
                                DetailsText(
                                  txt: widget.movie.adult == true
                                      ? 'Adult'
                                      : 'Not for Adult',
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                    margin: EdgeInsets.all(25.w),
                                    padding: EdgeInsets.all(30.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      "${widget.movie.overview}",
                                      overflow: TextOverflow.visible,
                                      style: overViewTxtStyle,
                                    )),
                                DetailsText(txt: "Production countries: "),
                                Row(
                                    children: movieBloc
                                        .selectedMovie!.productionCountries!
                                        .map((e) =>
                                            DetailsText(txt: " ● ${e.name}   "))
                                        .toList()),
                                SizedBox(
                                  height: 220.h,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: movieBloc.selectedMovie!
                                          .productionCompanies!.length,
                                      itemBuilder: ((context, index) {
                                        return movieBloc
                                                    .selectedMovie!
                                                    .productionCompanies![index]
                                                    .logoPath !=
                                                null
                                            ? Container(
                                                margin: EdgeInsets.all(9.h),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                                "$baseImgUrl${imgUrlSize}${movieBloc.selectedMovie!.productionCompanies![index].logoPath}"),
                                                            fit: BoxFit.fill,
                                                          )),
                                                      height: 150.h,
                                                      width: 150.h,
                                                    ),
                                                    Text(
                                                      "${movieBloc.selectedMovie!.productionCompanies![index].name}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : SizedBox();
                                      })),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 715.h)
                        ]),
                      ),
                    ],
                  ),
          ));
    });
  }
}
