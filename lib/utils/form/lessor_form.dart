import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:tikar/utils/app_colors.dart';
import 'package:tikar/utils/app_string.dart';
import 'package:tikar/cubits/user_cubit.dart';
import 'package:tikar/models/staff_model.dart';
import 'package:tikar/cubits/staff_cubit.dart';
import 'package:tikar/models/lessor_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/cubits/lessor_cubit.dart';
import 'package:tikar/extensions/extensions.dart';
import 'package:tikar/utils/snackbar_messenger.dart';
import 'package:tikar/views/desktop/tikar/pages/rent.dart';

class LessorForm extends StatefulWidget {
  final double width;
  final double height;
  const LessorForm({super.key, required this.width, required this.height});

  @override
  State<LessorForm> createState() => _LessorFormState();
}

class _LessorFormState extends State<LessorForm> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedRole;
  bool _obscureText = true;
  final _textControllers = <TextEditingController>[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  bool _isChecked = true;

  final List<String> _jobRoles = ['Male', "Female"];

  @override
  Widget build(BuildContext context) {
    final _lessorCubit = context.cubit<LessorCubit>();

    return widget.width >= 350
        ? SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              height: widget.height,
              width: widget.width,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: const EdgeInsets.only(top: 18, bottom: 18),
                        child: Text(
                          AppStrings.lessor_post_header,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: TextFormField(
                                controller: _textControllers[0],
                                decoration: const InputDecoration(
                                  labelText: 'First Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter first name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextFormField(
                                controller: _textControllers[1],
                                decoration: InputDecoration(
                                  labelText: 'Last Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter last name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _textControllers[2],
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: DropdownButtonFormField<String>(
                                value: _selectedRole,
                                decoration: InputDecoration(
                                  labelText: 'Gender',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                ),
                                items: _jobRoles.map((String role) {
                                  return DropdownMenuItem<String>(
                                    value: role,
                                    child: Text(role),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedRole = newValue;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a Gender';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Expanded(
                              child: Row(
                            children: [
                              Checkbox(
                                  value: _isChecked,
                                  onChanged: (isChecked) {
                                    setState(() {
                                      _isChecked = isChecked!;
                                    });
                                  }),
                              const Text("Vis au Cameroon")
                            ],
                          ))
                        ],
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        style: ButtonStyle(
                          fixedSize:
                              WidgetStateProperty.all(const Size(320, 50)),
                          backgroundColor: WidgetStateProperty.all(
                              AppColors.blue.withOpacity(0.7)),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Process data
                            _lessorCubit.post(LessorModel(
                                fname: _textControllers[0].value.text,
                                lname: _textControllers[1].value.text,
                                gender: _selectedRole!,
                                tel: int.parse(_textControllers[2].value.text),
                                inCameroon: _isChecked,
                                createdAt: DateTime.now(),
                                updatedAt: DateTime.now()));

                            SnackBarMessenger.stateSnackMessenger(
                                context: context,
                                message: "processing data",
                                type: "success");
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Container();
  }
}
