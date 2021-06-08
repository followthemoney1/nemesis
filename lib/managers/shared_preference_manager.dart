import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  static final SharedPreferenceManager _singleton =
      new SharedPreferenceManager._internal();
  factory SharedPreferenceManager() {
    return _singleton;
  }
  SharedPreferenceManager._internal() {
    init();
  }
  final LIKED_NEWS = "LIKED_NEWS";
  final APP_THEME = "APP_THEME";
  final SUGGESTION_KEYS = "SUGGESTION_KEYS";
  final DEEPLINK_DATA = "DEEPLINK_DATA";
  final SUBSCRIBED_TO_NOTIFICATION = "SUBSCRIBED_TO_NOTIFICATION";
  final SELECTED_MENU_ITEM = 'SELECTED_MENU_ITEM'; 

  static SharedPreferences? _prefs;
  static RxSharedPreferences? _rxSharedPreferences;
  Future init() async {
    _prefs = await SharedPreferences.getInstance();
    _rxSharedPreferences = RxSharedPreferences.getInstance();
  }

  checkPrefs() async {
    if (_prefs == null || _rxSharedPreferences == null) await init();
  }

  setectMenuItem(int index)async{
   await checkPrefs();
    await _prefs!.setInt(SELECTED_MENU_ITEM, index);
  }

  Future<int?> getSelectedMenuItem()async{
await checkPrefs();
  return await _prefs!.getInt(SELECTED_MENU_ITEM);
  }

  Future<bool?> subscribedToNotification() async {
    await checkPrefs();
    return await _prefs!.getBool(SUBSCRIBED_TO_NOTIFICATION);
  }

  Future<bool> subscribToNotification(bool state) async {
    await checkPrefs();
    return await _prefs!.setBool(SUBSCRIBED_TO_NOTIFICATION, state);
  }

  Future<bool> isViewedNews(String newsId) async {
    await checkPrefs();
    return await _prefs!.getBool(newsId + "isViewedNews") ?? false;
  }

  Future<bool> setViewedNews(String newsId, {viewed = true}) async {
    await checkPrefs();
    return await _prefs!.setBool(newsId + "isViewedNews", viewed);
  }

  Future<bool> isViewedLink(String newsId) async {
    await checkPrefs();
    return await _prefs!.getBool(newsId + "isViewedLink") ?? false;
  }

  Future<bool> setViewedLink(String newsId, {viewed = true}) async {
    await checkPrefs();
    return await _prefs!.setBool(newsId + "isViewedLink", viewed);
  }

  saveDeepLinkData(String data) async {
    await checkPrefs();
    await _prefs!.setString(DEEPLINK_DATA, data);
  }

  Future<String> getDeepLinkData() async {
    await checkPrefs();
    var data = await _prefs!.getString(DEEPLINK_DATA);
    if (data == null) data = '';
    return data;
  }

  addRemoveLiked(String newsKey) async {
    await checkPrefs();
    List<String> likedNews = await getAllLikedNews();
    if (likedNews.contains(newsKey)) {
      likedNews.remove(newsKey);
    } else {
      likedNews.add(newsKey);
    }
    _saveNewsList(likedNews);
  }

  Future<List<String>> getCategoryList() async {
    await checkPrefs();
    List<String>? categories = await _prefs!.getStringList(SUGGESTION_KEYS);
    if (categories == null || categories.length < 0) categories = [];
    return categories;
  }

  saveCategory(String e) async {
    List<String> categories = await getCategoryList();

    categories.add(e);
    _prefs!.setStringList(SUGGESTION_KEYS, categories);
  }

  clearCategory() async {
    await _prefs!.setStringList(SUGGESTION_KEYS, []);
  }

  deleteCategory(String? e) async {
    List<String> categories = await getCategoryList();
    categories.remove(e);
    _prefs!.setStringList(SUGGESTION_KEYS, categories);
  }

  _saveNewsList(List<String> likedNews) async {
    await checkPrefs();
    _rxSharedPreferences!.setStringList(LIKED_NEWS, likedNews);
  }

  Future<List<String>> getAllLikedNews() async {
    await checkPrefs();
    List<String>? likedNews =
        await _rxSharedPreferences!.getStringList(LIKED_NEWS);
    if (likedNews == null || likedNews.length < 0) return [];
    return likedNews;
  }

  Stream<List<String>> getAllLikedNewsStream() async* {
    await checkPrefs();
    yield* _rxSharedPreferences!.getStringListStream(LIKED_NEWS)
        as Stream<List<String>>;
  }

  Future likeNews(String newsKey, bool liked) async {
    await checkPrefs();
    await _prefs!.setBool(newsKey + "likeNews", liked);
    _rxSharedPreferences!.setBool(newsKey + "likeNews", liked);
    addRemoveLiked(newsKey);
  }

  Future<bool> getLikeNews(String newsKey) async {
    await checkPrefs();
    return _prefs!.getBool(newsKey + "likeNews") ?? false;
  }

  Stream<bool> getLikeNewsRX(String newsKey) async* {
    await checkPrefs();
    yield* _rxSharedPreferences!.getBoolStream(newsKey + "likeNews")
        as Stream<bool>;
  }

  pickLightTheme() async {
    await init();
    if (_prefs!.getInt(APP_THEME) != 0) {
      await _prefs!.setInt(APP_THEME, 0);
      await _rxSharedPreferences!.setInt(APP_THEME, 0);
    }
  }

  pickDarkTheme() async {
    await init();
    if (_prefs!.getInt(APP_THEME) != 1) {
      await _prefs!.setInt(APP_THEME, 1);
      await _rxSharedPreferences!.setInt(APP_THEME, 1);
    }
  }

  Stream<int> getThemeStream() async* {
    await init();
    yield* _rxSharedPreferences!.getIntStream(APP_THEME) as Stream<int>;
  }
}
