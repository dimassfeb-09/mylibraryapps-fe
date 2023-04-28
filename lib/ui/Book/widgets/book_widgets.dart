import 'package:flutter/material.dart';

import '../../../data/models/book.dart';

SizedBox imageFound(AsyncSnapshot<String?> snapshot, {double height = 135, double width = 88}) {
  return SizedBox(
    height: height,
    width: width,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(snapshot.data!, fit: BoxFit.cover),
    ),
  );
}

Container imageNotFound({double height = 135, double width = 88}) {
  return Container(
    alignment: Alignment.center,
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: Colors.grey[300],
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
