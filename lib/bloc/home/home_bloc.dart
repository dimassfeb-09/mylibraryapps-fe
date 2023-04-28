import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mylibraryapps/utils/url.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeGetUserInfoEvent>((event, emit) async {
      try {
        final response = await http.get(Uri.parse("$url/user/get?uuid=${event.uuid}"));
        if (response.statusCode == 200) {
          print(response.body);
        } else {
          throw response.body;
        }
      } catch (e) {
        print(e);
      }
    });
  }
}
