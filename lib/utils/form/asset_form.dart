import 'package:flutter/material.dart';
import 'package:tikar/utils/app_colors.dart';
import 'package:tikar/cubits/asset_cubit.dart';
import 'package:tikar/models/lessor_model.dart';
import 'package:tikar/cubits/lessor_cubit.dart';
import 'package:tikar/extensions/extensions.dart';
import 'package:tikar/utils/snackbar_messenger.dart';

class AssetForm extends StatefulWidget {
  final double width;
  final double height;
  const AssetForm({super.key, required this.width, required this.height});

  @override
  State<AssetForm> createState() => _AssetFormState();
}

class _AssetFormState extends State<AssetForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedJob;
  LessorModel? _selectedLessor;

  final _textControllers = <TextEditingController>[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  bool _isChecked = false;

// final List<LessorModel?>? _lessors;

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<AssetCubit>();
    final _lessor = context.cubit<LessorCubit>();

    return widget.width >= 350
        ? Builder(builder: (context) {
            //  _lessors = _lessor.lessor!;
            return SingleChildScrollView(
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
                        Padding(
                          padding: const EdgeInsets.only(top: 18, bottom: 18),
                          child: Text(
                            "créé  un Bien",
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
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            }
                            // You might want to add more sophisticated email validation
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _textControllers[4],
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
                            // Expanded(
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(left: 8.0),
                            //     child: DropdownButtonFormField<LessorModel>(
                            //       value: _selectedLessor,
                            //       decoration: InputDecoration(
                            //         labelText: 'Role',
                            //         border: OutlineInputBorder(
                            //           borderRadius: BorderRadius.all(
                            //             Radius.circular(15),
                            //           ),
                            //         ),
                            //       ),
                            //       items: _lessors.map((LessorModel? lessor) {
                            //         return DropdownMenuItem<LessorModel>(
                            //           value: lessor,
                            //           child: Text("${lessor?.fname}" +
                            //               "  ${lessor?.lname}"), // Assume LessorModel has a 'name' property
                            //         );
                            //       }).toList(),
                            //       onChanged: (LessorModel? newValue) {
                            //         setState(() {
                            //           _selectedLessor = newValue;
                            //         });
                            //       },
                            //       validator: (value) {
                            //         if (value == null) {
                            //           return 'Please select a role';
                            //         }
                            //         return null;
                            //       },
                            //     ),
                            //   ),
                            // ),
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
                              // cubit.post(StaffModel(
                              //     fname: _textControllers[0].value.text,
                              //     lname: _textControllers[1].value.text,
                              //     pw: _textControllers[3].value.text,
                              //     tel:
                              //         int.parse(_textControllers[4].value.text),
                              //     active: true,
                              //     role: [_selectedLessor!],
                              //     post: _selectedJob!,
                              //     email: _textControllers[2].value.text,
                              //     username: _textControllers[2].value.text));

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
            );
          })
        : Container();
  }
}
