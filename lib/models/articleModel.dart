// class News2 {
//   late List<ArticleModel> articles;

//   News2({required articles});

//   News2.fromJson(Map<String, dynamic> json) {
//     if (json['articles'] != null) {
//       articles = <ArticleModel>[];

//       (json['articles'] as List).forEach((element) {
//         if (element["urlToImage"] != null && element['description'] != null) {
//           articles.add(ArticleModel.fromJson(element));
//         }
//       });
//     }
//   }

//   // List<ArticleModel> news2 = [];

// }

class ArticleModel {
//  String author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;
  ArticleModel(
      {required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.content});

  // ArticleModel.fromJson(Map<String, dynamic> json) {
  //   title = json['title'];
  //   description = json['description'];
  //   url = json['url'];
  //   urlToImage = json['urlToImage'];
  //   // content = json['content'];
  // }
}
