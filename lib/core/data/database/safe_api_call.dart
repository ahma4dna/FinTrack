

import 'package:fintrack/core/data/error_handling/error_handling.dart';
import 'package:fintrack/core/domain/models/failure.dart';
import 'package:fpdart/fpdart.dart';

// Future<Either<Failure, T>> safeApiCall<T>({
 
//   required Future<T> Function() databaeCall,
// }) async {
 
//     try {
//       final response = await databaeCall();
//       return Right(response);
//     } on Failure catch (error) {
//       return Left(ErrorHandling.handel(error).failure);
//     } catch (error) {
//       return Left(ErrorHandling.handel(error).failure);
//     }
  
// }

