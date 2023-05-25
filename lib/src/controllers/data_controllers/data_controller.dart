import 'dart:async';

import 'package:class_room/src/controllers/services/firebase/firebase.dart';
import 'package:class_room/src/controllers/services/handle_error/error_handler.dart';
import 'package:class_room/src/controllers/services/local_data/local_data.dart';
import 'package:class_room/src/models/enum/enter_as.dart';
import 'package:class_room/src/models/pojo_classes/exam_model.dart';
import 'package:class_room/src/views/pages/main_pages/main_wrapper_screen.dart';
import 'package:class_room/src/views/pages/user_pages/welcome_wrapper_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  StreamSubscription<User?>? _authSubscription;
  StreamSubscription<bool?>? _localDataSubscriptionLogin;
  StreamSubscription<EnterAs?>? _localDataSubscriptionISTeacher;
  final FirebaseController _firebaseController = FirebaseController();
  final LocalData _localData = LocalData();

  final RxBool isRequesting = false.obs;
  final RxBool _isLogin = false.obs;
  final Rx<EnterAs> enterAs = (EnterAs.student).obs;

  //! Initialize app ///////////////////////////////////////////////////////////
  Future<void> initApp() async {
    await Future.delayed(const Duration(seconds: 3));
    WidgetsFlutterBinding.ensureInitialized();
    await _firebaseController.initFirebase();
    var r = await _localData.initData();
    _isLogin.value = r.item1;
    enterAs.value = r.item2 ? EnterAs.teacher : EnterAs.student;

    if (_isLogin.value) await autoSignIn();
    //* listener for auto login change /////////////////////////////////////////
    _localDataSubscriptionLogin = _isLogin.listen((_) => _localData.setIsLogin(_isLogin.value));
    _localDataSubscriptionISTeacher = enterAs.listen((_) => _localData.setTeacher(enterAs.value == EnterAs.teacher));

    //* listener for user change ///////////////////////////////////////////////
    bool force = false;
    _authSubscription = FirebaseAuth.instance.userChanges().listen((_) {
      if (kDebugMode) print("DataController.init(): FirebaseAuth.instance.userChanges().listen() for User ${FirebaseAuth.instance.currentUser?.email}");
      if (force) {
        if (FirebaseAuth.instance.currentUser == null) _forceLoginScreen();
      } else {
        force = true;
      }
    });

    // Check if login
    if (FirebaseAuth.instance.currentUser != null) {
      // if valid then go to main page
      Get.offAll(() => MainWrapperScreen());
    }
  }
  //! //////////////////////////////////////////////////////////////////////////

  @override
  void onClose() {
    super.onClose();
    if (kDebugMode) print("DataController.onClose()");
    _localDataSubscriptionLogin?.cancel();
    _localDataSubscriptionISTeacher?.cancel();
    _authSubscription?.cancel();

    Get.delete<DataController>();
  }

  //! Error handler ////////////////////////////////////////////////////////////
  Future<bool> _errorHandler({bool showError = true, required Function function}) async {
    // isRequesting.value = true;

    // ErrorType error = await ErrorHandler.errorHandler(
    //   showError: showError,
    //   function: () async => await function(),
    // );
    // isRequesting.value = false;
    // if (error == ErrorType.invalidUser) _forceSignOut();

    // return error == ErrorType.done;

    await function();
    return true;
  }
  //! //////////////////////////////////////////////////////////////////////////

  //! User /////////////////////////////////////////////////////////////////////
  _forceSignOut() {
    signOut();
  }

  _forceLoginScreen() {
    Get.offAll(() => const WelcomeWrapperScreen());
  }

  Future<bool> login() async {
    return await _errorHandler(function: () async {
      await _firebaseController.signIn();
      _isLogin.value = true;
    });
  }

  Future<void> signOut() async {
    _isLogin.value = false;
    await _firebaseController.signOut();
  }

  Future<void> autoSignIn() async => await _errorHandler(showError: false, function: () async => await _firebaseController.autoSignIn());

  Future<void> autoSignOut() async => await _errorHandler(showError: false, function: () async => await _firebaseController.autoSignOut());

  //! //////////////////////////////////////////////////////////////////////////

  //! Teacher //////////////////////////////////////////////////////////////////
  Future<bool> addExam({required ExamModel examModel}) async {
    return _errorHandler(function: () async {
      await _firebaseController.addExam(examModel);
      getExamList();
    });
  }

  final RxList<ExamModel> examList = RxList();
  Future<void> getExamList() async {
    await _errorHandler(function: () async {
      examList.value = await _firebaseController.getTeacherExamList(enterAs.value == EnterAs.teacher);
    });
  }

  //! Student //////////////////////////////////////////////////////////////////
}
