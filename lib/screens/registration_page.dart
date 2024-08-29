import 'package:flutter/material.dart';

void main() {
  runApp(VehicleRegistrationApp());
}

class VehicleRegistrationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VehicleRegistrationForm(),
    );
  }
}

class VehicleRegistrationForm extends StatefulWidget {
  @override
  _VehicleRegistrationFormState createState() =>
      _VehicleRegistrationFormState();
}

class _VehicleRegistrationFormState extends State<VehicleRegistrationForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Registration'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField(
              labelText: 'Address',
              icon: Icons.home,
            ),
            _buildTextField(
              labelText: 'Type of motor',
              icon: Icons.directions_car,
            ),
            _buildTextField(
              labelText: 'Contact information',
              icon: Icons.phone,
            ),
            _buildTextField(
              labelText: 'Date of birth',
              icon: Icons.calendar_today,
            ),
            _buildTextField(
              labelText: 'Date of issue',
              icon: Icons.calendar_today,
            ),
            _buildTextField(
              labelText: 'Expiry date',
              icon: Icons.calendar_today,
            ),
            _buildTextField(
              labelText: 'License number',
              icon: Icons.badge,
            ),
            _buildTextField(
              labelText: 'Car model',
              icon: Icons.directions_car,
            ),
            _buildTextField(
              labelText: 'Registrant\'s name',
              icon: Icons.person,
            ),
            _buildTextField(
              labelText: 'Region',
              icon: Icons.location_on,
            ),
            _buildTextField(
              labelText: 'Plate number',
              icon: Icons.directions_car,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your submit functionality here
              },
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String labelText, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
