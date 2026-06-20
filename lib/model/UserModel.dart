// ============================================================
// UserModel.dart
// Updated to include onboarding data:
//   - location (lat/lng + human-readable address)
//   - emergencyContacts (list of 2 contacts: name + phone)
//   - onboardingComplete flag
// All new fields are optional/nullable so existing users created
// before this change (with only id/name/email) still parse fine.
// ============================================================

class EmergencyContact {
  final String name;
  final String phone;

  EmergencyContact({required this.name, required this.phone});

  Map<String, dynamic> toMap() {
    return {'name': name, 'phone': phone};
  }

  factory EmergencyContact.fromMap(Map<String, dynamic> json) {
    return EmergencyContact(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}

class UserLocation {
  final double latitude;
  final double longitude;
  final String? address;   // ← NEW: human-readable address

  UserLocation({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }

  factory UserLocation.fromMap(Map<String, dynamic> json) {
    return UserLocation(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String?,
    );
  }
}

class Usermodel {
  final String id;
  final String name;
  final String email;
  final String? imageUrl;
  final UserLocation? location;
  final List<EmergencyContact>? emergencyContacts;
  final bool onboardingComplete;

  Usermodel({
    required this.id,
    required this.name,
    required this.email,
    this.imageUrl,
    this.location,
    this.emergencyContacts,
    this.onboardingComplete = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'location': location?.toMap(),
      'emergencyContacts':
          emergencyContacts?.map((c) => c.toMap()).toList(),
      'onboardingComplete': onboardingComplete,
    };
  }

  factory Usermodel.fromMap(Map<String, dynamic> json) {
    return Usermodel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      location: json['location'] != null
          ? UserLocation.fromMap(json['location'] as Map<String, dynamic>)
          : null,
      emergencyContacts: json['emergencyContacts'] != null
          ? (json['emergencyContacts'] as List)
              .map((c) => EmergencyContact.fromMap(c as Map<String, dynamic>))
              .toList()
          : null,
      onboardingComplete: json['onboardingComplete'] ?? false,
    );
  }

  // ── Convenience: create a copy with some fields updated ──────
  Usermodel copyWith({
    UserLocation? location,
    List<EmergencyContact>? emergencyContacts,
    bool? onboardingComplete,
  }) {
    return Usermodel(
      id: id,
      name: name,
      email: email,
      imageUrl: imageUrl,
      location: location ?? this.location,
      emergencyContacts: emergencyContacts ?? this.emergencyContacts,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    );
  }
}