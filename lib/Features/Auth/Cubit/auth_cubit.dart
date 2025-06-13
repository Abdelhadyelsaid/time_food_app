import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import '../../../Core/Helper/cache_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  ///**************************** Login ******************///
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  ///**************************** SignUp ******************///
  TextEditingController signupPhoneController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupConfirmPasswordController =
      TextEditingController();
  TextEditingController signupFirstNameController = TextEditingController();
  TextEditingController signupLastNameController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();

  ///**************************** forget password ******************///

  TextEditingController forgetPasswordEmailController = TextEditingController();
  TextEditingController restorePasswordOtpController = TextEditingController();

  /// OTP Timers

  int start = 30;
  Timer? timer;

  void resetTimer() {
    start = 30;
    emit(TimerStopState());
  }

  void startTimer() {
    emit(TimerStartState());
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (start == 0) {
        timer.cancel();
        // start = 60;
        emit(TimerStopState());
      } else {
        start = start - 1;
        emit(TimerMinusState());
      }
    });
  }

  Future<void> signUp(
    String email,
    String phoneNumber,
    String name,
    String password,
    String state,
    String age,
    String gender,
  ) async {
    try {
      emit(SignUpLoadingState());
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
            'email': email.trim(),
            'username': name.trim(),
            'phone_number': phoneNumber.trim(),
            'state': state.trim(),
            'age': age.trim(),
            'gender': gender.trim(),
            'createdAt': Timestamp.now(),
          });
      emit(SignUpSuccessState());
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      emit(SignUpErrorState(e.toString()));
    }
  }

  User? user = FirebaseAuth.instance.currentUser;

  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoadingState());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      if (user != null) {
        var token = await user!.getIdToken();
        CacheHelper.saveData(key: "token", value: token);
        log("This is firebase token:$token");
      }
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      emit(LoginErrorState(e.toString()));
    }
  }

  sendForgetPasswordRequest() async {
    try {
      emit(SendForgetPasswordRequestLoadingState());
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: forgetPasswordEmailController.text.trim(),
      );
      emit(SendForgetPasswordRequestSuccessState());
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      emit(SendForgetPasswordRequestErrorState());
    }
  }

  resendForgetPasswordRequest() async {
    try {
      emit(ReSendForgetPasswordRequestLoadingState());
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: forgetPasswordEmailController.text.trim(),
      );
      emit(ReSendForgetPasswordRequestSuccessState());
    } on FirebaseAuthException catch (E) {
      log(E.toString());
      emit(ReSendForgetPasswordRequestErrorState());
    }
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        log("Google Sign-In was canceled by the user");
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      log("This is loadd******************************");
      emit(GoogleFirebaseLoadingState());
      UserCredential userCredential = await auth.signInWithCredential(
        credential,
      );
      var firebaseToken = await userCredential.user!.getIdToken();
      log("This is firebaseToken:${firebaseToken}");
      emit(GoogleFirebaseSuccessState());
      return userCredential;
    } catch (e) {
      emit(GoogleFirebaseErrorState(e.toString()));
      log("Error during Google Sign-In: ${e.toString()}");
    }
    return null;
  }
}
