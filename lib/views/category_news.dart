import 'package:flutter/material.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/articleModel.dart';
import 'package:news_app/views/article_view.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Daily',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          )
        ],
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  // height: 650,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: articles.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return BlogTile(
                            imageUrl: articles[index].urlToImage.toString(),
                            title: articles[index].title.toString(),
                            desc: articles[index].description.toString(),
                            url: articles[index].url.toString());
                      })),
            ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  const BlogTile(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.desc,
      required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
      }),
      child: Card(
        shape: RoundedRectangleBorder(
            // side: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(18))),
        //  borderOnForeground: true,

        margin: EdgeInsets.only(top: 20),
        elevation: 2,
        child: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              Image.network(imageUrl),
              Text(
                title,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),

              Text(
                desc,
                style: TextStyle(color: Colors.black54),
              ),
              // SizedBox(
              //   width: 10,
              // ),
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(Icons.share),
              //   iconSize: 50,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
