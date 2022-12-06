abstract class MovieStates {}

class AppInitialState extends MovieStates {}

class LoadingMovieState extends MovieStates {}

class SuccessfulyLoadedMovieState extends MovieStates {}

class ErrorLoadingMovieState extends MovieStates {
  final String error;
  ErrorLoadingMovieState({required this.error});
}
