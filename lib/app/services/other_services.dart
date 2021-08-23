// import 'dart:convert';

// import 'package:get_storage/get_storage.dart';

// import '../data/models/district.dart';
// import '../data/models/taluk.dart';
// import '../utils/api_helper/api_helper.dart';
// import '../utils/api_urls.dart';
// import '../utils/global_widgets.dart';

// class OtherServices {
//   static final apiHelper = ApiHelper();
//   static final box = GetStorage();

//   static Future<List<District>> getDistricts() async {
//     try {
//       final Map<String, dynamic> apiResponse =
//           await apiHelper.getData(ApiUrls.GET_DISTRICTS);
//       if (apiResponse['success'] as bool) {
//         final jsonData = jsonDecode(apiResponse['data'] as String);
//         if (jsonData['status'] as bool) {
//           final List<District> districtList = List<District>.from(
//             (jsonData['data']['district'] as List<dynamic>)
//                 .map((e) => District.fromJson(e as Map<String, dynamic>))
//                 .toList(),
//           );
//           return districtList;
//         } else {
//           showSnackBar(
//             type: SnackbarType.error,
//             message: jsonData['data'] as String,
//           );
//           return [];
//         }
//       } else {
//         showSnackBar(
//           type: SnackbarType.error,
//           message: apiResponse['data'] as String,
//         );
//         return [];
//       }
//     } catch (e) {
//       showSnackBar(
//         type: SnackbarType.error,
//         message: 'Error occured. Please try again later.',
//       );
//       return [];
//     }
//   }

//   static Future<List<Taluk>> getTaluk({required String districtId}) async {
//     try {
//       final Map<String, dynamic> apiResponse = await apiHelper
//           .getData(ApiUrls.GET_TALUKS, query: {'District': districtId});
//       if (apiResponse['success'] as bool) {
//         final jsonData = jsonDecode(apiResponse['data'] as String);
//         if (jsonData['status'] as bool) {
//           final List<Taluk> districtList = List<Taluk>.from(
//             (jsonData['data']['taluk'] as List<dynamic>)
//                 .map((e) => Taluk.fromJson(e as Map<String, dynamic>))
//                 .toList(),
//           );
//           return districtList;
//         } else {
//           showSnackBar(
//             type: SnackbarType.error,
//             message: jsonData['data'] as String,
//           );
//           return [];
//         }
//       } else {
//         showSnackBar(
//           type: SnackbarType.error,
//           message: apiResponse['data'] as String,
//         );
//         return [];
//       }
//     } catch (e) {
//       showSnackBar(
//         type: SnackbarType.error,
//         message: 'Error occured. Please try again later.',
//       );
//       return [];
//     }
//   }
// }
