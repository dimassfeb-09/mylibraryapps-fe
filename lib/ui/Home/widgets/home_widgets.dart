import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylibraryapps/bloc/genre/genre_bloc.dart';
import 'package:mylibraryapps/controller/book_controller.dart';
import 'package:mylibraryapps/controller/genre_controller.dart';

import '../../../bloc/category/category_bloc.dart';
import '../../../bloc/book/book_bloc.dart';
import '../../Book/book.dart';
import '../../Category/category_view.dart';

Widget customHomeBanner() {
  return Container(
    height: 195,
    decoration: const BoxDecoration(
      color: Colors.grey,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage("assets/images/banner_home.png"),
      ),
    ),
  );
}

Widget customDropDownListBook(BuildContext context) {
  BookState state = context.read<BookBloc>().state;
  return Visibility(
    visible: state.query != "" ? true : false,
    child: Container(
      margin: const EdgeInsets.only(top: 70, left: 55, right: 55),
      height: state.books != null ? 320 : 100,
      width: 320,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: state.books != null
          ? ListView.builder(
              itemCount: state.books!.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 120,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 80,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.books![index].title!,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              state.books![index].description!,
                              maxLines: 4,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : const Center(
              child: Text("Tidak ada data"),
            ),
    ),
  );
}

Widget menuCategory(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 220, left: 20, right: 20),
    height: 110,
    child: GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 2 / 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: 8,
      itemBuilder: (BuildContext ctx, index) {
        return GestureDetector(
          onTap: () {
            if (categories[index].id == 0) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => CategoryBloc()..add(GetCategorysEvent()),
                    child: const CategoryView(),
                  ),
                ),
              );
              return;
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => BookBloc()..add(GetBooksByIDEvent(categoryId: index)),
                  child: const BookView(),
                ),
              ));
              return;
            }
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: index != 7 ? const Color(0xFF00235B) : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              categories[index].name!,
              style: const TextStyle(
                color: Color(0XFF00235B),
              ),
            ),
          ),
        );
      },
    ),
  );
}
