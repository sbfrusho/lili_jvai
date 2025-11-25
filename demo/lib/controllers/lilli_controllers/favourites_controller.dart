import 'package:get/get.dart';
import 'package:demo/models/lilli_models/favorites_model.dart';

class FavoritesController extends GetxController {
  /// Rx list of FavoriteModel
  final RxList<FavoriteModel> favorites = <FavoriteModel>[].obs;

  /// Add to favorites
  void addToFavorites(FavoriteModel item) {
    // avoid duplicates
    bool exists = favorites.any((f) =>
        f.english == item.english &&
        f.marshallese == item.marshallese &&
        f.category == item.category);

    if (!exists) {
      favorites.add(item);
    }
  }

  /// Remove from favorites
  void removeFromFavorites(FavoriteModel item) {
    favorites.remove(item);
  }
}
