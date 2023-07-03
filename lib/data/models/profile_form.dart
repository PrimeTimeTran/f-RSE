class ProfileForm {
  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNumber = '';
  String address = '';
  String city = '';
  String state = '';
  String zipCode = '';
  String country = '';

  @override
  String toString() {
    return 'UserProfileFormData{\n'
        '  firstName: $firstName,\n'
        '  lastName: $lastName,\n'
        '  email: $email,\n'
        '  phoneNumber: $phoneNumber,\n'
        '  address: $address,\n'
        '  city: $city,\n'
        '  state: $state,\n'
        '  zipCode: $zipCode,\n'
        '  country: $country\n'
        '}';
  }
}