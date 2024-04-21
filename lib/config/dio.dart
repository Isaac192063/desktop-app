import 'package:dio/dio.dart';

final dio = Dio()
  ..options = BaseOptions(
    validateStatus: (_) => true, // Permitir todos los códigos de estado
  );
