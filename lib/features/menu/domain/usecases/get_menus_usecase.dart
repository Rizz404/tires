import 'package:fpdart/src/either.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/domain/repositories/menu_repository.dart';

class GetMenusUsecase implements Usecase<List<Menu>, NoParams> {
  final MenuRepository _menuRepository;

  GetMenusUsecase(this._menuRepository);

  @override
  Future<Either<Failure, List<Menu>>> call(NoParams params) async {
    return await _menuRepository.getMenus();
  }
}
