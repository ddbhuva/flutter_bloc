part of 'crud_api_bloc.dart';

abstract class CrudApiEvent extends Equatable {
  const CrudApiEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ErrorEvent extends CrudApiEvent{
  final String message;
  ErrorEvent({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class CrudFetchEvent extends CrudApiEvent{
  const CrudFetchEvent();
}

class GetEvent extends CrudApiEvent{
  GetEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PostEvent extends CrudApiEvent{
  final Object object;
  PostEvent({required this.object});

  @override
  // TODO: implement props
  List<Object?> get props => [object];
}

class UpdateEvent extends CrudApiEvent{
  final Object object;
  UpdateEvent({required this.object});
  @override
  // TODO: implement props
  List<Object?> get props => [object];
}

class DeleteEvent extends CrudApiEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
