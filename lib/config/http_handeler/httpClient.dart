import 'package:clinicapp/models/book_model.dart';
import 'package:clinicapp/models/posstion_model.dart';
import 'package:clinicapp/models/user_model.dart';
import 'package:clinicapp/services/secure_sorage_service/secure_sorage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HttpClient {
  Dio dio = Dio();
  final SecureStorageService _secureStorageService = SecureStorageService();

  String baseURL = 'http://10.0.2.2:8000/api/';

  Map<String, dynamic> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "",
  };

  HttpClient() {
    dio.options.baseUrl = baseURL;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.headers = headers;
  }

  Future setToken(String token) async {
    headers["Authorization"] = "Bearer $token";
    dio.options.headers = headers;
    await _secureStorageService.setToken(token);
  }

  Future<void> setSavedToken() async {
    String token = await _secureStorageService.getToken() ?? "";

    headers["Authorization"] = "Bearer $token";
    dio.options.headers = headers;
  }

//   Future post(String url, Map data) async {
//     try {
//       return await dio.post(url, data: data);
//     } on DioError catch (e) {
//       return e.response;
//     }
//   }

//   //AuthCheck
//   Future authCheck() async {
//     Response response = await post('/auth/check', {});
//     return {
//       "code": response.statusCode,
//       "data": response.data,
//     };
//   }

  //Signin
  Future<bool> signIn(String username, String password) async {
    final reqData = {"login": username, "password": password};
    try {
      const endpoint = 'login';
      Response response = await dio.post(endpoint, data: reqData);
      print(response.data);
      var resposndata = response.data['data'];
      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = UserModel.fromMap(resposndata['user']);
        final token = resposndata['token'];
        await setToken(token);
        await _secureStorageService.setUserData(user);
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  //Signin
  Future<bool> signUp(UserModel model) async {
    try {
      const endpoint = 'register';
      Response response = await dio.post(endpoint, data: model.toMap());
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var resposndata = response.data['data'];
        final user = UserModel.fromMap(resposndata['user']);
        final token = resposndata['token'];
        await setToken(token);
        await _secureStorageService.setUserData(user);
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  //Signout
  Future<bool> signOut() async {
    try {
      await setSavedToken();
      const endpoint = 'logout';
      Response response = await dio.post(endpoint, data: {});
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        await _secureStorageService.clearData();
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

//Add booking
  Future<bool> createbooking(BookModel model) async {
    try {
      await setSavedToken();
      const endpoint = 'addchanel';
      Response response = await dio.post(endpoint, data: model.toMap());
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

//get all booking
  Future<List<BookModel>> getbookings() async {
    List<BookModel> booklist = [];
    try {
      await setSavedToken();
      const endpoint = 'checkchennels';
      Response response = await dio.post(endpoint, data: {});
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var resposndata = response.data['data'];

        final list = resposndata['chanels'] as List;
        list.forEach((element) {
          booklist.add(BookModel.fromMap(element));
        });
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return booklist;
  }

//get posstion

  Future<PossitionModel?> getPossition(int id) async {
    final reqData = {
      "id": id,
    };
    try {
      await setSavedToken();
      const endpoint = 'yettogo';
      Response response = await dio.post(endpoint, data: reqData);
      print(response.data);
      var resposndata = response.data['data'];
      if (response.statusCode == 200 || response.statusCode == 201) {
        final posstion = PossitionModel.fromMap(resposndata);

        return posstion;
      } else {
        return null;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

//Add issue
  Future<bool> createIssue(String message) async {
    try {
      await setSavedToken();
      const endpoint = 'sendcontact';
      Response response = await dio.post(endpoint, data: {"message": message});
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

//   Future<List<Productmodel>> getAllproducts() async {
//     final response = await dio.get(baseURL + 'product/all/');
//     List<Productmodel> productlist = [];

//     print(response.data);

//     if (response.statusCode == 200) {
//       print(response.data);

//       print("--------------------");

//       return (response.data as List)
//           .map((e) => Productmodel.fromMap(e))
//           .toList();
//     } else {
//       throw Exception('Failed to load');
//     }
//   }

// //cart

// //all

//   Future<List<FetchCartModel>> getCart() async {
//     List<FetchCartModel> carttlist = [];
//     await setSavedToken();
//     final response = await dio.get(baseURL + 'cart/all');

//     print(response.data);
//     if (response.statusCode == 200) {
//       print(response.data);

//       return (response.data as List)
//           .map((e) => FetchCartModel.fromMap(e))
//           .toList();
//     } else {
//       throw Exception('Failed to load');
//     }
//   }

//   Future addCart(CartModel cartModel) async {
//     await setSavedToken();
//     final response = await post('cart/add', cartModel.toMap());
//     print(response.data);
//     return {
//       "code": response.statusCode,
//       "data": response.data,
//     };
//   }

//   Future removeCartItem(int id) async {
//     await setSavedToken();
//     final response = await dio.delete('cart/delete/$id');
//     if (kDebugMode) {
//       print(response.data);
//     }

//     return {
//       "code": response.statusCode,
//       "data": response.data,
//     };
//   }

// //wishList
//   Future<List<FetchWishListModel>> getWishList() async {
//     List<FetchWishListModel> carttlist = [];
//     await setSavedToken();
//     final response = await dio.get(baseURL + 'wishlist/all');

//     print(response.data);
//     if (response.statusCode == 200) {
//       print(response.data);

//       return (response.data as List)
//           .map((e) => FetchWishListModel.fromMap(e))
//           .toList();
//     } else {
//       throw Exception('Failed to load');
//     }
//   }

//   Future addWishList(WishListModel wishListModel) async {
//     await setSavedToken();
//     final response = await post('wishlist/add', wishListModel.toMap());
//     print(response.data);
//     return {
//       "code": response.statusCode,
//       "data": response.data,
//     };
//   }

//   Future removeWishListItem(int id) async {
//     await setSavedToken();
//     final response = await dio.delete('wishlist/delete/$id');
//     if (kDebugMode) {
//       print(response.data);
//     }

//     return {
//       "code": response.statusCode,
//       "data": response.data,
//     };
//   }

//   //order
//   Future<String> createOrder(OrderModel orderModel) async {
//     String orderid = "null";
//     try {
//       await setSavedToken();
//       final response = await post('orders/create', orderModel.toMap());
//       if (kDebugMode) {
//         print(response.data);
//       }
//       OrderModel resdata = OrderModel.fromMap(response.data);
//       orderid = resdata.id.toString();
//     } on Exception catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//     return orderid;
//   }

//   Future orderPaymentsUpdate(String id) async {
//     await setSavedToken();
//     final response = await dio.put('orders/updatePaymentStatus/' + id);
//     if (kDebugMode) {
//       print(response.data);
//     }

//     return {
//       "code": response.statusCode,
//       "data": response.data,
//     };
//   }

//   Future<List<OrderModel>> getOders() async {
//     List<OrderModel> filterdList = [];
//     final user = await UserHandeler.getUser();
//     await setSavedToken();
//     final response = await dio.post("orders/getOrders");

//     if (response.statusCode == 200) {
//       if (kDebugMode) {
//         print(response.data);
//       }
//       final orders =
//           (response.data as List).map((e) => OrderModel.fromMap(e)).toList();
//       orders.forEach((element) {
//         if (element.user_id == user.id) {
//           filterdList.add(element);
//         }
//       });
//     } else {
//       throw Exception('Failed to load');
//     }
//     return filterdList;
//   }
}

HttpClient httpClient = HttpClient();
