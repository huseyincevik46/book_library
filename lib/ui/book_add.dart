import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookAdd extends StatefulWidget {
  const BookAdd({super.key});

  @override
  State<BookAdd> createState() => _BookAddState();
}

@override
State<BookAdd> createState() => _BookAddState();

class _BookAddState extends State<BookAdd> {
  Future createbook(
      {required String id,
      required String kitapAdi,
      required String yazarlar,
      required kategori,
      required int sayfaSayisi,
      required int basimYili}) async {
    // ignore: unused_local_variable
    var booksadd = FirebaseFirestore.instance.collection('Books').doc();

    final books = books(
        id: booksadd.id,
        kitapAdi: kitapAdi,
        yazarlar: yazarlar,
        kategori: kategori,
        sayfaSayisi: sayfaSayisi,
        basimYili: basimYili);

    await booksadd.set(books.toJson());
  }
}

GlobalKey<FormState> formkey = GlobalKey(debugLabel: "formkey");

TextEditingController bookNameController = TextEditingController();
TextEditingController pageCountController = TextEditingController();
TextEditingController authorController = TextEditingController();
TextEditingController yearofpublication = TextEditingController();
// TextEditingController selectedCategory = TextEditingController();
String? selectedCategory;
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Kitap Ekle"),
    ),
    body: Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formkey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: bookNameController,
                decoration: const InputDecoration(labelText: "Kitap adi"),
              ),
              TextFormField(
                controller: pageCountController,
                decoration: const InputDecoration(labelText: "Sayfa Sayisi"),
              ),
              TextFormField(
                controller: authorController,
                decoration: const InputDecoration(labelText: "Yazarlar"),
              ),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(labelText: "Kategori"),
                items: const [
                  DropdownMenuItem(
                    value: "roman",
                    child: Text("Roman"),
                  ),
                  DropdownMenuItem(
                    value: "hikaye",
                    child: Text("Hikaye"),
                  ),
                  DropdownMenuItem(
                    value: "tarih",
                    child: Text("Tarih"),
                  ),
                  DropdownMenuItem(
                    value: "siir",
                    child: Text("Şiir"),
                  ),
                ],
                onChanged: (newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
              ),
              TextFormField(
                controller: yearofpublication,
                decoration: const InputDecoration(labelText: "Basim yili"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  foregroundColor: Colors.black,
                  disabledForegroundColor: Colors.red,
                ),
                onPressed: () async {
                  final kitabAdi = bookNameController.text;
                  final sayfaSayisi = pageCountController.hashCode;
                  final kategori = selectedCategory;
                  final yazarlar = authorController.text;
                  final basimYili = yearofpublication.hashCode;

                  final documentReference = await createbook(
                    kitapAdi: kitabAdi,
                    sayfaSayisi: sayfaSayisi,
                    yazarlar: yazarlar,
                    kategori: kategori,
                    basimYili: basimYili,
                  );
                },
                child: Text(
                  "Add",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class books {
  String id;
  final String kitabAdi;
  final int sayfaSayisi;
  final String yazarlar;
  final String kategori;
  final int basimYili;

  books(
      {this.id = '',
      required this.kitabAdi,
      required this.sayfaSayisi,
      required this.yazarlar,
      required this.kategori,
      required this.basimYili});

  Map<String, dynamic> toJson() => {
        'id': id,
        "Kitap adi": kitabAdi,
        "Sayfa Sayisi": sayfaSayisi,
        "Kategori": kategori,
        "Basim Yili": basimYili,
        "Yazarlar": yazarlar
      };

  static books fromJson(Map<String, dynamic> json) => books(
      kitabAdi: json["id"],
      sayfaSayisi: json["Sayfa Sayisi"],
      yazarlar: json["Yazarlar"],
      kategori: json["Kategori"],
      basimYili: json["Basim Yili"]);
}
