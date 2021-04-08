import 'package:FlutterNews/models/articleModel.dart';
import 'package:FlutterNews/models/categoryModel.dart';
import 'package:FlutterNews/models/data.dart';
import 'package:FlutterNews/provider/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();

  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
      ),
      body: _isLoading
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: articles.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return AllNews(
                    description: articles[index].description,
                    image: articles[index].urlToImage,
                    title: articles[index].title);
              },
            ),
//      body: Column(
//        children: [
//          Padding(
//            padding: const EdgeInsets.all(10.0),
//            child: Container(
//              height: 55,
//              width: double.infinity,
//              decoration: BoxDecoration(
//                color: Colors.white,
//                borderRadius: BorderRadius.all(
//                  Radius.circular(50),
//                ),
//              ),
//              child: Row(
//                children: [
//                  Padding(
//                    padding: const EdgeInsets.only(left: 10),
//                    child: Icon(Icons.search),
//                  ),
//                  SizedBox(
//                    width: 20,
//                  ),
//                  Text('Search'),
//                ],
//              ),
//            ),
//          ),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceAround,
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: [
//              Text(
//                'Trending',
//                style: TextStyle(fontWeight: FontWeight.bold),
//              ),
//              Text('Sports'),
//              Text('Economy'),
//              Text('Fashion'),
//            ],
//          ),
//          SizedBox(
//            height: 8,
//          ),
//          Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//            child: Container(
//              height: 110,
//              child: ListView.builder(
//                itemCount: categories.length,
//                scrollDirection: Axis.horizontal,
//                itemBuilder: (context, index) {
//                  return CategoryTile(
//                    categoryName: categories[index].categoryName,
//                    imageUrl: categories[index].imageUrl,
//                    description: categories[index].description,
//                  );
//                },
//              ),
//            ),
//          ),
//          Align(
//            alignment: Alignment.topLeft,
//            child: Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
//              child: Text(
//                'Top News',
//                style: TextStyle(fontWeight: FontWeight.bold),
//              ),
//            ),
//          ),
//          Container(
//            height: 500,
//            width: double.infinity,
//            child: ListView.builder(
//              itemCount: articles.length,
//              scrollDirection: Axis.vertical,
//              itemBuilder: (context, index) {
//                return AllNews(
//                    description: articles[index].description,
//                    date: articles[index].publishedAt,
//                    image: articles[index].urlToImage,
//                    title: articles[index].title);
//              },
//            ),
//          )
//          Container(
//            height: 500,
//            width: double.infinity,
//            child: Padding(
//              padding: const EdgeInsets.all(8),
//              child: Container(
//                decoration: BoxDecoration(
//                  color: Colors.grey[200],
//                  borderRadius: BorderRadius.all(
//                    Radius.circular(30),
//                  ),
//                ),
//                height: 120,
//                width: double.infinity,
//                child: ListView.builder(
//                    itemCount: articles.length,
//                    scrollDirection: Axis.vertical,
//                    itemBuilder: (context, index) {
//                      return AllNews(
//                          description: articles[index].description,
//                          date: articles[index].publishedAt,
//                          image: articles[index].urlToImage,
//                          title: articles[index].title);
//                    }),
//              ),
//            ),
//          )
//        ],
//      ),
    );
  }
}

class AllNews extends StatelessWidget {
  final description, image, title;
  AllNews({this.description, this.image, this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      height: 300,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: 200,
            child: Image.network(
              image,
              width: double.infinity,
              height: 200,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            height: 100,
            child: Text(description),
          )
        ],
      ),
    );
//    return Row(
//      children: [
//        Container(
//          decoration: BoxDecoration(
//            color: Colors.red,
//            borderRadius: BorderRadius.only(
//              topLeft: Radius.circular(30),
//              bottomLeft: Radius.circular(30),
//            ),
//          ),
//          height: 120,
//          width: 110,
//          child: Image.network(image),
//        ),
//        Column(
//          children: [
//            Padding(
//              padding: const EdgeInsets.only(top: 8),
//              child: Container(
//                width: 130,
//                child: Text(
//                  title,
//                  style: TextStyle(fontWeight: FontWeight.bold),
//                ),
//              ),
//            ),
//            Padding(
//              padding: const EdgeInsets.only(top: 20, left: 8),
//              child: Container(
//                width: 130,
//                child: Text(description),
//              ),
//            ),
//          ],
//        ),
//        Align(
//          alignment: Alignment.topCenter,
//          child: Padding(
//            padding: const EdgeInsets.only(top: 8),
//            child: Text('08/04/2021'),
//          ),
//        ),
//      ],
//    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName, description;
  CategoryTile({this.imageUrl, this.categoryName, this.description});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            margin: const EdgeInsets.only(right: 6),
            height: 110,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Image.network(imageUrl)),
        Positioned(
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            height: 40,
            width: 100,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    'Entertainment',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 10),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 5),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Lorem Ipsum has been the industry standard dummy',
                      style: TextStyle(fontSize: 7, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
