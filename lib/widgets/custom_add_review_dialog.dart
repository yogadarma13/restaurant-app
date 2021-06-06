import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/result_state.dart';
import 'package:restaurant_app/provider/review_provider.dart';

class CustomAddReviewDialog extends StatefulWidget {
  final String restaurantId;

  CustomAddReviewDialog({@required this.restaurantId});

  @override
  _CustomAddReviewDialogState createState() => _CustomAddReviewDialogState();
}

class _CustomAddReviewDialogState extends State<CustomAddReviewDialog> {
  final nameController = TextEditingController();
  final reviewController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReviewProvider(apiService: ApiService()),
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        elevation: 0.0,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  "Tambah Review",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                "Nama",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: nameController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.blue.shade400),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    )),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                "Review",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: reviewController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.blue.shade400),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Consumer<ReviewProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.state == ResultState.HasData) {
                    Fluttertoast.showToast(
                        msg: state.message, toastLength: Toast.LENGTH_SHORT);
                    Navigator.of(context).pop();
                    return Container();
                  } else if (state.state == ResultState.NoData) {
                    Fluttertoast.showToast(
                        msg: state.message, toastLength: Toast.LENGTH_SHORT);
                    Navigator.of(context).pop();
                    return Container();
                  } else if (state.state == ResultState.Error) {
                    Fluttertoast.showToast(
                        msg: state.message, toastLength: Toast.LENGTH_SHORT);
                    return Container(
                      child: ElevatedButton(
                        onPressed: () {
                          (nameController.text.isEmpty ||
                                  reviewController.text.isEmpty)
                              ? Fluttertoast.showToast(
                                  msg: "Lengkapi data terlebih dahulu",
                                  toastLength: Toast.LENGTH_SHORT)
                              : state.addNewReview(widget.restaurantId,
                                  nameController.text, reviewController.text);
                        },
                        child: Text("Tambahkan review"),
                      ),
                    );
                  } else {
                    return Container(
                      child: ElevatedButton(
                        onPressed: () {
                          (nameController.text.isEmpty ||
                                  reviewController.text.isEmpty)
                              ? Fluttertoast.showToast(
                                  msg: "Lengkapi data terlebih dahulu",
                                  toastLength: Toast.LENGTH_SHORT)
                              : state.addNewReview(widget.restaurantId,
                                  nameController.text, reviewController.text);
                        },
                        child: Text("Tambahkan review"),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
