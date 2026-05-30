import 'package:flutter/material.dart';

class OrganizationScreen extends StatefulWidget {
  const OrganizationScreen({super.key});

  @override
  State<OrganizationScreen> createState() => _OrganizationScreenState();
}

class _OrganizationScreenState extends State<OrganizationScreen> {
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController contactNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String selectedPlan = 'organization';

  void submitOrganization() {
    final data = {
      'companyName': companyNameController.text,
      'contactName': contactNameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'address': addressController.text,
      'plan': selectedPlan,
    };

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Organization submitted for verification')),
    );

    // TODO: connect to Firestore
    debugPrint(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organization Setup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Business Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: companyNameController,
              decoration: const InputDecoration(labelText: 'Company Name'),
            ),
            TextField(
              controller: contactNameController,
              decoration: const InputDecoration(labelText: 'Contact Person'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Business Address'),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: selectedPlan,
              items: const [
                DropdownMenuItem(value: 'organization', child: Text('Organization Plan - $150/year')),
                DropdownMenuItem(value: 'unlimited', child: Text('Unlimited - $50/month')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedPlan = value!;
                });
              },
              decoration: const InputDecoration(labelText: 'Select Plan'),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: submitOrganization,
              child: const Text('Submit Organization'),
            ),
          ],
        ),
      ),
    );
  }
}