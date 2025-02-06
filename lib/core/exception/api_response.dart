
import 'status.dart';

class ApiResponse<T> {
  final Status status;
  final T? data;
  final String? message;

  ApiResponse._({required this.status, this.data, this.message});

  factory ApiResponse.loading() => ApiResponse._(status: Status.loading);

  factory ApiResponse.success(T data) => ApiResponse._(status: Status.success, data: data);

  factory ApiResponse.error(String message) => ApiResponse._(status: Status.error, message: message);

  // A helper method to handle different states
  R when<R>({
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String message) error,
  }) {
    switch (status) {

      case Status.loading:
        return loading();
      case Status.success:
        return success(data as T);
      case Status.error:
        return error(message!);
    }
  }

  @override
  String toString() {
    return 'ApiResponse{status: $status, data: $data, message: $message}';
  }
}