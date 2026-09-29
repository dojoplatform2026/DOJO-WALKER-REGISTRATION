import 'package:flutter/foundation.dart';

import '../models/registration_data.dart';

class RegistrationState extends ChangeNotifier {
  RegistrationData _data = RegistrationData();

  RegistrationData get data => _data;

  void update({
    String? phoneNumber,
    String? fullName,
    String? dateOfBirth,
    String? gender,
    String? address,
    String? area,
    String? city,
    String? state,
    String? pinCode,
    String? experienceLevel,
    String? experienceDetails,
    bool? dogHandling,
    bool? petCare,
    bool? aadhaarFrontAdded,
    bool? aadhaarBackAdded,
    bool? panAdded,
    bool? profilePhotoAdded,
    String? workType,
    List<String>? shifts,
    List<String>? availableDays,
    String? morningStartTime,
    String? morningEndTime,
    String? eveningStartTime,
    String? eveningEndTime,
    List<String>? walkTypes,
    String? emergencyContactName,
    String? emergencyContactPhone,
    String? emergencyContactRelationship,
  }) {
    _data = _data.copyWith(
      phoneNumber: phoneNumber,
      fullName: fullName,
      dateOfBirth: dateOfBirth,
      gender: gender,
      address: address,
      area: area,
      city: city,
      state: state,
      pinCode: pinCode,
      experienceLevel: experienceLevel,
      experienceDetails: experienceDetails,
      dogHandling: dogHandling,
      petCare: petCare,
      aadhaarFrontAdded: aadhaarFrontAdded,
      aadhaarBackAdded: aadhaarBackAdded,
      panAdded: panAdded,
      profilePhotoAdded: profilePhotoAdded,
      workType: workType,
      shifts: shifts,
      availableDays: availableDays,
      morningStartTime: morningStartTime,
      morningEndTime: morningEndTime,
      eveningStartTime: eveningStartTime,
      eveningEndTime: eveningEndTime,
      walkTypes: walkTypes,
      emergencyContactName: emergencyContactName,
      emergencyContactPhone: emergencyContactPhone,
      emergencyContactRelationship:
          emergencyContactRelationship,
    );

    notifyListeners();
  }

  void reset() {
    _data = RegistrationData();
    notifyListeners();
  }
}
