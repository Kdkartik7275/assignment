import 'package:fpdart/fpdart.dart';
import 'package:internship_assignment/core/common/exceptions/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultVoid = Future<Either<Failure, void>>;

typedef ResultStream<T> = Stream<Either<Failure, T>>;
