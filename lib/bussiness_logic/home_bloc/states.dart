abstract class HomeStates {}

class AppInitialState extends HomeStates {}

class LoadingMoviesState extends HomeStates {}

class SuccessfulyLoadedMoviestate extends HomeStates {}

class ErrorLoadingMoviesState extends HomeStates {
  final String error;
  ErrorLoadingMoviesState({required this.error});
}
