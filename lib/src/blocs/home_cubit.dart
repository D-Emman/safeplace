import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/constants.dart';
import '../services/local_storage_service.dart';
import 'package:intl/intl.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FirebaseFirestore _fs = FirebaseFirestore.instance;
  final LocalStorageService _local;

  HomeCubit(this._local) : super(HomeInitial());

  Future<void> loadDailyContent() async {
    emit(HomeLoading());
    try {
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final doc = await _fs.collection(dailyContentCollection).doc(today).get();
      if (doc.exists) {
        final data = doc.data()!;
        emit(HomeLoaded(message: data['message'] ?? '', advice: data['advice'] ?? ''));
      } else {
        // fallback cached or default
        emit(HomeLoaded(message: 'You are not alone.', advice: 'Try a 2-minute grounding exercise.'));
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  /// Streak logic: increment when user opens app for the first time each day.
  Future<void> markActive(String userId) async {
    try {
      final userRef = _fs.collection(usersCollection).doc(userId);
      final snap = await userRef.get();
      final now = DateTime.now().toUtc();
      final todayStr = DateTime(now.year, now.month, now.day);
      if (!snap.exists) {
        await userRef.set({'streakCount': 1, 'lastActiveDate': Timestamp.fromDate(now)});
        emit(HomeStreakUpdated(1));
        return;
      }
      final data = snap.data()!;
      final lastActiveTs = data['lastActiveDate'] as Timestamp?;
      final lastActive = lastActiveTs?.toDate().toUtc();
      if (lastActive == null) {
        await userRef.update({'streakCount': 1, 'lastActiveDate': Timestamp.fromDate(now)});
        emit(HomeStreakUpdated(1));
        return;
      }
      final lastDay = DateTime(lastActive.year, lastActive.month, lastActive.day);
      final diff = todayStr.difference(lastDay).inDays;
      if (diff == 0) {
        // already active today, nothing
        emit(HomeStreakUpdated(data['streakCount'] ?? 0));
        return;
      } else if (diff == 1) {
        final newCount = (data['streakCount'] ?? 0) + 1;
        await userRef.update({'streakCount': newCount, 'lastActiveDate': Timestamp.fromDate(now)});
        emit(HomeStreakUpdated(newCount));
      } else {
        // missed days -> reset streak
        await userRef.update({'streakCount': 1, 'lastActiveDate': Timestamp.fromDate(now)});
        emit(HomeStreakUpdated(1));
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
