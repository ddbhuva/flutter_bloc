import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../utils/app_exception.dart';
import '../model/add_data_model.dart';
import '../model/get_data_model.dart';
import '../repository/crud_repository.dart';
import 'package:dio/dio.dart' as dio;

part 'crud_api_event.dart';

part 'crud_api_state.dart';

class CrudApiBloc extends Bloc<CrudApiEvent, CrudApiState> {
  final CrudRepository crudRepository;
  AddDataModel addDataModel = AddDataModel();
  String reqParams = "";
  String apiUrl = "";

  @override
  CrudApiBloc(this.crudRepository) : super(CrudApiInitial()) {
    on<CrudApiEvent>((event, emit) async {
      emit(CrudApiInitial());
    });

    on<GetEvent>(_onGetData);
    on<PostEvent>(_onAddData);
    on<UpdateEvent>(_onUpdateData);
    on<DeleteEvent>(_onDeleteData);
  }

  Future<void> _onGetData(
      CrudApiEvent event, Emitter<CrudApiState> emit) async {
    if (event is GetEvent) {
      emit(CrudApiLoading());
      try {
        var response = await crudRepository
            .getData(url: apiUrl,);
          debugPrint('===========================>');
          debugPrint('response: $response');
        if(response is dio.Response) {
          if (response.statusCode == 200 || response.statusCode == 201) {
            debugPrint('statusCode 200');
            var getUsersData = response.data['data'] as List;
            debugPrint('getUsersData: $getUsersData');
            var listUsers =
            getUsersData.map((i) => DataItem.fromJson(i)).toList();
            debugPrint('listUsers: $listUsers');
            emit(CrudGetListState(getDataList: listUsers));
          } else {
            await checkStatusCode(response).then((statusResponse) async {
              if (statusResponse) {
                _onGetData(event, emit);
              } else {
                debugPrint('error: ${response.data}');
                emit(CrudErrorState(error: response.data.toString()));
              }
            });
          }
        }else{
          debugPrint('error: ${response.data}');
          emit(CrudErrorState(error: response.data.toString()));
        }
      } catch (e) {
        debugPrint('error: $e');
        emit(CrudErrorState(error: e.toString()));
      }
    }
  }

  Future<void> _onAddData(
      CrudApiEvent event, Emitter<CrudApiState> emit) async {
    if (event is PostEvent) {
      emit(CrudApiLoading());
      try {
        var response = await crudRepository
            .postData(url: apiUrl, dataPost: reqParams);
          debugPrint('===========================>');
          debugPrint('response: $response');
        if(response is dio.Response) {
          if (response.statusCode == 200 || response.statusCode == 201) {
            debugPrint('statusCode 200');
            Map<String, dynamic> map = jsonDecode(response.toString());
            addDataModel = AddDataModel.fromJson(map);
            emit(CrudLoadedState(addDataModel));
            emit(CrudSuccessState());
          } else {
            await checkStatusCode(response).then((statusResponse) async {
              if (statusResponse) {
                _onAddData(event, emit);
              }else {
                debugPrint('error: ${response.data}');
                emit(CrudErrorState(error: response.data.toString()));
              }
            });
          }
        }else{
          debugPrint('error: ${response.data}');
          emit(CrudErrorState(error: response.data.toString()));
        }
      } catch (e) {
        debugPrint('error: $e');
        emit(CrudErrorState(error: e.toString()));
      }
    }
  }

  Future<void> _onUpdateData(
      CrudApiEvent event, Emitter<CrudApiState> emit) async {
    if (event is UpdateEvent) {
      emit(CrudApiLoading());
      try {
        var response =  await crudRepository
            .putData(url: apiUrl, dataPost: reqParams);
          debugPrint('===========================>');
          debugPrint('response: $response');
        if(response is dio.Response) {
          if (response.statusCode == 200 || response.statusCode == 201) {
            debugPrint('statusCode 200');
            Map<String, dynamic> map = jsonDecode(response.toString());
            addDataModel = AddDataModel.fromJson(map);
            emit(CrudLoadedState(addDataModel));
            emit(CrudSuccessState());
          } else {
            await checkStatusCode(response).then((statusResponse) async {
              if (statusResponse) {
                _onUpdateData(event, emit);
              } else {
                debugPrint('error: ${response.data}');
                emit(CrudErrorState(error: response.data.toString()));
              }
            });
          }
        }else{
          debugPrint('error: ${response.data}');
          emit(CrudErrorState(error: response.data.toString()));
        }
      } catch (e) {
        debugPrint('error: $e');
        emit(CrudErrorState(error: e.toString()));
      }
    }
  }

  Future<void> _onDeleteData(
      CrudApiEvent event, Emitter<CrudApiState> emit) async {
    if (event is DeleteEvent) {
      emit(CrudApiLoading());
      try {
        var response = await crudRepository.deleteData(url: apiUrl);
          debugPrint('===========================>');
          debugPrint('response: $response');
        if(response is dio.Response) {
          if (response.statusCode == 200 ||
              response.statusCode == 201 ||
              response.statusCode == 204) {
            debugPrint('status success');
            emit(CrudSuccessState());
          } else {
            await checkStatusCode(response).then((statusResponse) async {
              if (statusResponse) {
                _onDeleteData(event, emit);
              } else {
                debugPrint('error: ${response.data}');
                emit(CrudErrorState(error: response.data.toString()));
              }
            });
          }
        }else{
          debugPrint('error: ${response.data}');
          emit(CrudErrorState(error: response.data.toString()));
        }
      } catch (e) {
        debugPrint('error: $e');
        emit(CrudErrorState(error: e.toString()));
      }
    }
  }
}
