class ApiConstant{
 static const String baseUrl = "https://yts.mx/api/v2";
 static const String movieList = "/list_movies.json";
 static const String movieDetails = "/movie_details.json";
 static const String baseUrlPostman = "https://route-movie-apis.vercel.app";
 static const String login = "/auth/login";
 static const String signup = "/auth/register";
 static const String resetPassword = "/auth/reset-password";
 static const String addToFav = "/favorites/add";
 static String removeFromFav(String movieId) => "/favorites/remove/$movieId";
 static String getIsFav(String movieId) => "/favorites/is-favorite/$movieId";
 static const String getAllFav = "/favorites/all";
 static const String profile = "/profile";

}