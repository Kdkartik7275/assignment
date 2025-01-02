import 'package:fpdart/fpdart.dart';
import 'package:internship_assignment/core/common/exceptions/failure.dart';
import 'package:internship_assignment/core/utils/constants/typedefs.dart';
import 'package:internship_assignment/features/products/data/data_source/products_remote_data_source.dart';
import 'package:internship_assignment/features/products/domain/entity/product_entity.dart';
import 'package:internship_assignment/features/products/domain/repository/products_repository.dart';

class ProductRepoImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;

  ProductRepoImpl({required this.remoteDataSource});
  @override
  ResultFuture<List<ProductEntity>> fetchDummyProducts() async {
    try {
      final data = await remoteDataSource.fetchDummyProducts();

      return right(data);
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }
}
