import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_arch_news_flutter/features/news/domain/entity/article_model.dart';
import 'package:flutter/material.dart';

class NewsItem extends StatelessWidget {
  final Article article;
  final Function(String url) onItemClick;

  const NewsItem({super.key, required this.article, required this.onItemClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onItemClick(article.url.toString()),
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
          child: Card(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(13),
                      topRight: Radius.circular(13),
                    ),
                    child: CachedNetworkImage(
                      cacheKey: article.imgUrl,
                      width: double.infinity,
                      height: 200,
                      imageUrl: article.imgUrl.toString(),
                      placeholder: (context, url) {
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorWidget: (context, url, error) {
                        return const Icon(Icons.error);
                      },
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                    child: Text(
                      article.title.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Text(
                      article.description.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
