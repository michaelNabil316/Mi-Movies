import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/apis/movies_api.dart';
import '../../presentation/models/movie_model.dart';
import '../../shared/cashHelper/chash_helper.dart';
import 'states.dart';

class MovieCubit extends Cubit<MovieStates> {
  MovieCubit() : super(AppInitialState());
  static MovieCubit get(context) => BlocProvider.of(context);
  MoviesApi moviesApi = MoviesApi();
  Map? movieDetailsResponse;
  MovieModel? selectedMovie;

  getMovieDetails(String id) async {
    emit(LoadingMovieState());
    final response = await moviesApi.getMovieDetailsApi(id);
    if (!response['Err_Flag']) {
      CashHelper.saveData(key: 'movieApiData', value: response['Values']);
      selectedMovie = MovieModel.fromJson(jsonDecode(response['Values']));
      emit(SuccessfulyLoadedMovieState());
    } else {
      movieDetailsResponse = {};
      if (CashHelper.getData(key: 'movieApiData') != null) {
        movieDetailsResponse =
            jsonDecode(CashHelper.getData(key: 'movieApiData'));
        selectedMovie = MovieModel.fromJson(jsonDecode(response['Values']));
      }
      emit(ErrorLoadingMovieState(error: response['Message']));
    }
  }
}
