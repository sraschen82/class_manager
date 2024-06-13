import 'package:asp/asp.dart';

import 'package:class_manager_two/app/comum/mobile_access.dart';
import 'package:class_manager_two/app/home_page/atoms/home_page_atoms.dart';
import 'package:class_manager_two/app/home_page/atoms/page_status_atoms.dart';
import 'package:class_manager_two/app/home_page/home_page_states.dart';
import 'package:class_manager_two/app/injector.dart';
import 'package:class_manager_two/app/repositories/isar_repository.dart';

class HomePageReducer extends Reducer {
  IsarRepository repository = autoInjector.get(key: 'isar');
  HomePageReducer() {
    on(() => [fetchSchedulesAction], _fetchSchedulesAction);
    on(() => [uploadSchedulesAction], _uploadSchedules);
    on(() => [deleteSchedulesAction], _deleteSchedules);
  }

  _fetchSchedulesAction() async {
    try {
      imagePathAtom.setValue(await repository.fetchSchedules());
    } catch (e) {
      imagePathAtom.setValue(null);
    }
  }

  _uploadSchedules() async {
    pageStatusAtom.setValue(PageStates.LOADING);
    final String? path = await MyMobile().selectImage();

    try {
      if (path != null) {
        await repository.saveSchedules(path);

        imagePathAtom.setValue(path);
        pageStatusAtom.setValue(PageStates.HOME_PAGE);
      }
    } catch (e) {
      imagePathAtom.setValue(null);
      errorHPAtom.setValue(e.toString());
      pageStatusAtom.setValue(PageStates.ERROR);
      await Future.delayed(const Duration(seconds: 4));
      pageStatusAtom.setValue(PageStates.HOME_PAGE);
    }
    // fetchSchedulesAction();
  }

  _deleteSchedules() async {
    pageStatusAtom.setValue(PageStates.LOADING);
    try {
      await repository.deleteSchedules();
      imagePathAtom.setValue(null);
    } catch (e) {
      errorHPAtom.setValue(e.toString());
      pageStatusAtom.setValue(PageStates.ERROR);
      await Future.delayed(const Duration(seconds: 4));
      pageStatusAtom.setValue(PageStates.HOME_PAGE);
    }

    pageStatusAtom.setValue(PageStates.HOME_PAGE);
  }
}
