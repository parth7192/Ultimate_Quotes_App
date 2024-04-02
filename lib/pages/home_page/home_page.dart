import 'dart:math';
import 'package:quotes_app/headers.dart';
import 'package:quotes_app/modals/quote_modal.dart';
import 'package:quotes_app/pages/home_page/components/category_list.dart';
import 'package:quotes_app/pages/home_page/components/quotes_grid_view.dart';
import 'package:quotes_app/pages/home_page/components/quotes_list_view.dart';
import '../../utills/quote_utills.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void showRandomQuote() {
    Random r = Random();

    String category = "art";

    List<Quote> l = allQuotes
        .where(
          (element) => element.category == category,
        )
        .toList();

    Quote q = l[r.nextInt(l.length)];

    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text("Welcome !!"),
        contentPadding: const EdgeInsets.all(16),
        children: [
          Text(q.quote),
        ],
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        showRandomQuote();
      },
    );
    super.initState();
  }

  bool _isList = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        isList: _isList,
        toggleList: () {
          _isList = !_isList;
          setState(() {});
        },
      ),
      drawer: const Drawer(),
      body: Column(
        children: [
          //Categories
          categoryList(),
          //Quotes
          _isList ? quotesListView() : quotesGridView(),
        ],
      ),
    );
  }
}
