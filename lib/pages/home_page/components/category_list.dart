import 'package:quotes_app/headers.dart';
import '../../../utills/quote_utills.dart';

Widget categoryList() {
  return Expanded(
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: allCategories
          .map(
            (e) => Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(),
              ),
              child: Text(e),
            ),
          )
          .toList(),
    ),
  );
}
