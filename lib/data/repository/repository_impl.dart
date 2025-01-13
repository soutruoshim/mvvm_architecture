import 'package:dartz/dartz.dart';
import 'package:mvvm_architecture/data/mapper/mapper.dart';

import '../../domain/model/model.dart';
import '../../domain/repository/repository.dart';
import '../data_source/remote_data_source.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';
import '../request/request.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {

    if (await _networkInfo.isConnected) {
      // its safe to call the API
      try {
        // its safe to call the API
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == ApiInternalStatus.SUCCESS) // success
            {
          // return data (success)
          // return right
          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      }catch (error) {
        return Left(ErrorHandler.handle(error));
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}