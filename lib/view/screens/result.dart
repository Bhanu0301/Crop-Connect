import 'dart:io';

import 'package:flutter/material.dart';

// class ResultPage extends StatelessWidget {
//   final File image;
//   final String result;
//   final dynamic probability;

//   const ResultPage({
//     super.key,
//     required this.image,
//     required this.result,
//     required this.probability,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           'Classification Result',
//           style: TextStyle(
//               fontWeight: FontWeight.bold,
//               height: 1.4,
//               fontFamily: 'SofiaSans',
//               fontSize: 20),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 width: 250.0, 
//                 height: 250.0,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Color.fromARGB(255, 158, 216, 245),
//                     width: 2.0, 
//                   ),
//                   borderRadius:
//                       BorderRadius.circular(12.0), 
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(
//                       12.0), 
//                   child: Image.file(
//                     image,
//                     fit: BoxFit.cover, // Ensures the image covers the container
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             Text(
//               'Result: $result',
//               style: const TextStyle(
//                   fontSize: 20,
//                   fontFamily: 'SofiaSans',
//                   fontWeight: FontWeight.bold),
//             ),
//             Text(
//               'Probability: ${(probability * 100).toStringAsFixed(2)}%',
//               style: const TextStyle(fontSize: 18),
//             ),
//             const SizedBox(
//               height: 40,
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pop();
//               },
//               child: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 20),
//                 alignment: Alignment.center,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
//                 decoration: BoxDecoration(
//                   color: Colors.blueGrey,
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: const Text(
//                   'Back to Home',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'SofiaSans'),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


class ResultPage extends StatelessWidget {
  final File image;
  final String result;
  final dynamic probability;
  final String possibleReason;
  final String treatments;

  const ResultPage({
    Key? key,
    required this.image,
    required this.result,
    required this.probability,
    required this.possibleReason,
    required this.treatments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classification Result'),
      ),
      body: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 250.0,
                  height: 250.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 158, 216, 245),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.file(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Result: $result',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Probability: ${(probability * 100).toStringAsFixed(2)}%',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Possible Reason:',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      possibleReason,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Treatments:',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      treatments,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Back to Home',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
