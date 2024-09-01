// import 'package:flutter/material.dart';

// class HelpPage extends StatelessWidget {
//   const HelpPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Help and Feedback'),
//       ),
//       body: const Center(
//         child: Text(
//           'Help and Feedback Page Content',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:yolo/screens/about_app.dart';

class HelpAndFeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Handle back button press
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Help & Feedback',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // FAQ Section
              Text(
                'FAQ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('How does the app work?'),
                subtitle: Text('Learn how to use the app.'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Handle FAQ item tap
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutApp()));
                },
              ),
              // ListTile(
              //   contentPadding: EdgeInsets.zero,
              //   title: Text('Where is my data stored?'),
              //   trailing: Icon(Icons.arrow_forward_ios, size: 16),
              //   onTap: () {
              //     // Handle FAQ item tap
              //   },
              // ),
              SizedBox(height: 20),
              // Contact Support Section
              Text(
                'Contact support',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Email us'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Handle contact support item tap
                },
              ),
              SizedBox(height: 20),
              // Feedback Section
              Text(
                'Feedback',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        '4',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            color: index < 4 ? Colors.blue : Colors.grey,
                            size: 20,
                          );
                        }),
                      ),
                      Text('100 reviews', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      children: List.generate(5, (index) {
                        return Row(
                          children: [
                            Text('${5 - index}'),
                            Expanded(
                              child: LinearProgressIndicator(
                                value: [0.5, 0.2, 0.15, 0.05, 0.1][index],
                                backgroundColor: Colors.grey[300],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.blue,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text('${[50, 20, 15, 5, 10][index]}%'),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Feedback Input
              Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(
                            8.0), // Optional: for rounded corners
                      ),
                      child: TextField(
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText: 'Tell us what you think',
                          hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Optional: for rounded corners
                          ),
                          contentPadding:
                              EdgeInsets.all(16.0), // Adjust padding as needed
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                        ),
                      ))),
              const SizedBox(height: 20),
              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle submit feedback
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
