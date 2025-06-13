import 'package:movie_app/core/utils/assets_manager.dart';

class OnboardingModel {
  final String id;
  final String titleEn;
  final String titleAr;
  final String image;
  final String descEn;
  final String descAr;

  OnboardingModel({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.descEn,
    required this.descAr,
    required this.image,
  });

  static List<OnboardingModel> get onboardingItems => [
    OnboardingModel(
      id: "1",
      titleAr: "اكتشف فيلمك المفضل القادم هنا",
      titleEn: "Find Your Next \nFavorite Movie Here",
      descEn:
      "Get access to a huge library of movies to suit all tastes. You will surely like it.",
      descAr:
      "احصل على وصول إلى مكتبة ضخمة من الأفلام التي تلائم جميع الأذواق. ستجد ما يعجبك بالتأكيد.",
      image: AssetManager.splashImg6,
    ),
    OnboardingModel(
      id: "2",
      titleAr: "استعرض جميع الأنواع",
      titleEn: "Explore All Genres",
      descEn:
      "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
      descAr:
      "اكتشف أفلامًا من كل الأنواع، وبجميع الجودات المتاحة. استمتع بمشاهدة جديدة ومثيرة كل يوم.",
      image: AssetManager.splashImg1,
    ),
    OnboardingModel(
      id: "3",
      titleAr: "أنشئ قائمة مشاهداتك",
      titleEn: "Create Watchlists",
      descEn:
      "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
      descAr:
      "احفظ الأفلام في قائمة المشاهدة الخاصة بك لتتابع ما ترغب بمشاهدته لاحقًا. استمتع بمحتوى متنوع من حيث الجودة والنوع.",
      image: AssetManager.splashImg2,
    ),
    OnboardingModel(
      id: "4",
      titleAr: "قيّم وراجع وتعلّم",
      titleEn: "Rate, Review, and Learn",
      descEn:
      "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
      descAr:
      "شارك آرائك حول الأفلام التي شاهدتها. تعمّق في تفاصيلها وساعد الآخرين على اكتشاف أفلام رائعة من خلال تقييماتك.",
      image: AssetManager.splashImg3,
    ),
    OnboardingModel(
      id: "5",
      titleAr: "ابدأ المشاهدة الآن",
      titleEn: "Start Watching Now",
      descEn: "",
      descAr: "",
      image: AssetManager.splashImg4,
    ),
    OnboardingModel(
      id: "6",
      titleAr: "اكتشف الأفلام",
      titleEn: "Discover Movies",
      descEn:
      "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
      descAr:
      "استعرض مجموعة واسعة من الأفلام بمختلف الجودات والأنواع. تمكّن من العثور على فيلمك المفضل التالي بكل سهولة ويسر.",
      image: AssetManager.splashImg5,
    ),
  ];
}
