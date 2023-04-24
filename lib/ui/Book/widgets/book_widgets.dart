import 'package:flutter/material.dart';

import '../../../data/models/book.dart';

SizedBox imageFound(AsyncSnapshot<String?> snapshot) {
  return SizedBox(
    height: 135,
    width: 88,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(snapshot.data!, fit: BoxFit.cover),
    ),
  );
}

Container imageNotFound() {
  return Container(
    alignment: Alignment.center,
    height: 135,
    width: 88,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(20),
    ),
    child: const Text(
      "Image Not Found",
      textAlign: TextAlign.center,
    ),
  );
}

Column infoDetailBook(Book book) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        book.title!,
        style: const TextStyle(fontSize: 16),
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/rating.png", height: 14, width: 14),
              Text(book.rating! == 0.0 ? "0" : book.rating!.toStringAsFixed(1)),
            ],
          ),
          const SizedBox(width: 25),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/stock.png", height: 14, width: 14),
              Text(book.stok.toString()),
            ],
          ),
          const SizedBox(width: 25),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/borrow.png", height: 14, width: 14),
              Text(book.rating.toString()),
            ],
          ),
        ],
      ),
      const SizedBox(height: 10),
      Container(
        height: 55,
        width: 249,
        child: Text(
          book.description!,
          textAlign: TextAlign.justify,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    ],
  );
}
