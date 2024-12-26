import 'package:core/core.dart';
import 'package:people/src/services/contacts_device_service.dart';

import '../entities/person.dart';

class ListAllPeople extends Request<List<Person>> {}

class ListAllPeopleHandler extends RequestHandler<ListAllPeople, List<Person>> {
  ListAllPeopleHandler();

  @override
  Future<List<Person>> handle(ListAllPeople request) async {
    return ContactsDeviceService.getPeopleOnDevice();
  }
}