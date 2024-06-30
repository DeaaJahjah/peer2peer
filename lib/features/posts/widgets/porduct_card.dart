import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    Key? key,
    // required this.service
  }) : super(key: key);
  // final ServiceModel service;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.white,
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://plus.unsplash.com/premium_photo-1674180786953-4223a4208d9a?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'), // Replace with actual image URL
                  radius: 30,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fix laptop',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                        ),
                        Text(' Syria - Homs'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Image.network(
              'https://via.placeholder.com/150', // Replace with actual image URL
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            const Wrap(
              spacing: 8,
              children: [
                Chip(label: Text('LAPTOP')),
                Chip(label: Text('LAPTOP')),
                Chip(label: Text('LAPTOP')),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'My laptop is broken down any one can help me to fix this problem',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '500\$',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
