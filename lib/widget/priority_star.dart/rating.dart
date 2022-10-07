import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PrioritySlider extends StatefulWidget {
  const PrioritySlider({
    Key? key,
  }) : super(key: key);

  @override
  State<PrioritySlider> createState() => _PrioritySliderState();
}

class _PrioritySliderState extends State<PrioritySlider> {
  // late double _rating;
  double rating = 1;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      minRating: 1,
      maxRating: 3,
      itemCount: 3,
      allowHalfRating: false,
      itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
      onRatingUpdate: (rating) {
        setState(() {
          this.rating = rating;
        });
      },
      updateOnDrag: true,
    );

    // return Slider.adaptive(
    //   value: _currentSliderValue,
    //   min: 1,
    //   max: 3,
    //   divisions: 3,
    //   label: _currentSliderValue.round().toString(),
    //   onChanged: (double value) {
    //     setState(() {
    //       _currentSliderValue = value;
    //     });
    //   },
    // );
  }
}
