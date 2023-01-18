import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/articleModel.dart';
import 'package:news_app/models/categoryModel.dart';
import 'package:news_app/provider/themesProvider.dart';
import 'package:news_app/views/article_view.dart';
import 'package:news_app/views/category_news.dart';
import 'package:news_app/widgets/themeModeChange.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = <CategoryModel>[];

  /// for list of cataegories (eg. business, entertainment etc..)

  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories()!;
    getNews();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemesProvider>(context);

    // final text = MediaQuery.of(context).platformBrightness == ThemeMode.dark
    //     ? 'Dark Mode'
    //     : 'Light Mode';
    final text =
        Provider.of<ThemesProvider>(context).darkTheme == true
            ? 'Dark Theme'
            : 'Light Theme';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Daily",
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
          Padding(
              padding: EdgeInsets.only(top: 20, right: 10),
              child: Text(
                '$text',
                style: 
                GoogleFonts.robotoCondensed(color:themeProvider.darkTheme? Colors.white : Colors.black ),
              )),
          // Consumer<ThemesProvider>(
          //   builder: (context, notifier, child) => Padding(
          //     padding: EdgeInsets.only(right: 50),
          //     child: Container(
          //         width: 20,
          //         child: SwitchListTile(
          //             value: notifier.darkTheme,
          //             onChanged: ((value) {
          //               notifier.toggleTheme();
          //             }))),
          //   ),
          // ),

          ChangeThemeButton()
        ],
        centerTitle: true,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    //categories
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 70,
                      child: ListView.builder(
                          itemCount: categories.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                                imageUrl: categories[index].imageUrl,
                                categoryName: categories[index].categoryName);
                          }),
                    ),
                    //Blogs
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        // height: 650,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: articles.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return BlogTile(
                                  imageUrl:
                                      articles[index].urlToImage.toString(),
                                  title: articles[index].title.toString(),
                                  desc: articles[index].description.toString(),
                                  url: articles[index].url.toString());
                            })),
                  ],
                ),
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;
  const CategoryTile({Key? key, this.imageUrl, this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CategoryNews(category: categoryName.toString().toLowerCase()),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imageUrl,
                width: 140,
                height: 80,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 140,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black26),
              child: Text(
                categoryName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
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
            ],
          ),
        ),
      ),
    );
  }
}
