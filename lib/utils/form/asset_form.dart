import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tikar/utils/app_colors.dart';
import 'package:tikar/cubits/base_state.dart';
import 'package:tikar/models/asset_model.dart';
import 'package:tikar/cubits/asset_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/models/lessor_model.dart';
import 'package:tikar/cubits/lessor_cubit.dart';
import 'package:tikar/extensions/extensions.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:tikar/utils/snackbar_messenger.dart';
import 'package:tikar/utils/widgets/App_loader.dart';
import 'package:tikar/utils/cloudinary_image_uploader.dart';

class AssetForm extends StatefulWidget {
  final double width;
  final double height;
  const AssetForm({super.key, required this.width, required this.height});

  @override
  State<AssetForm> createState() => _AssetFormState();
}

class _AssetFormState extends State<AssetForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedTown;
  final List<String> _towns = [
    'Douala',
    'Yaounde',
    'Baffoussam',
    'Bamenda',
    'Buea',
    'Bertua',
    'EBolowa',
    'Maroua',
    "Garoua",
    'Ngaoundere',
  ];
  String? _selectedAsset;
  final List<String> _assetType = [
    'Building',
    'Residence',
  ];
  LessorModel? _selectedLessor;
  List<File?> _file = List.filled(3, null);
  final _textControllers = <TextEditingController>[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  bool _isChecked = false;
  final _uploadController = CloudinaryImageUploader();
  @override
  Widget build(BuildContext context) {
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
                        const Padding(
                          padding: const EdgeInsets.only(top: 18, bottom: 18),
                          child: Text(
                            "créé  un Bien",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 650,
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 0, right: 0, bottom: 5),
                            child: Row(
                              children: [
                                imageUploader(0),
                                imageUploader(1),
                                imageUploader(2)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: BlocBuilder<LessorCubit,
                                        BaseState<List<LessorModel?>?>>(
                                    builder: (context, state) {
                                  return switch (state) {
                                    Initial() ||
                                    Loading() =>
                                      Builder(builder: (_) {
                                        context.read<LessorCubit>().getData();
                                        return Skeletonizer(
                                            enabled: true, child: Container());
                                      }),
                                    Success() =>
                                      DropdownButtonFormField<LessorModel?>(
                                        value: _selectedLessor,
                                        decoration: const InputDecoration(
                                          labelText: 'Bailler',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                          ),
                                        ),
                                        items: state.data!
                                            .map((LessorModel? model) {
                                          return DropdownMenuItem<LessorModel?>(
                                            value: model,
                                            child: Text(
                                                "${model!.fname} ${model.lname}"),
                                          );
                                        }).toList(),
                                        onChanged: (LessorModel? newValue) {
                                          setState(() {
                                            _selectedLessor = newValue;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Please select a Lessor';
                                          }
                                          return null;
                                        },
                                      ),
                                    NotFound() => Builder(builder: (_) {
                                        return Container(
                                          height: 30,
                                          width: 80,
                                          child: const Text(
                                            "Aucun Bailleur Trouvé",
                                            style: TextStyle(
                                                color: Colors.redAccent),
                                          ),
                                        );
                                      }),
                                    _ => AppLoader.defaultLoader()
                                  };
                                }),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: DropdownButtonFormField<String>(
                                  value: _selectedAsset,
                                  decoration: InputDecoration(
                                    labelText: 'type',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                  ),
                                  items: _assetType.map((String job) {
                                    return DropdownMenuItem<String>(
                                      value: job,
                                      child: Text(job),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedAsset = newValue;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Choisissez une parmis les categories ';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _textControllers[0],
                                decoration: InputDecoration(
                                  labelText: 'Matricule',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Entrez le Matricule ';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: DropdownButtonFormField<String>(
                                  value: _selectedTown,
                                  decoration: InputDecoration(
                                    labelText: 'Ville ',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                  ),
                                  items: _towns.map((String job) {
                                    return DropdownMenuItem<String>(
                                      value: job,
                                      child: Text(job),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedTown = newValue;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Choisissez un une ville';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _textControllers[1],
                                decoration: InputDecoration(
                                  labelText: 'Address/Quartier',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Entrez une address';
                                  }
                                  // You might want to add more sophisticated email validation
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _textControllers[2],
                                  decoration: InputDecoration(
                                    suffixText: "FCFA",
                                    labelText: 'Valeur estimé',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Entrez une estimation';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _textControllers[3],
                                  decoration: InputDecoration(
                                    suffixText: "M²",
                                    labelText: 'Metre carre',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enterez la surface ';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              maxLines: null,
                              expands: true,
                              controller: _textControllers[4],
                              decoration: InputDecoration(
                                labelText: 'une description',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        //SizedBox(height: 24),
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
                              List<String> images = [];
                              _file.forEach((file) async {
                                images.add(await _uploadController
                                    .uploadImages(file!));
                              });
                              context.read<AssetCubit>().post(AssetModel(
                                  image: images,
                                  ville: _selectedTown,
                                  address: _textControllers[1].value.text,
                                  surfaceArea:
                                      int.parse(_textControllers[2].value.text),
                                  estimatedValue:
                                      int.parse(_textControllers[3].value.text),
                                  description: _textControllers[4].value.text,
                                  assetType: _selectedAsset,
                                  isActive: true,
                                  createdAt: DateTime.now(),
                                  updatedAt: DateTime.now(),
                                  lessor: _selectedLessor!,
                                  matricule: _textControllers[0].value.text));
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

  Padding imageUploader(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          final file = await _uploadController.pickAndUploadImage();
          setState(() {
            if (file != null) {
              _file[index] = file;
            }
          });
        },
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.grey[400]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: _file[index] == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_upload,
                      size: 48,
                      color: Colors.grey[600],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'UPLOAD IMAGE',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _file[index]!,
                    width: widget.width,
                    height: widget.height,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }
}
