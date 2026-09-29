class RegistrationData {
  String phoneNumber;

  // Basic Profile
  String fullName;
  String dateOfBirth;
  String gender;

  // Address
  String address;
  String area;
  String city;
  String state;
  String pinCode;

  // Experience
  String experienceLevel;
  String experienceDetails;
  bool dogHandling;
  bool petCare;

  // Documents
  bool aadhaarFrontAdded;
  bool aadhaarBackAdded;
  bool panAdded;
  bool profilePhotoAdded;

  // Availability
  String workType;
  List<String> shifts;
  List<String> availableDays;

  List<String> morningSlots;
  List<String> eveningSlots;

  String morningStartTime;
  String morningEndTime;
  String eveningStartTime;
  String eveningEndTime;

  List<String> walkTypes;

  // Emergency Contact
  String emergencyContactName;
  String emergencyContactPhone;
  String emergencyContactRelationship;

  RegistrationData({
    this.phoneNumber = '',
    this.fullName = '',
    this.dateOfBirth = '',
    this.gender = '',
    this.address = '',
    this.area = '',
    this.city = '',
    this.state = '',
    this.pinCode = '',
    this.experienceLevel = '',
    this.experienceDetails = '',
    this.dogHandling = false,
    this.petCare = false,
    this.aadhaarFrontAdded = false,
    this.aadhaarBackAdded = false,
    this.panAdded = false,
    this.profilePhotoAdded = false,
    this.workType = '',
    List<String>? shifts,
    List<String>? availableDays,
    List<String>? morningSlots,
    List<String>? eveningSlots,
    this.morningStartTime = '',
    this.morningEndTime = '',
    this.eveningStartTime = '',
    this.eveningEndTime = '',
    List<String>? walkTypes,
    this.emergencyContactName = '',
    this.emergencyContactPhone = '',
    this.emergencyContactRelationship = '',
  })  : shifts = shifts ?? <String>[],
        availableDays = availableDays ?? <String>[],
        morningSlots = morningSlots ?? <String>[],
        eveningSlots = eveningSlots ?? <String>[],
        walkTypes = walkTypes ?? <String>[];

  RegistrationData copyWith({
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
    List<String>? morningSlots,
    List<String>? eveningSlots,
    String? morningStartTime,
    String? morningEndTime,
    String? eveningStartTime,
    String? eveningEndTime,
    List<String>? walkTypes,
    String? emergencyContactName,
    String? emergencyContactPhone,
    String? emergencyContactRelationship,
  }) {
    return RegistrationData(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      area: area ?? this.area,
      city: city ?? this.city,
      state: state ?? this.state,
      pinCode: pinCode ?? this.pinCode,
      experienceLevel:
          experienceLevel ?? this.experienceLevel,
      experienceDetails:
          experienceDetails ?? this.experienceDetails,
      dogHandling: dogHandling ?? this.dogHandling,
      petCare: petCare ?? this.petCare,
      aadhaarFrontAdded:
          aadhaarFrontAdded ?? this.aadhaarFrontAdded,
      aadhaarBackAdded:
          aadhaarBackAdded ?? this.aadhaarBackAdded,
      panAdded: panAdded ?? this.panAdded,
      profilePhotoAdded:
          profilePhotoAdded ?? this.profilePhotoAdded,
      workType: workType ?? this.workType,
      shifts: shifts ?? List<String>.from(this.shifts),
      availableDays:
          availableDays ?? List<String>.from(this.availableDays),
      morningSlots:
          morningSlots ?? List<String>.from(this.morningSlots),
      eveningSlots:
          eveningSlots ?? List<String>.from(this.eveningSlots),
      morningStartTime:
          morningStartTime ?? this.morningStartTime,
      morningEndTime:
          morningEndTime ?? this.morningEndTime,
      eveningStartTime:
          eveningStartTime ?? this.eveningStartTime,
      eveningEndTime:
          eveningEndTime ?? this.eveningEndTime,
      walkTypes:
          walkTypes ?? List<String>.from(this.walkTypes),
      emergencyContactName:
          emergencyContactName ?? this.emergencyContactName,
      emergencyContactPhone:
          emergencyContactPhone ?? this.emergencyContactPhone,
      emergencyContactRelationship:
          emergencyContactRelationship ??
              this.emergencyContactRelationship,
    );
  }
}
