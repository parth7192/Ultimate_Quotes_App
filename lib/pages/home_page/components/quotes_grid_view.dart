import 'package:quotes_app/headers.dart';
import '../../../utills/quote_utills.dart';

Widget quotesGridView() {
  return Expanded(
    flex: 12,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      // MasonryGridView.count(
      //   crossAxisCount: 4,
      //   mainAxisSpacing: 4,
      //   crossAxisSpacing: 4,
      //   itemBuilder: (context, index) {
      //     return Tile(
      //       index: index,
      //       extent: (index % 5 + 1) * 100,
      //     );
      //   },
      // );
      child: Scrollbar(
        thickness: 10,
        interactive: true,
        child: GridView.builder(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4 / 5,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: allQuotes.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.detailpage,
                arguments: allQuotes[index],
              );
            },
            child: Card(
              color: const Color(0xFF2D2F41),
              // primaries[index % 18].shade400,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      allQuotes[index].quote,
                      maxLines: 8,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text("- ${allQuotes[index].author}"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
