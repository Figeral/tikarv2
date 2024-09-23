import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tikar/utils/app_colors.dart';
import 'package:tikar/models/rent_model.dart';
import 'package:tikar/cubits/rent_cubit.dart';
import 'package:tikar/cubits/base_state.dart';
import 'package:tikar/models/asset_model.dart';
import 'package:tikar/cubits/asset_cubit.dart';
import 'package:tikar/cubits/lessor_cubit.dart';
import 'package:tikar/models/lessor_model.dart';
import 'package:tikar/cubits/renter_cubit.dart';
import 'package:tikar/models/renter_model.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/cubits/basement__cubit.dart';
import 'package:tikar/utils/snackbar_messenger.dart';
import 'package:tikar/utils/widgets/App_loader.dart';
import 'package:tikar/utils/cloudinary_image_uploader.dart';

class RentForm extends StatefulWidget {
  final double width;
  final double height;
  const RentForm({super.key, required this.width, required this.height});
  @override
  State<RentForm> createState() => _RentFormState();
}

class _RentFormState extends State<RentForm> {
  final _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return widget.width >= 360
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            height: widget.height,
            width: widget.width,
            child: PageView(
              reverse: true,
              controller: _pageController,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 180,
                        height: 50,
                        child: Text(
                          "Location de ",
                          style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              fixedSize:
                                  WidgetStateProperty.all(const Size(320, 60)),
                              backgroundColor:
                                  WidgetStateProperty.all(AppColors.blue),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            onPressed: () {
                              _pageController.jumpToPage(1);
                            },
                            child: Text(
                              "Residence",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              fixedSize:
                                  WidgetStateProperty.all(const Size(320, 60)),
                              backgroundColor:
                                  WidgetStateProperty.all(AppColors.blue),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            onPressed: () {
                              _pageController.jumpToPage(2);
                            },
                            child: Text(
                              "Appartement ou Autre",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )),
                      )
                    ],
                  ),
                ),
                ResidenceRent(),
                BasementRent()
              ],
            ),
          )
        : Container();
  }
}

class ResidenceRent extends StatefulWidget {
  const ResidenceRent({super.key});

  @override
  State<ResidenceRent> createState() => _ResidenceRentState();
}

class _ResidenceRentState extends State<ResidenceRent> {
  final _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final _formKey = GlobalKey<FormState>();
  RenterModel? _selectedRenter;
  AssetModel? _selectedAsset;
  @override
  Widget build(BuildContext context) {
    final _rentCubit = BlocProvider.of<RentCubit>(context);
    return Form(
      key: _formKey,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 58, bottom: 18, left: 15, right: 15),
        child: Column(
          children: [
            const Padding(
              padding: const EdgeInsets.only(top: 18, bottom: 18),
              child: Text(
                "Créé une  Location de Résidence",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child:
                        BlocBuilder<AssetCubit, BaseState<List<AssetModel?>?>>(
                            builder: (context, state) {
                      return switch (state) {
                        Initial() || Loading() => Builder(builder: (_) {
                            context.read<AssetCubit>().getData();
                            return Skeletonizer(
                                enabled: true, child: Container());
                          }),
                        Success() => DropdownButtonFormField<AssetModel?>(
                            value: _selectedAsset,
                            decoration: const InputDecoration(
                              labelText: 'Residence',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                            items: state.data!.where((asset) {
                              return asset!.assetType!.contains("Residence");
                            }).map((AssetModel? model) {
                              return DropdownMenuItem<AssetModel?>(
                                value: model,
                                child: Text("${model!.matricule} "),
                              );
                            }).toList(),
                            onChanged: (AssetModel? newValue) {
                              setState(() {
                                _selectedAsset = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Choisissez une Residence';
                              }
                              return null;
                            },
                          ),
                        NotFound() => Builder(builder: (_) {
                            return Container(
                              height: 30,
                              width: 80,
                              child: const Text(
                                "Aucune Résidence Trouvé",
                                style: TextStyle(color: Colors.redAccent),
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
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: BlocBuilder<RenterCubit,
                            BaseState<List<RenterModel?>?>>(
                        builder: (context, state) {
                      return switch (state) {
                        Initial() || Loading() => Builder(builder: (_) {
                            context.read<RenterCubit>().getData();
                            return Skeletonizer(
                                enabled: true, child: Container());
                          }),
                        Success() => DropdownButtonFormField<RenterModel?>(
                            value: _selectedRenter,
                            decoration: const InputDecoration(
                              labelText: 'Locataire',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                            items: state.data!.map((RenterModel? model) {
                              return DropdownMenuItem<RenterModel?>(
                                value: model,
                                child: Text("${model!.fname} ${model.lname}"),
                              );
                            }).toList(),
                            onChanged: (RenterModel? newValue) {
                              setState(() {
                                _selectedRenter = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Choisissez un Locataire';
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
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            );
                          }),
                        _ => AppLoader.defaultLoader()
                      };
                    }),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _controllers[0],
                      decoration: InputDecoration(
                        suffixText: "/mois Fcfa",
                        labelText: 'Location par mois',
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
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            //remains calender view and test post
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      readOnly: true,
                      controller: _controllers[1],
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () async {
                              DateTime? _pickedDate = await _selectedDate();
                              if (_pickedDate != null) {
                                setState(() {
                                  _controllers[1].text =
                                      _pickedDate.toString().split(" ")[0];
                                });
                              }
                            },
                            icon: Icon(Icons.calendar_month)),
                        labelText: 'date de debut',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entrez une date debut';
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
                      controller: _controllers[2],
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () async {
                              DateTime? _pickedDate = await _selectedDate();
                              if (_pickedDate != null) {
                                setState(() {
                                  _controllers[2].text =
                                      _pickedDate.toString().split(" ")[0];
                                });
                              }
                            },
                            icon: Icon(Icons.calendar_month)),
                        labelText: 'date de fin',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entrez une date de fin';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: WidgetStateProperty.all(const Size(320, 50)),
                        backgroundColor:
                            WidgetStateProperty.all(AppColors.blue),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (_selectedAsset != null &&
                            _selectedRenter != null &&
                            _formKey.currentState!.validate()) {
                          try {
                            _rentCubit.post(RentModel(
                                startAt:
                                    DateTime.parse(_controllers[1].value.text),
                                endAt:
                                    DateTime.parse(_controllers[2].value.text),
                                createdAt: DateTime.now(),
                                updatedAt: DateTime.now(),
                                renter: _selectedRenter!,
                                active: true,
                                cost: int.parse(_controllers[0].value.text),
                                asset: _selectedAsset!));
                            SnackBarMessenger.stateSnackMessenger(
                                context: context,
                                message: "Asset created successfully",
                                type: "success");
                          } catch (e) {
                            print(e.toString());
                            SnackBarMessenger.stateSnackMessenger(
                                context: context,
                                message: e.toString(),
                                type: "Error");
                          }
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: AppColors.white),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<DateTime?> _selectedDate() async {
    return await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030),
        initialDate: DateTime.now());
  }
}

class BasementRent extends StatefulWidget {
  const BasementRent({super.key});

  @override
  State<BasementRent> createState() => _BasementRentState();
}

class _BasementRentState extends State<BasementRent> {
  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        AddBasementRent(nextPage: () {
          _pageController.jumpToPage(1);
        }),
        AddBasement(previousPage: () {
          _pageController.jumpToPage(0);
        }),
      ],
    );
  }
}

class AddBasement extends StatefulWidget {
  void Function() previousPage;
  AddBasement({super.key, required this.previousPage});

  @override
  State<AddBasement> createState() => _AddBasementState();
}

class _AddBasementState extends State<AddBasement> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedAsset;
  final List<String> _assetType = [
    'Vide',
    'Meubler',
    "Studio",
    "Boutique",
    "Garage"
  ];
  AssetModel? _selectedBuilding;
  List<File?> _file = List.filled(3, null);
  final _textControllers = <TextEditingController>[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  bool _isChecked = false;
  final _uploadController = CloudinaryImageUploader();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 700,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18, bottom: 18),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: widget.previousPage,
                          icon: const Icon(Icons.arrow_back_ios_new)),
                      SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "créé  un Bien",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
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
                        child: BlocBuilder<AssetCubit,
                                BaseState<List<AssetModel?>?>>(
                            builder: (context, state) {
                          return switch (state) {
                            Initial() || Loading() => Builder(builder: (_) {
                                context.read<AssetCubit>().getData();
                                return Skeletonizer(
                                    enabled: true, child: Container());
                              }),
                            Success() => DropdownButtonFormField<AssetModel?>(
                                value: _selectedBuilding,
                                decoration: const InputDecoration(
                                  labelText: 'Choisissez L\'immeuble',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                ),
                                items: state.data!.where((asset) {
                                  return asset!.assetType!.contains("Building");
                                }).map((AssetModel? model) {
                                  return DropdownMenuItem<AssetModel?>(
                                    value: model,
                                    child: Text("${model!.matricule} "),
                                  );
                                }).toList(),
                                onChanged: (AssetModel? newValue) {
                                  setState(() {
                                    _selectedBuilding = newValue;
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Choisissez une Immeuble ou créé une Appartement ou Autre';
                                  }
                                  return null;
                                },
                              ),
                            NotFound() => Builder(builder: (_) {
                                return Container(
                                  height: 30,
                                  width: 80,
                                  child: const Text(
                                    "Aucune Résidence Trouvé",
                                    style: TextStyle(color: Colors.redAccent),
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
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _textControllers[1],
                          decoration: const InputDecoration(
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
                          controller: _textControllers[2],
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
                SizedBox(height: 14),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: null,
                      expands: true,
                      controller: _textControllers[3],
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
                SizedBox(height: 15),
                //SizedBox(height: 24),
                ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: WidgetStateProperty.all(const Size(320, 50)),
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
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "sauvegarde de image en cours",
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const CircularProgressIndicator(),
                            ],
                          ));
                        },
                      );

                      try {
                        List<String> images = [];
                        for (var file in _file) {
                          if (file != null) {
                            String uploadedImageUrl =
                                await _uploadController.uploadImages(file);
                            images.add(uploadedImageUrl);
                          }
                        }
                        BasementModel newBasement = BasementModel(
                            building: _selectedBuilding!,
                            surfaceArea:
                                int.parse(_textControllers[2].value.text),
                            estimatedValue:
                                int.parse(_textControllers[1].value.text),
                            matricule: _textControllers[0].value.text,
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                            numberOfHalls: 1,
                            active: true);
                        context.read<BasementCubit>().post(newBasement);

                        Navigator.of(context).pop();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Asset created successfully')),
                        );
                      } catch (e) {
                        // Hide loading indicator
                        Navigator.of(context).pop();

                        // // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Error creating asset: ${e.toString()}')),
                        );
                      }
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
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }
}

class AddBasementRent extends StatefulWidget {
  void Function() nextPage;
  AddBasementRent({super.key, required this.nextPage});

  @override
  State<AddBasementRent> createState() => _AddBasementRentState();
}

class _AddBasementRentState extends State<AddBasementRent> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  RenterModel? _selectedRenter;
  BasementModel? _selectedAsset;
  @override
  Widget build(BuildContext context) {
    final _rentCubit = BlocProvider.of<RentCubit>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Padding(
            padding: const EdgeInsets.only(top: 58, bottom: 18),
            child: Text(
              "Créé une  Location d\'appartement ou Autre",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                SizedBox(
                  width: 500,
                  height: 60,
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: BlocConsumer<BasementCubit,
                          BaseState<List<BasementModel?>?>>(
                        builder: (context, state) {
                          print(state);
                          return switch (state) {
                            Initial() || Loading() => Builder(builder: (_) {
                                context.read<BasementCubit>().getData();
                                return Skeletonizer(
                                    enabled: true,
                                    child: SizedBox(
                                      height: 20,
                                      width: 30,
                                    ));
                              }),
                            Success() => Builder(builder: (context) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButtonFormField<
                                          BasementModel?>(
                                        value: _selectedAsset,
                                        decoration: const InputDecoration(
                                          labelText: 'Appartement ou Autre',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                          ),
                                        ),
                                        items: state.data!.map((model) {
                                          return DropdownMenuItem<
                                              BasementModel?>(
                                            value: model,
                                            child: Text("${model!.matricule} "),
                                          );
                                        }).toList(),
                                        onChanged: (BasementModel? newValue) {
                                          setState(() {
                                            _selectedAsset = newValue;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Appartement ou Autre';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                          fixedSize: WidgetStateProperty.all(
                                              const Size(150, 50)),
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  AppColors.blue),
                                          shape: WidgetStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          widget.nextPage();
                                        },
                                        child: Text(
                                          "ajouté",
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )),
                                  ],
                                );
                              }),
                            NotFound() => Builder(builder: (_) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Aucune Appartement ou Autre Trouvé",
                                        style:
                                            TextStyle(color: Colors.redAccent),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                            fixedSize: WidgetStateProperty.all(
                                                const Size(150, 50)),
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    AppColors.blue),
                                            shape: WidgetStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            //context.read<BasementCubit>().fetch();
                                            widget.nextPage();
                                          },
                                          child: Text(
                                            "ajoute",
                                            style: TextStyle(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )),
                                    ],
                                  ),
                                );
                              }),
                            Valid => Builder(builder: (_) {
                                context.read<BasementCubit>().fetch();
                                return Skeletonizer(
                                    enabled: true,
                                    child: SizedBox(
                                      height: 20,
                                      width: 30,
                                    ));
                              }),
                            _ => AppLoader.defaultLoader()
                          };
                        },
                        listener: (BuildContext context,
                            BaseState<List<BasementModel?>?> state) {
                          if (state is Valid) {
                            context.read<BasementCubit>().fetch();
                          }
                        },
                        listenWhen: (previous, current) =>
                            previous is Valid ||
                            current is Valid ||
                            current is Loading,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: BlocBuilder<RenterCubit,
                            BaseState<List<RenterModel?>?>>(
                        builder: (context, state) {
                      return switch (state) {
                        Initial() || Loading() => Builder(builder: (_) {
                            context.read<RenterCubit>().getData();
                            return Skeletonizer(
                                enabled: true, child: Container());
                          }),
                        Success() => DropdownButtonFormField<RenterModel?>(
                            value: _selectedRenter,
                            decoration: const InputDecoration(
                              labelText: 'Locataire',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                            items: state.data!.map((RenterModel? model) {
                              return DropdownMenuItem<RenterModel?>(
                                value: model,
                                child: Text("${model!.fname} ${model.lname}"),
                              );
                            }).toList(),
                            onChanged: (RenterModel? newValue) {
                              setState(() {
                                _selectedRenter = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Choisissez un Locataire';
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
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            );
                          }),
                        _ => AppLoader.defaultLoader()
                      };
                    }),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _controllers[0],
                      decoration: InputDecoration(
                        suffixText: "/mois Fcfa",
                        labelText: 'Location par mois',
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
              ],
            ),
          ),
          //remains calender view and test post
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      readOnly: true,
                      controller: _controllers[1],
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () async {
                              DateTime? _pickedDate = await _selectedDate();
                              if (_pickedDate != null) {
                                setState(() {
                                  _controllers[1].text =
                                      _pickedDate.toString().split(" ")[0];
                                });
                              }
                            },
                            icon: Icon(Icons.calendar_month)),
                        labelText: 'date de debut',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entrez une date debut';
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
                      controller: _controllers[2],
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () async {
                              DateTime? _pickedDate = await _selectedDate();
                              if (_pickedDate != null) {
                                setState(() {
                                  _controllers[2].text =
                                      _pickedDate.toString().split(" ")[0];
                                });
                              }
                            },
                            icon: Icon(Icons.calendar_month)),
                        labelText: 'date de fin',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entrez une date de fin';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: WidgetStateProperty.all(const Size(320, 50)),
                      backgroundColor: WidgetStateProperty.all(AppColors.blue),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (_selectedAsset != null &&
                          _selectedRenter != null &&
                          _formKey.currentState!.validate()) {
                        try {
                          _rentCubit.post(RentModel(
                              startAt:
                                  DateTime.parse(_controllers[1].value.text),
                              endAt: DateTime.parse(_controllers[2].value.text),
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                              renter: _selectedRenter!,
                              active: true,
                              cost: int.parse(_controllers[0].value.text),
                              basement: _selectedAsset!));
                          SnackBarMessenger.stateSnackMessenger(
                              context: context,
                              message: "Asset created successfully",
                              type: "success");
                        } catch (e) {
                          SnackBarMessenger.stateSnackMessenger(
                              context: context,
                              message: e.toString(),
                              type: "Error");
                        }
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: AppColors.white),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<DateTime?> _selectedDate() async {
    return await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030),
        initialDate: DateTime.now());
  }
}
