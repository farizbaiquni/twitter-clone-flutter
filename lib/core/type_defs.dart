import 'package:either_dart/either.dart';
import 'package:twitter_clone_flutter/core/failure.dart';

typedef AppFutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = AppFutureEither<void>;
