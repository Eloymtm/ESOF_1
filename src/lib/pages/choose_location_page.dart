import 'package:flutter/material.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:src/helper/globalVariables.dart';

class MyPlacePickerPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GooglePlacesAutoCompleteTextFormField(
              textEditingController: _controller,
              googleAPIKey: 'AIzaSyB6QV64EZpTljpRW55bxIHmf-zii_jr6OQ',
              debounceTime: 400,
              countries: ["PT"],
              isLatLngRequired: true,
              getPlaceDetailWithLatLng: (prediction) {
                print("Coordinates: (${prediction.lat},${prediction.lng})");
                // Do something with the coordinates
              },
              itmClick: (prediction) {
                _controller.text = prediction.description!;
                _controller.selection = TextSelection.fromPosition(
                    TextPosition(offset: prediction.description!.length));
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Use _controller.text to get the selected place
                print('Selected place: ${_controller.text}');
              },
              child: Text('Select Place'),
            ),
          ],
        ),
      ),
    );
  }
}