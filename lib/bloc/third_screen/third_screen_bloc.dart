import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:suitmedia_km_test/utils/dio_client.dart';
import 'package:suitmedia_km_test/bloc/third_screen/third_screen_event.dart';
import 'package:suitmedia_km_test/bloc/third_screen/third_screen_state.dart';

class ThirdScreenBloc extends Bloc<ThirdScreenEvent, ThirdScreenState> {
  final DioClient dioClient;

  ThirdScreenBloc(this.dioClient) : super(Initial()) {
    on<FetchData>(onFetchData);
    on<FetchMoreData>(onFetchMoreData);
  }

  FutureOr<void> onFetchData(
    FetchData event,
    Emitter<ThirdScreenState> emit,
  ) async {
    try {
      emit(Loading());

      final response = await dioClient.fetchData(page: event.page!);

      if (response.data!.isEmpty) {
        emit(Empty());
      } else {
        emit(Success(data: response.data));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        emit(Error(message: 'No Internet Connection'));
      } else {
        emit(Error(message: "There's something Error on your request."));
      }
    }
  }

  FutureOr<void> onFetchMoreData(
    FetchMoreData event,
    Emitter<ThirdScreenState> emit,
  ) async {
    try {
      final response = await dioClient.fetchData(page: event.page!);

      emit(Success(data: response.data));
    } on DioException catch (e) {
      emit(Error(message: e.message));
      rethrow;
    }
  }
}
