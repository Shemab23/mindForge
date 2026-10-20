import 'dart:async';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../network/user_repository.dart';

class AppState extends ChangeNotifier {
  final UserRepository _userRepo = UserRepository();

  bool _isSplashActive = true;
  bool _isFetching = false;
  int _activeTabIndex = 0; // 🔥 Added: Tracks active tab navigation index
  List<UserModel> _verifiedUsers = [];

  // Getters
  bool get isSplashActive => _isSplashActive;
  bool get isFetching => _isFetching;
  int get activeTabIndex =>
      _activeTabIndex; // 🔥 Added: Exposes active index to MainLayout
  List<UserModel> get verifiedUsers => _verifiedUsers;

  AppState() {
    _initInitializeSequence();
  }

  void _initInitializeSequence() {
    Timer(const Duration(seconds: 2), () {
      _isSplashActive = false;
      notifyListeners();
    });
  }

  /// 🔥 Added: Updates navigation index and triggers shell layout switch
  void updateTabIndex(int newIndex) {
    if (_activeTabIndex == newIndex) return;
    _activeTabIndex = newIndex;
    notifyListeners(); // Forces UI to repaint the chosen tab view
  }

  /// 🔥 Added: Explicit bypass method for the entry splash overlay screen
  void skipSplash() {
    _isSplashActive = false;
    notifyListeners();
  }

  /// Manages loading execution pipelines and updates state context
  Future<void> syncVerifiedUsers() async {
    _isFetching = true;
    notifyListeners();

    final startTime = DateTime.now();

    // Call the isolated network data layer
    _verifiedUsers = await _userRepo.fetchUsersFromEndpoint();

    // Enforce your minimum 1-second UI presentation rule smoothly
    final executionTime = DateTime.now().difference(startTime).inMilliseconds;
    if (executionTime < 1000) {
      await Future.delayed(Duration(milliseconds: 1000 - executionTime));
    }

    _isFetching = false;
    notifyListeners();
  }
}
