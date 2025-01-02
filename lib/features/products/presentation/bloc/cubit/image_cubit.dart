import 'package:bloc/bloc.dart';

class ImageCubit extends Cubit<String> {
  ImageCubit(String initialImage) : super(initialImage);

  void updateMainImage(String newImage) {
    emit(newImage);
  }
}
