part of 'crud_api_bloc.dart';

abstract class CrudApiState extends Equatable {
  const CrudApiState();

  @override
  List<Object> get props => [];
}

class CrudApiInitial extends CrudApiState {
  @override
  List<Object> get props => [];
}

class CrudApiLoading extends CrudApiState {
  @override
  List<Object> get props => [];
}

class CrudErrorState extends CrudApiState{
  final String error;

  const CrudErrorState({required this.error});
}

class CrudSuccessState extends CrudApiState{

  @override
  List<Object> get props => [];
}

class CrudGetListState extends CrudApiState{
  List<DataItem> getDataList = [];

  CrudGetListState({required this.getDataList});

  @override
  List<Object> get props => [getDataList];
}

class CrudLoadedState extends CrudApiState {
  final AddDataModel data;
  const CrudLoadedState(this.data);

  @override
  List<Object> get props => [data];
}
