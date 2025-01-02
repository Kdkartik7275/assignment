import 'package:internship_assignment/core/utils/constants/typedefs.dart';
import 'package:internship_assignment/features/products/domain/entity/product_entity.dart';

abstract interface class ProductsRepository {
  ResultFuture<List<ProductEntity>> fetchDummyProducts();
}
