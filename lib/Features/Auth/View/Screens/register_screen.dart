import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_food/Core/Const/colors.dart';
import 'package:time_food/Core/Shared%20Widgets/snackBar_widget.dart';
import 'package:time_food/Features/Auth/Cubit/auth_cubit.dart';

import '../../../../routing/routes.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  File? _profileImage;
  String? _username, _email, _phone, _state, _gender, _age, _password;

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (picked != null) {
      setState(() => _profileImage = File(picked.path));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تسجيل حساب جديد'),
        centerTitle: true,
        backgroundColor: cPrimaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              // Profile image picker
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  backgroundImage:
                      _profileImage != null ? FileImage(_profileImage!) : null,
                  child:
                      _profileImage == null
                          ? Icon(
                            Icons.camera_alt,
                            size: 40,
                            color: Colors.white70,
                          )
                          : null,
                ),
              ),
              SizedBox(height: 20),

              // Form fields
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'اسم المستخدم',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.right,
                      validator:
                          (v) => v!.trim().isEmpty ? 'ادخل اسم المستخدم' : null,
                      onSaved: (v) => _username = v!.trim(),
                    ),
                    SizedBox(height: 15.h),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'البريد الالكتروني',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator:
                          (v) => v!.contains('@') ? null : 'ادخل ايميل صحيح',
                      onSaved: (v) => _email = v,
                    ),
                    SizedBox(height: 15.h),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'رقم الهاتف',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      onSaved: (v) => _phone = v,
                    ),
                    SizedBox(height: 15.h),
                    TextFormField(
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        labelText: 'المحافظة',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      validator:
                          (v) => v!.trim().isEmpty ? 'ادخل المحافظة' : null,
                      onSaved: (v) => _state = v!.trim(),
                    ),
                    SizedBox(height: 15.h),
                    TextFormField(
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        labelText: 'العمر',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'ادخل العمر';
                        final age = int.tryParse(v);
                        if (age == null || age < 1 || age > 120) {
                          return 'ادخل عمر صالح بين 1 و120';
                        }
                        return null;
                      },
                      onSaved: (v) => _age = v!,
                    ),
                    SizedBox(height: 15.h),
                    FormField<String>(
                      initialValue: _gender,
                      validator: (val) => val == null ? 'اختر الجنس' : null,
                      onSaved: (val) => _gender = val,
                      builder: (field) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('الجنس', style: TextStyle(fontSize: 16)),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'ذكر',
                                  groupValue: field.value,
                                  onChanged: (val) {
                                    field.didChange(val);
                                    setState(() {});
                                  },
                                ),
                                const Text('ذكر'),
                                SizedBox(width: 20.w),
                                Radio<String>(
                                  value: 'أنثى',
                                  groupValue: field.value,
                                  onChanged: (val) {
                                    field.didChange(val);
                                    setState(() {});
                                  },
                                ),
                                const Text('أنثى'),
                              ],
                            ),
                            if (field.hasError)
                              Text(
                                field.errorText!,
                                style: TextStyle(
                                  color: Theme.of(context).cardColor,
                                  fontSize: 12,
                                ),
                              ),
                          ],
                        );
                      },
                    ),

                    SizedBox(height: 15.h),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'كلمة المرور',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      validator:
                          (v) => v!.length < 6 ? 'كلمة مرور قصيرة' : null,
                      onSaved: (v) => _password = v,
                      onFieldSubmitted: (_) {},
                    ),
                    SizedBox(height: 30),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is SignUpSuccessState) {
                          context.pushNamed(Routes.loginScreen.name);
                        }
                        if (state is SignUpErrorState) {
                          context.showErrorSnackBar(
                            'Failed to login: ${state.message}',
                          );
                        }
                      },
                      builder: (context, state) {
                        var cubit = AuthCubit.get(context);
                        return state is SignUpLoadingState
                            ? Center(
                              child: CircularProgressIndicator(
                                color: cPrimaryColor,
                              ),
                            )
                            : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: cPrimaryColor,
                              ),
                              onPressed: () {
                                if (_email != null &&
                                    _email!.isNotEmpty &&
                                    _phone != null &&
                                    _phone!.isNotEmpty &&
                                    _username != null &&
                                    _username!.isNotEmpty &&
                                    _password != null &&
                                    _password!.isNotEmpty &&
                                    _state != null &&
                                    _state!.isNotEmpty &&
                                    _age != null &&
                                    _gender != null &&
                                    _gender!.isNotEmpty) {
                                  cubit.signUp(
                                    _email!,
                                    _phone!,
                                    _username!,
                                    _password!,
                                    _state!,
                                    _age!,
                                    _gender!,
                                  );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 12,
                                ),
                                child: Text(
                                  'تسجيل حساب جديد',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
