import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylibraryapps/bloc/book/book_bloc.dart';
import 'package:mylibraryapps/common/widgets/appbar.dart';
import 'package:mylibraryapps/common/widgets/search_textfield.dart';
import 'package:mylibraryapps/data/models/book.dart';
import 'package:mylibraryapps/ui/Book/book.dart';

import '../../bloc/category/category_bloc.dart';
import '../../bloc/genre/genre_bloc.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Category List"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 55, vertical: 22),
              child: customSearchTextField(),
            ),
            Container(
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is GetCategorysLoadingState) {
                    return const Center(child: CircularProgressIndicator.adaptive());
                  }
                  if (state is GetCategorysSuccessState) {
                    if (state.categories != null) {
                      return SizedBox(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.categories?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 219,
                              margin: const EdgeInsets.only(left: 28, right: 28, top: 22),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.categories![index].name!),
                                  const SizedBox(height: 24),
                                  listGenreByCategory(state, index)
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  BlocBuilder<GenreBloc, GenreState> listGenreByCategory(GetCategorysSuccessState state, int index) {
    return BlocBuilder<GenreBloc, GenreState>(
      bloc: GenreBloc()..add(GetGenresEvent(categoryId: state.categories![index].id!)),
      builder: (context, state) {
        if (state is GetGenresLoadingState) {
          return Container(
            alignment: Alignment.center,
            height: 171,
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is GetGenresSuccessState) {
          if (state.genres != null) {
            return gridFourthGenre(state);
          } else {
            return Container();
          }
        }
        return Container();
      },
    );
  }

  Container gridFourthGenre(GetGenresSuccessState state) {
    return Container(
      height: 171,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 171 / 74,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemCount: state.genres!.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => BookBloc()
                        ..add(GetBooksByIDEvent(
                          genreId: state.genres![index].id,
                        )),
                      child: const BookView(),
                    ),
                  ));
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(state.genres![index].name!),
            ),
          );
        },
      ),
    );
  }
}
