import 'package:flutter/material.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:src/helper/globalVariables.dart';

class GooglePlacesAutoCompleteField extends StatelessWidget {
  final TextEditingController controller;
  final String googleAPIKey;

  const GooglePlacesAutoCompleteField({super.key, 
    required this.controller,
    required this.googleAPIKey,
  });

  @override
  Widget build(BuildContext context) {
    return GooglePlacesAutoCompleteTextFormField(
      textEditingController: controller,
      googleAPIKey: googleAPIKey,
      debounceTime: 400,
      countries: const ["PT"],
      isLatLngRequired: true,
      getPlaceDetailWithLatLng: (prediction) {
        
      },
      itmClick: (prediction) {
        controller.text = prediction.description!;
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: prediction.description!.length),
        );
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        prefix: const Padding(padding: EdgeInsets.only(right: 15, bottom: 5)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2.0, color: primaryColor),
          borderRadius: BorderRadius.circular(5),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        suffixIcon: const Icon(Icons.location_on),
      ),
    );
  }
}