import 'package:internship_assignment/core/common/usecase/usecase.dart';
import 'package:internship_assignment/core/utils/constants/typedefs.dart';
import 'package:internship_assignment/features/products/domain/entity/product_entity.dart';
import 'package:internship_assignment/features/products/domain/repository/products_repository.dart';

class FetchProducts implements UseCaseWithoutParams<List<ProductEntity>> {
  final ProductsRepository repository;

  FetchProducts({required this.repository});
  @override
  ResultFuture<List<ProductEntity>> call() async {
    return await repository.fetchDummyProducts();
  }
}
