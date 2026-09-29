import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/registration_data.dart';

class RegistrationService {
  RegistrationService._();

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static final FirebaseAuth _auth =
      FirebaseAuth.instance;

  static Future<String> submitApplication(
    RegistrationData data,
  ) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw FirebaseAuthException(
        code: 'not-authenticated',
        message: 'Please verify your mobile number first.',
      );
    }

    final applicationRef =
        _firestore.collection('walker_applications').doc();

    final applicationId =
        'DW-${applicationRef.id.substring(0, 8).toUpperCase()}';

    await applicationRef.set({
      'applicationId': applicationId,
      'uid': user.uid,

      'status': 'PENDING_VERIFICATION',
      'verificationStage': 'APPLICATION_SUBMITTED',

      'phoneNumber': data.phoneNumber,

      'basicProfile': {
        'fullName': data.fullName,
        'dateOfBirth': data.dateOfBirth,
        'gender': data.gender,
      },

      'address': {
        'address': data.address,
        'area': data.area,
        'city': data.city,
        'state': data.state,
        'pinCode': data.pinCode,
      },

      'experience': {
        'experienceLevel': data.experienceLevel,
        'experienceDetails': data.experienceDetails,
        'dogHandling': data.dogHandling,
        'petCare': data.petCare,
      },

      'documents': {
        'aadhaarFrontAdded': data.aadhaarFrontAdded,
        'aadhaarBackAdded': data.aadhaarBackAdded,
        'panAdded': data.panAdded,
        'profilePhotoAdded': data.profilePhotoAdded,
      },

      'availability': {
        'workType': data.workType,
        'shifts': data.shifts,
        'morningSlots': data.morningSlots,
        'eveningSlots': data.eveningSlots,
        'morningStartTime': data.morningStartTime,
        'morningEndTime': data.morningEndTime,
        'eveningStartTime': data.eveningStartTime,
        'eveningEndTime': data.eveningEndTime,
      },

      'emergencyContact': {
        'name': data.emergencyContactName,
        'phone': data.emergencyContactPhone,
        'relationship': data.emergencyContactRelationship,
      },

      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return applicationId;
  }
}
