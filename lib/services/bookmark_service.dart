import 'package:newsly/helper/api_calling.dart';
import 'package:newsly/models/api_response.dart';
import 'package:newsly/utils/app_config.dart';

class BookmarkService {

  Future<ApiResponse> fetchBookmarks(int userId) async {
    var response = await APICalling.get("${AppConfig.baseUrl}/bookmarks/user/$userId");
    return response;
  }

  Future<ApiResponse> saveBookmark(int userId,int newsId) async {
    var body = {
      "news_id":newsId.toString(),
      "user_id":userId.toString()
    };
    var response = await APICalling.post("${AppConfig.baseUrl}/bookmarks",body);
    return response;
  }
}