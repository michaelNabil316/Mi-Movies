import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharma_tv/shared/styels.dart';
import '../../bussiness_logic/home_bloc/cubit.dart';
import '../../bussiness_logic/home_bloc/states.dart';
import '../components/home_componenbts/home_appbar.dart';
import '../components/home_componenbts/movie_card.dart';
import '../components/toast_with_icon.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({super.key});

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      HomeCubit.get(context).getPopularMovies();
      HomeCubit.get(context).clearCashIfError();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is ErrorLoadingMoviesState) {
          showToast(msg: state.error, state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        final homeBloc = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: lightPrimeColor,
          appBar: customAppBar(title: "Mi Movie", context: context),
          body: homeBloc.moviesResponse == null
              ? const Center(child: CircularProgressIndicator())
              : homeBloc.moviesResponse!.isEmpty
                  ? const Text("Something went wrong")
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.h),
                            Text("Popular Movies", style: mainTitleStyle),
                            SizedBox(height: 20.h),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: homeBloc.moviesList.length,
                              itemBuilder: (context, index) => MovieCard(
                                movie: homeBloc.moviesList[index],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
