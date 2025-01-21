import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/usecases/add_player_usecase.dart';
import '../../data/models/player_model.dart';

class AddPlayerPopup extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController gamerTagController = TextEditingController();

  AddPlayerPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Player'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            maxLength: 30,
            decoration: const InputDecoration(
              labelText: 'Enter Player Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: gamerTagController,
            maxLength: 10,
            decoration: const InputDecoration(
              labelText: 'Enter Gamer Tag ID',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close pop-up
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (nameController.text.isNotEmpty &&
                gamerTagController.text.isNotEmpty) {
              // Create a Player object
              final player = Player(
                name: nameController.text,
                gamerTag: gamerTagController.text,
                imageUrl:
                'https://via.placeholder.com/150', // Placeholder image
              );

              // Add the player using the use case
              await Get.find<AddPlayerUseCase>().execute(player);

              // Close the pop-up and show a success message
              Get.back();
              Get.snackbar('Success', 'Player added successfully!',
                  snackPosition: SnackPosition.BOTTOM);
            } else {
              Get.snackbar('Error', 'Please fill all fields!',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white);
            }
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
