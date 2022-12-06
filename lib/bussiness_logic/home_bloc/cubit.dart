import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/apis/movies_api.dart';
import '../../presentation/models/movie_model.dart';
import '../../shared/cashHelper/chash_helper.dart';
import 'states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(AppInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  MoviesApi moviesApi = MoviesApi();
  bool loading = false;
  Map? moviesResponse;
  List<MovieModel> moviesList = [];

  getPopularMovies() async {
    loading = true;
    moviesList = [];
    emit(LoadingMoviesState());
    final response = await moviesApi.getMoviesApi();
    loading = false;
    //log("response ${response['Values']}");
    if (!response['Err_Flag']) {
      CashHelper.saveData(key: 'movieApiData', value: response['Values']);
      moviesResponse = jsonDecode(response['Values']);
      movieDataMaper();
      emit(SuccessfulyLoadedMoviestate());
    } else {
      moviesResponse = {};
      if (CashHelper.getData(key: 'movieApiData') != null) {
        moviesResponse = jsonDecode(CashHelper.getData(key: 'movieApiData'));
        movieDataMaper();
      }
      emit(ErrorLoadingMoviesState(error: response['Message']));
    }
  }

  movieDataMaper() {
    for (var movie in moviesResponse!['results']) {
      moviesList.add(MovieModel.fromJson(movie));
    }
  }
}
