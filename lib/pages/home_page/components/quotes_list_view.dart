import 'package:quotes_app/headers.dart';
import '../../../modals/quote_modal.dart';
import '../../../utills/quote_utills.dart';

Widget quotesListView() {
  return Expanded(
    flex: 12,
    child: ListView.separated(
      itemCount: allQuotes.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.detailpage,
            arguments: allQuotes[index],
          );
        },
        child: ExpansionTile(
          title: Text(allQuotes[index].quote),
          children: [
            Text("Author: ${allQuotes[index].author}"),
            Text("Category: ${allQuotes[index].category}"),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.detailpage,
                  arguments: allQuotes[index],
                );
              },
              icon: const Icon(Icons.edit),
            )
          ],
        ),
      ),
      separatorBuilder: (context, index) => const Divider(
        indent: 16,
        endIndent: 16,
      ),
    ),
  );
}
