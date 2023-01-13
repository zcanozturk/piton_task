import 'package:piton_task/core/constants/app/app_constants.dart';
import 'package:piton_task/core/constants/enums/locale_keys_enum.dart';
import 'package:piton_task/core/network/network_helper.dart';
import 'package:piton_task/view/home/model/home_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vexana/vexana.dart';

import '../model/product_response.dart';

abstract class IHomeService {
  INetworkManager networkManager;
  IHomeService(this.networkManager);

  Future<HomeModel?> fetchCategories();
}

class HomeService extends IHomeService with NetworkHelper {
  HomeService(INetworkManager networkManager) : super(networkManager);
  final box = GetStorage();

  @override
  Future<HomeModel?> fetchCategories() async {
    final response = await networkManager.send<HomeModel, HomeModel>(
      ApplicationConstants.appCategoryReqURL,

      //  queryParameters:
      //     Map.fromEntries([MapEntry('personelGuid', personelGuid)]),
      parseModel: HomeModel(),
      method: RequestType.GET,
      // options: Options(// jwt can be written like in core/const/enums/get_s
      //     headers: {
      //   'Authorization': box.read(PreferencesKeys.TOKEN.toString())
      // })
    );
    return response.data ?? null;
  }

  
}
