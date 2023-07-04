import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:rse/all.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  ProfileForm formData = ProfileForm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobile: mobile(context),
        desktop: mobile(context),
      ),
    );
  }

  mobile(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildForm(context),
          const SizedBox(height: 20),
          buildBankAccounts(context),
          ExpansionPanelListExample(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget desktop(BuildContext context) {
    return const SizedBox();
  }

  buildBankAccounts(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Bank Accounts',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            return buildBankAccount(context, index);
          },
        ),
      ],
    );
  }

  buildBankAccount(context, index) {
    return ListTile(
      leading: const Icon(Icons.account_balance),
      title: const Text('Bank of America'),
      subtitle: const Text('Checking'),
      trailing: const Icon(Icons.edit),
    );
  }

  Column buildForm(context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: inputField(
                'First Name',
                Icons.person,
                'John',
                formData.firstName,
                (v) => formData.firstName = v,
              ),
            ),
            Expanded(
              child: inputField(
                'Last Name',
                Icons.group,
                'Doe',
                formData.lastName,
                (v) => formData.lastName = v,
              ),
            ),
          ],
        ),
        inputField(
          'Email',
          Icons.email,
          'john@example.com',
          formData.email,
          (v) => formData.email = v,
        ),
        inputField(
          'Phone Number',
          Icons.phone,
          '123-456-7890',
          formData.phoneNumber,
          (v) => formData.phoneNumber = v,
        ),
        inputField(
          'Address',
          Icons.home,
          '1234 Main St',
          formData.address,
          (v) => formData.address = v,
        ),
        inputField(
          'City',
          Icons.location_city,
          'New York',
          formData.city,
          (v) => formData.city = v,
        ),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: stateTypeAhead(),
            ),
            Expanded(
              flex: 3,
              child: inputField('Zip Code', Icons.location_pin, '12345',
                  formData.zipCode, (v) => formData.zipCode = v),
            ),
          ],
        ),
        inputField(
          'Country',
          Icons.flag,
          'United States',
          formData.country,
          (v) => formData.country = v,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            submitForm();
          },
          child: const Text('Submit', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget inputField(label, icon, hint, value, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: TextFormField(
        initialValue: value,
        onChanged: onChanged,
        readOnly: kDebugMode,
        showCursor: kDebugMode,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          prefixIcon: Icon(icon),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }

  TypeAheadField<Map<String, String>> stateTypeAhead() {
    return TypeAheadField(
      textFieldConfiguration: const TextFieldConfiguration(
        decoration: InputDecoration(
          hintText: 'NY',
          labelText: 'State',
          prefixIcon: Icon(Icons.location_pin),
        ),
      ),
      suggestionsCallback: (pattern) async {
        return states
            .where((state) =>
                state['name']!.toLowerCase().contains(pattern.toLowerCase()) ||
                state['abbr']!.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
      },
      onSuggestionSelected: (suggestion) {
        (value) => formData.lastName = suggestion['abbr']!;
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          leading: const Icon(Icons.location_pin),
          title: Text(suggestion['abbr']!),
          subtitle: Text(suggestion['name']!),
        );
      },
    );
  }

  void submitForm() {
    print(formData);
  }
}

class Item {
  Item({
    this.isExpanded = false,
    required this.headerValue,
    required this.expandedValue,
  });

  bool isExpanded;
  String headerValue;
  String expandedValue;
}

List<Item> items = [
  Item(
    headerValue: 'Bank Of America',
    expandedValue: 'This is item number.',
  ),
  Item(
    headerValue: 'Wells Fargo',
    expandedValue: 'This is item number.',
  ),
  Item(
    headerValue: 'Chase',
    expandedValue: 'This is item number.',
  ),
];

class ExpansionPanelListExample extends StatefulWidget {
  const ExpansionPanelListExample({super.key});

  @override
  State<ExpansionPanelListExample> createState() =>
      _ExpansionPanelListExampleState();
}

class _ExpansionPanelListExampleState extends State<ExpansionPanelListExample> {
  final List<Item> _data = items;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle:
                  const Text('To delete this panel, tap the trash can icon'),
              trailing: const Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
