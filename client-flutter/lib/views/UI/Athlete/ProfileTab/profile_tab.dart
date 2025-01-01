import 'package:flutter/material.dart';
import 'package:client_flutter/services/api_services.dart';
import 'package:client_flutter/services/api_config.dart';
import 'package:client_flutter/common/colo_extension.dart';

class ProfileTab extends StatefulWidget {
  final Map<String, dynamic> data;

  const ProfileTab({Key? key, required this.data}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late Map<String, dynamic> _data;

  @override
  void initState() {
    super.initState();
    _data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                // Profile Icon
                CircleAvatar(
                  radius: 60,
                  backgroundColor: TColor.primaryColor1,
                  child: const Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                // Profile Information Card
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Text(
                          'Profile Information',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: TColor.primaryColor1,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildProfileItem('Name', _data['name']),
                        _buildProfileItem('Email', _data['email']),
                        _buildProfileItem('Age', _data['age'].toString()),
                        _buildProfileItem('Gender', _data['gender']),
                        _buildProfileItem(
                            'Height (cm)', _data['height'].toString()),
                        _buildProfileItem(
                            'Weight (Kg)', _data['weight'].toString()),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Edit Button
                ElevatedButton(
                  onPressed: () {
                    // Add functionality to edit profile data
                    _showEditProfileDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColor.primaryColor1,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: _data['name']);
    TextEditingController ageController =
        TextEditingController(text: _data['age'].toString());
    TextEditingController weightController =
        TextEditingController(text: _data['weight'].toString());
    TextEditingController heightController =
        TextEditingController(text: _data['height'].toString());

    // Gender dropdown value
    String selectedGender = _data['gender'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                ),
                // Gender Dropdown
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  decoration: const InputDecoration(labelText: 'Gender'),
                  items: const [
                    DropdownMenuItem(
                      value: 'MALE',
                      child: Text('MALE'),
                    ),
                    DropdownMenuItem(
                      value: 'FEMALE',
                      child: Text('FEMALE'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                ),
                TextField(
                  controller: weightController,
                  decoration: const InputDecoration(labelText: 'Weight (Kg)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: heightController,
                  decoration: const InputDecoration(labelText: 'Height (cm)'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Prepare the updated data
                Map<String, dynamic> updatedData = {
                  'name': nameController.text,
                  'age': int.parse(ageController.text),
                  'gender': selectedGender,
                  'weight': double.parse(weightController.text),
                  'height': double.parse(heightController.text),
                };

                // Get the athlete ID
                final athleteId = _data['id'];

                // Initialize ApiService
                final ApiService apiService =
                    ApiService(baseUrl: ApiConfig.baseUrl);

                try {
                  // Send the updated data to the backend
                  await apiService.updateAthlete(athleteId, updatedData);

                  // Update the local data
                  setState(() {
                    _data['name'] = updatedData['name'];
                    _data['age'] = updatedData['age'];
                    _data['gender'] = updatedData['gender'];
                    _data['weight'] = updatedData['weight'];
                    _data['height'] = updatedData['height'];
                  });

                  // Show a success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Profile updated successfully')),
                  );

                  // Close the dialog
                  Navigator.pop(context);
                } catch (e) {
                  // Show an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to update profile: $e')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
