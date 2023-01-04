abstract class DataState<T> {
}

class DataSuccess<T> extends DataState<T>{
  T? data;
  DataSuccess(this.data);
}

class DataFailed<T> extends DataState<T>{
  String errorMessage;
  DataFailed(this.errorMessage);
}