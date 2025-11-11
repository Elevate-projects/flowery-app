import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/models/order/order_model.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/core/constants/app_collections.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/constants/const_keys.dart';
import 'package:flowery_app/core/exceptions/firebase_exceptions.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/data/data_source/track_order_progress/remote_data_source/track_order_progress_remote_data_source.dart';
import 'package:flowery_app/domain/entities/order/order_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackOrderProgressRemoteDataSource)
class TrackOrderProgressRemoteDataSourceImpl
    implements TrackOrderProgressRemoteDataSource {
  final FirebaseFirestore _firestore;
  const TrackOrderProgressRemoteDataSourceImpl(this._firestore);

  @override
  Stream<Result<OrderEntity?>> fetchTrackedOrderData({
    required String orderId,
  }) async* {
    try {
      final bool connection = await ConnectionManager.checkConnection();
      if (connection) {
        yield* _firestore
            .collection(AppCollections.orders)
            .doc(orderId)
            .snapshots()
            .map(
              (orderSnapshot) => (orderSnapshot.data()?.isNotEmpty ?? false)
                  ? Success(
                      OrderModel.fromJson(
                        orderSnapshot.data()!,
                      ).toOrderEntity(),
                    )
                  : Success(null),
            );
      } else {
        yield Failure(
          responseException: ResponseException(
            message: AppText.connectionError.tr(),
          ),
        );
      }
    } on FirebaseException catch (error) {
      yield Failure(
        responseException: FirebaseExceptions.firebaseExceptions(
          error,
        ).responseException,
      );
    } catch (error) {
      yield Failure(
        responseException: ResponseException(
          message: "${AppText.unknownErrorMessage.tr()} ${error.toString()}",
        ),
      );
    }
  }

  @override
  Future<Result<void>> receivedOrder({required String orderId}) async {
    return await executeApi(() async {
      await _firestore.collection(AppCollections.orders).doc(orderId).update({
        "state": ConstKeys.completed,
      });
    });
  }
}
