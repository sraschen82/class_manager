import 'package:auto_injector/auto_injector.dart';

import 'package:class_manager_two/app/repositories/isar_repository.dart';

final autoInjector = AutoInjector();

registerInstances() async {
  autoInjector.add(IsarRepository.new, key: 'isar');
  autoInjector.commit();
}
