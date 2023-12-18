import 'package:book_library/ui/book_add.dart';
import 'package:book_library/ui/custom_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BookAdd bookAdd = const BookAdd();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book List"),
        titleTextStyle: Theme.of(context)
            .textTheme
            .headlineLarge
            ?.copyWith(color: Colors.green),
      ),
      floatingActionButton: _fabButton,
      body: ListView.separated(
        itemCount: 5,
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemBuilder: (context, index) {
          return CustomCard(
            title: "hello",
            subtitle: "$index",
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "book",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: "buy",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "ayarlar",
          ),
        ],
      ),
    );
  }

  // crate _fabbutton widget
  Widget get _fabButton => FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => bookAdd));
        },
        child: const Icon(Icons.add),
      );
}
