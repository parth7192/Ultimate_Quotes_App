import 'package:quotes_app/headers.dart';

AppBar appBar({
  String title = "Home Page",
  required bool isList,
  required void Function() toggleList,
}) {
  return AppBar(
    backgroundColor: const Color(0xFF2D2F41),
    foregroundColor: Colors.white,
    centerTitle: true,
    title: Text(title),
    actions: [
      IconButton(
        onPressed: toggleList,
        icon: Icon(
          isList ? Icons.grid_view_outlined : Icons.list,
        ),
      ),
    ],
  );
}
