// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class PostScreen extends StatelessWidget {
//   void _pickImage(BuildContext context) async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       // Use the pickedImage file for further processing (e.g., displaying, uploading)
//       // You can implement your logic here
//       print('Image picked: ${pickedImage.path}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CropConnect Lab'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Text(
//                 'Post the Image of the infected part of plant to detect the disease and severity',
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _pickImage(context),
//               child: Text('Select Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class PlantDiseaseDetectionScreen extends StatefulWidget {
//   @override
//   _PlantDiseaseDetectionScreenState createState() =>
//       _PlantDiseaseDetectionScreenState();
// }

// class _PlantDiseaseDetectionScreenState
//     extends State<PlantDiseaseDetectionScreen> {
//   File? _imageFile;
//   bool _processing = false;
//   String _diseaseResult = '';

//   void _pickImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       setState(() {
//         _imageFile = File(pickedImage.path);
//       });
//     }
//   }

//   void _detectDisease() {
//     // Perform image processing and disease detection here
//     // Replace this with your actual implementation
//     setState(() {
//       _processing = true;
//     });

//     // Simulating processing delay
//     Future.delayed(Duration(seconds: 2), () {
//       // Replace this with your actual disease detection logic
//       // For demonstration, we'll just display a mock result
//       setState(() {
//         _diseaseResult = 'Tomato Leaf Mold';
//         _processing = false;
//       });
//     });
//   }

//   void _generateReport() {
//     // Generate a report based on the detected disease
//     // You can format the report as needed (e.g., PDF, text)
//     // Replace this with your actual report generation logic
//     // For demonstration, we'll just print the result
//     print('Generating report for $_diseaseResult');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Plant Disease Detection'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _imageFile != null
//                 ? Image.file(
//                     _imageFile!,
//                     height: 200,
//                   )
//                 : Icon(
//                     Icons.image,
//                     size: 100,
//                   ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Select Image'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _detectDisease,
//               child: _processing
//                   ? CircularProgressIndicator()
//                   : Text('Detect Disease'),
//             ),
//             SizedBox(height: 20),
//             _diseaseResult.isNotEmpty
//                 ? Column(
//                     children: [
//                       Text(
//                         'Detected Disease:',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 10),
//                       Text(_diseaseResult),
//                       SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: _generateReport,
//                         child: Text('Download Report'),
//                       ),
//                     ],
//                   )
//                 : SizedBox(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: PlantDiseaseDetectionScreen(),
//   ));
// }
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:helloworld/view/screens/result.dart';
// import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image/image.dart' as img;
// import 'dart:math';

// class PlantDiseaseDetectionScreen extends StatefulWidget {
//   const PlantDiseaseDetectionScreen({super.key});

//   @override
//   State<PlantDiseaseDetectionScreen> createState() => _HomePageState();
// }

// class _HomePageState extends State<PlantDiseaseDetectionScreen> {
//   late File _image;
//   dynamic _probability = 0;
//   String? _result;
//   List<String>? _labels;
//   late tfl.Interpreter _interpreter;
//   final picker = ImagePicker();
//   @override
//   void initState() {
//     super.initState();
//     loadModel().then((_) {
//       loadLabels().then((loadedLabels) {
//         setState(() {
//           _labels = loadedLabels;
//         });
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _interpreter.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//         body: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 const SizedBox(height: 80),
//                 const Text(
//                   'Crop Connect Lab',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       color: Color.fromARGB(255, 18, 19, 18),
//                       fontWeight: FontWeight.bold,
//                       height: 1.4,
//                       fontFamily: 'SofiaSans',
//                       fontSize: 16),
//                 ),
//                 const SizedBox(height: 15),
//                 Center(
//                   child: SizedBox(
//                           width: 150,
//                           child: Column(
//                             children: <Widget>[
//                               Image.asset('assets/plant.png'),
//                               const SizedBox(height: 15),
//                             ],
//                           ),
//                         )
                     
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             pickImageFromCamera();
//                           },
//                           child: Container(
//                             alignment: Alignment.center,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 18),
//                             decoration: BoxDecoration(
//                               color: Colors.black38,
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             child: const Text(
//                               'Capture a Photo',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'SofiaSans'),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 20),
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             pickImageFromGallery();
//                           },
//                           child: Container(
//                             alignment: Alignment.center,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 18),
//                             decoration: BoxDecoration(
//                               color: Colors.black38,
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             child: const Text(
//                               'Select a photo',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'SofiaSans'),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             )));
//   }

//   Future<void> loadModel() async {
//     try {
//       _interpreter = await tfl.Interpreter.fromAsset('assets/model_unquant.tflite');
//     } catch (e) {
//       debugPrint('Error loading model: $e');
//     }
//   }

//   Future<void> pickImageFromCamera() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       _setImage(File(pickedFile.path));
//     }
//   }

//   Future<void> pickImageFromGallery() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       _setImage(File(pickedFile.path));
//     }
//   }

//   void _setImage(File image) {
//     setState(() {
//       _image = image;
//     });
//     runInference();
//   }

//   Future<Uint8List> preprocessImage(File imageFile) async {
//     // Decode the image to an Image object
//     img.Image? originalImage = img.decodeImage(await imageFile.readAsBytes());
//     Uint8List bytes1 = originalImage!.getBytes();
//     print(bytes1);
//     // Resize the image to the correct size
//     img.Image resizedImage =
//         img.copyResize(originalImage!, width: 224, height: 224);

//     // Convert to a byte buffer in the format suitable for TensorFlow Lite (RGB)
//     // The model expects a 4D tensor [1, 224, 224, 3]
//     // Flatten the resized image to match this shape
//     Uint8List bytes = resizedImage.getBytes();
//     print(bytes);
//     return bytes;
//   }

//   Future<void> runInference() async {
//   if (_labels == null) {
//     return;
//   }

//   try {
//     Uint8List inputBytes = await preprocessImage(_image);
//     var input = inputBytes.buffer.asUint8List().reshape([1, 224, 224, 3]);
//     var outputBuffer = List<double>.filled(1 * 15, 0).reshape([1, 15]);

//     _interpreter.run(input, outputBuffer);

//     // Assuming output is now List<List<double>> after inference
//     List<double> output = outputBuffer[0];

//     // Print raw output for debugging
//     debugPrint('Raw output: $output');

//     // Calculate probability
//     double maxScore = output.reduce(max);
//     _probability = (maxScore / 1.0); // Convert to percentage

//     // Get the classification result
//     int highestProbIndex = output.indexOf(maxScore);
//     String classificationResult = _labels![highestProbIndex];

//     setState(() {
//       _result = classificationResult;
//       // _probability is updated with the calculated probability
//     });

//     navigateToResult();
//   } catch (e) {
//     debugPrint('Error during inference: $e');
//   }
// }

//   Future<List<String>> loadLabels() async {
//     final labelsData =
//         await DefaultAssetBundle.of(context).loadString('assets/labels.txt');
//     return labelsData.split('\n');
//   }

//   String classifyImage(List<int> output) {
//     int highestProbIndex = output.indexOf(output.reduce(max));
//     return _labels![highestProbIndex];
//   }

//   void navigateToResult() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ResultPage(
//           image: _image,
//           result: _result!,
//           probability: _probability,
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:helloworld/view/screens/result.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

class PlantDiseaseDetectionScreen extends StatefulWidget {
  const PlantDiseaseDetectionScreen({Key? key}) : super(key: key);

  @override
  _PlantDiseaseDetectionScreenState createState() =>
      _PlantDiseaseDetectionScreenState();
}

class _PlantDiseaseDetectionScreenState
    extends State<PlantDiseaseDetectionScreen> {
  late File _image;
  dynamic _probability = 0;
  String? _result;
  List<String>? _labels;
  late tfl.Interpreter _interpreter;
  final picker = ImagePicker();
  TextEditingController pHController = TextEditingController();
  TextEditingController moistureController = TextEditingController();
  TextEditingController nValueController = TextEditingController();
  TextEditingController pValueController = TextEditingController();
  TextEditingController kValueController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadModel().then((_) {
      loadLabels().then((loadedLabels) {
        setState(() {
          _labels = loadedLabels;
        });
      });
    });
  }

  @override
  void dispose() {
    _interpreter.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text('Plant & Soil Analysis'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Plant Detection'),
              Tab(text: 'Soil Analysis'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPlantDetectionTab(),
            _buildSoilAnalysisTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlantDetectionTab() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 80),
          const Text(
            'Crop Connect Lab',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 18, 19, 18),
              fontWeight: FontWeight.bold,
              height: 1.4,
              fontFamily: 'SofiaSans',
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: SizedBox(
              width: 150,
              child: Column(
                children: <Widget>[
                  Image.asset('assets/plant.png'),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      pickImageFromCamera();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Capture a Photo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SofiaSans',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      pickImageFromGallery();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Select a photo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SofiaSans',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSoilAnalysisTab() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 30),
            const Text(
              'Soil Analysis',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Color.fromARGB(255, 18, 19, 18),
                fontWeight: FontWeight.bold,
                height: 1.4,
                fontFamily: 'SofiaSans',
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: SizedBox(
                width: 150, // Adjust the width as needed
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/soil.png'),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
            _buildInputField('pH', 'pH value (0-14)', pHController),
            _buildInputField(
                'Moisture Level', 'Moisture Level (%)', moistureController),
            _buildInputField('N Value', 'N Value (kg/ha)', nValueController),
            _buildInputField('P Value', 'P Value (kg/ha)', pValueController),
            _buildInputField('K Value', 'K Value (kg/ha)', kValueController),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: analyzeSoil,
                child: Text('Analyze Soil'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
      String labelText, String unitDescription, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        suffixText: unitDescription,
      ),
    );
  }

  void analyzeSoil() {
  double pH = double.tryParse(pHController.text) ?? 0;
  double moistureLevel = double.tryParse(moistureController.text) ?? 0;
  double nValue = double.tryParse(nValueController.text) ?? 0;
  double pValue = double.tryParse(pValueController.text) ?? 0;
  double kValue = double.tryParse(kValueController.text) ?? 0;

  // Perform soil analysis logic here

  // Descriptions based on the values entered
  String pHDescription = _getPHDescription(pH);
  String moistureDescription = _getMoistureDescription(moistureLevel);
  // Add descriptions for N, P, and K values

  // Calculate N:P:K ratio
  String npkRatio = _calculateNPKRatio(nValue, pValue, kValue);

  // Display the analysis results
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Soil Analysis Result'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('pH: $pH - $pHDescription'),
            Text('Moisture Level: $moistureLevel - $moistureDescription'),
            Text('N Value: $nValue'),
            Text('P Value: $pValue'),
            Text('K Value: $kValue'),
            Text('N:P:K Ratio: $npkRatio'),
            SizedBox(height: 10),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

String _calculateNPKRatio(double nValue, double pValue, double kValue) {
  // Find the lowest value among N, P, and K
  double lowestValue = min(min(nValue, pValue), kValue);

  // Check if the lowest value is not zero to avoid division by zero
  if (lowestValue != 0) {
    double nRatio = (nValue / lowestValue);
    double pRatio = (pValue / lowestValue);
    double kRatio = (kValue / lowestValue);
    return '${nRatio.toStringAsFixed(2)}:${pRatio.toStringAsFixed(2)}:${kRatio.toStringAsFixed(2)}';
  } else {
    return 'N/A';
  }
}


String _getPHDescription(double pH) {
  // Add logic to provide descriptions based on pH value
  if (pH < 6) {
    return 'Acidic soil';
  } else if (pH >= 6 && pH <= 7.5) {
    return 'Neutral soil';
  } else {
    return 'Alkaline soil';
  }
}

String _getMoistureDescription(double moistureLevel) {
  // Add logic to provide descriptions based on moisture level
  if (moistureLevel < 20) {
    return 'Dry soil';
  } else if (moistureLevel >= 20 && moistureLevel <= 60) {
    return 'Moist soil';
  } else {
    return 'Wet soil';
  }
}
  Future<void> loadModel() async {
    try {
      _interpreter =
          await tfl.Interpreter.fromAsset('assets/model_unquant.tflite');
    } catch (e) {
      debugPrint('Error loading model: $e');
    }
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _setImage(File(pickedFile.path));
    }
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _setImage(File(pickedFile.path));
    }
  }

  void _setImage(File image) {
    setState(() {
      _image = image;
    });
    runInference();
  }

  Future<Uint8List> preprocessImage(File imageFile) async {
    img.Image? originalImage =
        img.decodeImage(await imageFile.readAsBytes());
    Uint8List bytes1 = originalImage!.getBytes();
    img.Image resizedImage =
        img.copyResize(originalImage!, width: 224, height: 224);
    Uint8List bytes = resizedImage.getBytes();
    return bytes;
  }

  Future<void> runInference() async {
    if (_labels == null) {
      return;
    }

    try {
      Uint8List inputBytes = await preprocessImage(_image);
      var input =
          inputBytes.buffer.asUint8List().reshape([1, 224, 224, 3]);
      var outputBuffer = List<double>.filled(1 * 15, 0).reshape([1, 15]);

      _interpreter.run(input, outputBuffer);

      List<double> output = outputBuffer[0];
      double maxScore = output.reduce(max);
      _probability = (maxScore / 1.0);
      int highestProbIndex = output.indexOf(maxScore);
      String classificationResult = _labels![highestProbIndex];

      setState(() {
        _result = classificationResult;
      });

      navigateToResult();
    } catch (e) {
      debugPrint('Error during inference: $e');
    }
  }

  Future<List<String>> loadLabels() async {
    final labelsData =
        await DefaultAssetBundle.of(context).loadString('assets/labels.txt');
    return labelsData.split('\n');
  }
final Map<String, Map<String, String>> diseaseInfo = {
  'apple scab': {
    'Cause': 'Fungus (Venturia inaequalis)',
    'Treatment':
        'Fungicides like captan, myclobutanil, or sulfur; cultural practices like removing fallen leaves to reduce overwintering spores.'
  },
  'apple black rot': {
    'Cause': 'Fungus (Botryosphaeria obtusa)',
    'Treatment':
        'Fungicides like captan, myclobutanil, or thiophanate-methyl; pruning infected branches; removal of mummified fruit.'
  },
  'apple cedar apple rust': {
    'Cause': 'Fungus (Gymnosporangium juniperi-virginianae)',
    'Treatment':
        'Fungicides like myclobutanil or sulfur; removal of juniper hosts; planting resistant apple varieties.'
  },
  'blueberry healthy': {
    'Cause': 'Various diseases like mummy berry, anthracnose, or powdery mildew',
    'Treatment':
        'Preventive fungicides and good cultural practices are essential for maintaining blueberry health.'
  },
  'cherry including sour powdery mildew': {
    'Cause': 'Fungus (Podosphaera spp.)',
    'Treatment':
        'Fungicides like sulfur, potassium bicarbonate, or myclobutanil; pruning to increase airflow.'
  },
  'peach bacterial spot': {
    'Cause': 'Bacteria (Xanthomonas arboricola pv. pruni)',
    'Treatment':
        'Copper-based fungicides, pruning to increase airflow, planting resistant varieties. Natural remedies include neem oil or garlic spray.'
  },
  'pepper bell bacterial spot': {
    'Cause': 'Bacteria (Xanthomonas spp.)',
    'Treatment':
        'Copper-based fungicides, resistant varieties, crop rotation. Natural remedies include baking soda spray or milk spray.'
  },
  'potato early blight': {
    'Cause': 'Fungus (Alternaria solani)',
    'Treatment':
        'Fungicides containing chlorothalonil, copper, or maneb; crop rotation; removal of infected plant debris.'
  },
  'potato late blight': {
    'Cause': 'Oomycete (Phytophthora infestans)',
    'Treatment':
        'Fungicides containing chlorothalonil, mefenoxam, or mancozeb; resistant potato varieties; good airflow and drainage.'
  },
  'raspberry healthy': {
    'Cause': 'Common diseases of raspberries include raspberry cane blight, anthracnose, and raspberry mosaic virus',
    'Treatment':
        'Regular pruning, sanitation, and fungicide applications can help keep raspberries healthy.'
  },
  'soybean healthy': {
    'Cause': 'Soybeans can be susceptible to diseases like soybean rust, soybean cyst nematode, and various fungal rots',
    'Treatment':
        'Planting disease-resistant varieties and crop rotation are important for soybean health.'
  },
  'squash powdery mildew': {
    'Cause': 'Fungus (Podosphaera xanthii)',
    'Treatment':
        'Fungicides like sulfur, potassium bicarbonate, or myclobutanil; planting resistant varieties; maintaining good airflow. Natural remedies include milk spray or baking soda spray.'
  },
  'strawberry leaf scorch': {
    'Cause': 'Fungus (Diplocarpon earlianum)',
    'Treatment':
        'Fungicides like chlorothalonil, myclobutanil, or thiophanate-methyl; removal of infected leaves.'
  },
  'tomato bacterial spot': {
    'Cause': 'Bacteria (Xanthomonas spp.)',
    'Treatment':
        'Copper-based fungicides, resistant varieties, crop rotation. Natural remedies include copper spray or garlic spray.'
  },
  'tomato leaf mold': {
    'Cause': 'Fungus (Fulvia fulva)',
    'Treatment':
        'Fungicides like chlorothalonil or mancozeb; maintaining lower humidity levels; good airflow.'
  },
  'tomato spider mites two-spotted spider mite': {
    'Cause': 'Mites (Tetranychus urticae)',
    'Treatment':
        'Miticides like abamectin or spiromesifen; insecticidal soap or neem oil; maintaining humidity to discourage mite reproduction.'
  },
  'tomato target spot': {
    'Cause': 'Fungus (Corynespora cassiicola)',
    'Treatment':
        'Fungicides like chlorothalonil or mancozeb; removal of infected plant debris; good airflow.'
  },
  'tomato tomato yellow leaf curl virus': {
    'Cause': 'Virus (Begomovirus)',
    'Treatment':
        'There is no cure; management includes controlling whiteflies, removing infected plants, and planting virus-resistant varieties.'
  },
  'tomato tomato mosaic virus': {
    'Cause': 'Virus (Potyvirus)',
    'Treatment':
        'There is no cure; management includes removing infected plants, controlling aphid vectors, and planting virus-resistant varieties.'
  },
  
  'pepper bell healthy': {
    'Cause': 'Various diseases like bacterial spot, bacterial wilt, and various fungal diseases',
    'Treatment':
        'Fungicides, cultural practices, and disease-resistant varieties are key for pepper health.'
  },
  
  'potato healthy': {
    'Cause': 'Various diseases like blackleg, common scab, and potato virus Y',
    'Treatment':
        'Good crop rotation, certified disease-free seed potatoes, and fungicide applications can help maintain potato health.'
  },
  
  
  'strawberry healthy': {
    'Cause': 'Diseases like strawberry anthracnose, verticillium wilt, and powdery mildew',
    'Treatment':
        'Fungicides, good irrigation practices, and removal of infected plant parts are important for strawberry health.'
  },
  
  'tomato early blight': {
    'Cause': 'Fungus (Alternaria solani)',
    'Treatment':
        'Fungicides containing chlorothalonil, copper, or maneb; removal of infected leaves; good airflow. Natural remedies include baking soda spray or neem oil.'
  },
  'tomato late blight': {
    'Cause': 'Oomycete (Phytophthora infestans)',
    'Treatment':
        'Fungicides containing chlorothalonil, mefenoxam, or mancozeb; resistant tomato varieties; good irrigation practices. Natural remedies include copper spray or garlic spray.'
  },
  
  'tomato septoria leaf spot': {
    'Cause': 'Fungus (Septoria lycopersici)',
    'Treatment':
        'Fungicides containing chlorothalonil, copper, or maneb; removal of infected leaves; good airflow.'
  },
  'peach healthy': {
    'Cause': 'No disease detected',
    'Treatment':
        'Implement proper peach orchard management practices to maintain tree health. Adequate irrigation, fertilization, and pest control are essential for promoting tree vigor and minimizing disease susceptibility.'
  },
  'apple healthy': {
    'Cause': 'No disease detected',
    'Treatment':
        'Maintain proper care and nutrition to keep the apple tree healthy. Pruning, regular watering, and fertilization are essential cultural practices for maintaining tree health.'
  },
  'cherry including sour healthy': {
    'Cause': 'No disease detected',
    'Treatment':
        'Proper care and maintenance practices to ensure cherry tree health. Adequate irrigation, fertilization, and pest control are essential for promoting tree vigor and minimizing disease susceptibility.'
  },
  'corn maize cercospora leaf spot gray leaf spot': {
    'Cause': 'Fungus (Cercospora spp.)',
    'Treatment':
        'Crop rotation, planting resistant varieties, and foliar fungicides containing active ingredients like chlorothalonil or azoxystrobin can help manage cercospora leaf spot and gray leaf spot in corn.'
  },
  'corn maize common rust': {
  'Cause': 'Fungus (Puccinia sorghi)',
  'Treatment':
      'Planting resistant varieties and applying fungicides containing active ingredients like azoxystrobin or pyraclostrobin can help control common rust in corn. Regular scouting and removal of infected leaves can also aid in disease management.'
},

  'corn maize northern leaf blight': {
    'Cause': 'Fungus (Exserohilum turcicum)',
    'Treatment':
        'Fungicides like azoxystrobin, rotation with non-host crops, and planting resistant hybrids can help manage northern leaf blight in corn. Proper field sanitation and removal of crop debris after harvest are important preventive measures.'
  },
  'corn maize healthy': {
    'Cause': 'No disease detected',
    'Treatment':
        'Adopt good agricultural practices and ensure proper soil and plant management to maintain corn health. Crop rotation, balanced fertilization, and timely weed control are essential for disease prevention.'
  },
  'grape black rot': {
    'Cause': 'Fungus (Guignardia bidwellii)',
    'Treatment':
        'Fungicides like captan, myclobutanil, or thiophanate-methyl are commonly used to control black rot in grapes. Removal of infected plant parts, including mummified berries, can also help reduce disease inoculum.'
  },
  'grape esca black measles': {
    'Cause': 'Fungus (Phaeomoniella chlamydospora)',
    'Treatment':
        'Pruning infected wood and applying fungicides like propiconazole or fosetyl-aluminum can help manage esca and black measles in grapes. Early detection and removal of symptomatic vines are crucial for disease control.'
  },
  'grape leaf blight isariopsis leaf spot': {
    'Cause': 'Fungus (Isariopsis spp.)',
    'Treatment':
        'Fungicides like captan, mancozeb, or azoxystrobin can help manage leaf blight and isariopsis leaf spot in grapes. Proper canopy management and good airflow within the vineyard can also aid in disease prevention.'
  },
  'grape healthy': {
    'Cause': 'No disease detected',
    'Treatment':
        'Regularly monitor grapevines and maintain proper vineyard management practices. Adequate nutrition, irrigation, and pest control are essential for promoting plant health and productivity.'
  },
  'orange huanglongbing citrus greening': {
    'Cause': 'Bacteria (Candidatus Liberibacter spp.)',
    'Treatment':
        'There is no cure for citrus greening disease. Management strategies include removal of infected trees, controlling psyllid vectors through insecticides, and promoting overall tree health through proper nutrition and irrigation.'
  },
  'tomato healthy': {
    'Cause': 'Various diseases like blossom end rot, blossom drop, and various fungal wilts',
    'Treatment':
        'Proper watering, fertilization, and disease management are essential for tomato health.'
  },
  
  // Add more diseases, reasons, and treatments here
};
List<String> getReasonAndTreatment(String disease) {
  final Map<String, String> info = diseaseInfo[disease] ?? {};
  final String cause = info['Cause'] ?? 'Unknown';
  final String treatment = info['Treatment'] ?? 'Unknown';
  return [cause, treatment];
}
  void navigateToResult() {
  // Trim whitespace and convert to lowercase
  String detectedDisease = _result!.trim().toLowerCase();

  // Get possible reason and treatment for the detected disease
  List<String> reasonAndTreatment = getReasonAndTreatment(detectedDisease);
  String possibleReason = reasonAndTreatment[0];
  String treatments = reasonAndTreatment[1];

  // Navigate to the result page with the detected disease, possible reason, and treatments
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ResultPage(
        image: _image,
        result: _result!,
        probability: _probability,
        possibleReason: possibleReason,
        treatments: treatments,
      ),
    ),
  );
  }


// import 'dart:io';
// import 'dart:typed_data';
// import 'package:helloworld/view/screens/result.dart';
// import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image/image.dart' as img;
// import 'dart:math';

// class PlantDiseaseDetectionScreen extends StatefulWidget {
//   const PlantDiseaseDetectionScreen({super.key});

//   @override
//   State<PlantDiseaseDetectionScreen> createState() => _PlantDiseaseDetectionScreenState();
// }

// class _PlantDiseaseDetectionScreenState extends State<PlantDiseaseDetectionScreen> {
//   late File _image;
//   dynamic _probability = 0;
//   String? _result;
//   List<String>? _labels;
//   late tfl.Interpreter _interpreter;
//   final picker = ImagePicker();
  
//   @override
//   void initState() {
//     super.initState();
//     loadModel().then((_) {
//       loadLabels().then((loadedLabels) {
//         setState(() {
//           _labels = loadedLabels;
//         });
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _interpreter.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//         appBar: AppBar(
//           title: const Text('Plant & Soil Analysis'),
//           bottom: TabBar(
//             tabs: [
//               Tab(text: 'Plant Detection'),
//               Tab(text: 'Soil Analysis'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             _buildPlantDetectionTab(),
//             _buildSoilAnalysisTab(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPlantDetectionTab() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           const SizedBox(height: 80),
//           const Text(
//             'Crop Connect Lab',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Color.fromARGB(255, 18, 19, 18),
//               fontWeight: FontWeight.bold,
//               height: 1.4,
//               fontFamily: 'SofiaSans',
//               fontSize: 16,
//             ),
//           ),
//           const SizedBox(height: 15),
//           Center(
//             child: SizedBox(
//               width: 150,
//               child: Column(
//                 children: <Widget>[
//                   Image.asset('assets/plant.png'),
//                   const SizedBox(height: 15),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       pickImageFromCamera();
//                     },
//                     child: Container(
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
//                       decoration: BoxDecoration(
//                         color: Colors.black38,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: const Text(
//                         'Capture a Photo',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'SofiaSans',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       pickImageFromGallery();
//                     },
//                     child: Container(
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
//                       decoration: BoxDecoration(
//                         color: Colors.black38,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: const Text(
//                         'Select a photo',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'SofiaSans',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSoilAnalysisTab() {
//     // Implement your soil analysis UI here
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       child: Center(
//         child: Text(
//           'Soil Analysis Tab',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }

//   Future<void> loadModel() async {
//     try {
//       _interpreter = await tfl.Interpreter.fromAsset('assets/model_unquant.tflite');
//     } catch (e) {
//       debugPrint('Error loading model: $e');
//     }
//   }

//   Future<void> pickImageFromCamera() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       _setImage(File(pickedFile.path));
//     }
//   }

//   Future<void> pickImageFromGallery() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       _setImage(File(pickedFile.path));
//     }
//   }

//   void _setImage(File image) {
//     setState(() {
//       _image = image;
//     });
//     runInference();
//   }

//   Future<Uint8List> preprocessImage(File imageFile) async {
//     img.Image? originalImage = img.decodeImage(await imageFile.readAsBytes());
//     Uint8List bytes1 = originalImage!.getBytes();
//     img.Image resizedImage = img.copyResize(originalImage!, width: 224, height: 224);
//     Uint8List bytes = resizedImage.getBytes();
//     return bytes;
//   }

//   Future<void> runInference() async {
//     if (_labels == null) {
//       return;
//     }

//     try {
//       Uint8List inputBytes = await preprocessImage(_image);
//       var input = inputBytes.buffer.asUint8List().reshape([1, 224, 224, 3]);
//       var outputBuffer = List<double>.filled(1 * 15, 0).reshape([1, 15]);

//       _interpreter.run(input, outputBuffer);

//       List<double> output = outputBuffer[0];
//       double maxScore = output.reduce(max);
//       _probability = (maxScore / 1.0); 
//       int highestProbIndex = output.indexOf(maxScore);
//       String classificationResult = _labels![highestProbIndex];

//       setState(() {
//         _result = classificationResult;
//       });

//       navigateToResult();
//     } catch (e) {
//       debugPrint('Error during inference: $e');
//     }
//   }

//   Future<List<String>> loadLabels() async {
//     final labelsData = await DefaultAssetBundle.of(context).loadString('assets/labels.txt');
//     return labelsData.split('\n');
//   }

//   void navigateToResult() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ResultPage(
//           image: _image,
//           result: _result!,
//           probability: _probability,
//         ),
//       ),
//     );
//   }
// }

//It works half
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image/image.dart' as img;
// import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

// class PlantDiseaseDetectionScreen extends StatefulWidget {
//   const PlantDiseaseDetectionScreen({Key? key}) : super(key: key);

//   @override
//   _PlantDiseaseDetectionScreenState createState() =>
//       _PlantDiseaseDetectionScreenState();
// }

// class _PlantDiseaseDetectionScreenState
//     extends State<PlantDiseaseDetectionScreen> {
//   late File _image;
//   dynamic _probability = 0;
//   String? _result;
//   List<String>? _labels;
//   late tfl.Interpreter _interpreter;
//   final picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     loadModel().then((_) {
//       loadLabels().then((loadedLabels) {
//         setState(() {
//           _labels = loadedLabels;
//         });
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _interpreter.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueAccent,
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               const SizedBox(height: 80),
//               const Text(
//                 'Plant Disease Detection App',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   height: 1.4,
//                   fontFamily: 'SofiaSans',
//                   fontSize: 30,
//                 ),
//               ),
//               const SizedBox(height: 50),
//               Center(
//                 child: SizedBox(
//                   width: 350,
//                   child: Column(
//                     children: <Widget>[
//                       Image.asset('assets/plant.png'),
//                       const SizedBox(height: 50),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           pickImageFromCamera();
//                         },
//                         child: Container(
//                           alignment: Alignment.center,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 10,
//                             vertical: 18,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.black38,
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                           child: const Text(
//                             'Capture a Photo',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'SofiaSans',
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 20),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           pickImageFromGallery();
//                         },
//                         child: Container(
//                           alignment: Alignment.center,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 10,
//                             vertical: 18,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.black38,
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                           child: const Text(
//                             'Select a photo',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'SofiaSans',
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20), // Add some space at the bottom
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> loadModel() async {
//     try {
//       _interpreter =
//           await tfl.Interpreter.fromAsset('assets/model_unquant.tflite');
//     } catch (e) {
//       debugPrint('Error loading model: $e');
//     }
//   }

//   Future<void> pickImageFromCamera() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       _setImage(File(pickedFile.path));
//     }
//   }

//   Future<void> pickImageFromGallery() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       _setImage(File(pickedFile.path));
//     }
//   }

//   void _setImage(File image) {
//     setState(() {
//       _image = image;
//     });
//     runInference();
//   }
// Future<Uint8List> preprocessImage(File imageFile) async {
//     // Decode the image to an Image object
//     img.Image? originalImage = img.decodeImage(await imageFile.readAsBytes());

//     // Resize the image to the correct size
//     img.Image resizedImage =
//         img.copyResize(originalImage!, width: 224, height: 224);

//     // Convert to a byte buffer in the format suitable for TensorFlow Lite (RGB)
//     // The model expects a 4D tensor [1, 224, 224, 3]
//     // Flatten the resized image to match this shape
//     Uint8List bytes = resizedImage.getBytes();
//     return bytes;
//   }



//   Future<void> runInference() async {
//     if (_labels == null) {
//       return;
//     }

//     try {
//       Uint8List inputBytes = await preprocessImage(_image);
//       var input = inputBytes.buffer.asUint8List().reshape([1, 56, 56, 64]);
//       var outputBuffer = List<int>.filled(1 * 2, 0).reshape([1, 2]);

//       _interpreter.run(input, outputBuffer);

//       // Assuming output is now List<List<int>> after inference
//       List<int> output = outputBuffer[0];

//       // Print raw output for debugging
//       debugPrint('Raw output: $output');

//       // Calculate probability
//       int maxScore = output.reduce(max);
//       _probability = (maxScore / 255.0); // Convert to percentage

//       // Get the classification result
//       int highestProbIndex = output.indexOf(maxScore);
//       String classificationResult = _labels![highestProbIndex];

//       setState(() {
//         _result = classificationResult;
//         // _probability is updated with the calculated probability
//       });

//       navigateToResult();
//     } catch (e) {
//       debugPrint('Error during inference: $e');
//     }
//   }


//   Future<List<String>> loadLabels() async {
//     final labelsData =
//         await DefaultAssetBundle.of(context).loadString('assets/labels.txt');
//     return labelsData.split('\n');
//   }

//   void navigateToResult() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ResultPage(
//           image: _image,
//           result: _result!,
//           probability: _probability,
//         ),
//       ),
//     );
//   }
// }

// class ResultPage extends StatelessWidget {
//   final File image;
//   final String result;
//   final dynamic probability;

//   const ResultPage({
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
//             fontWeight: FontWeight.bold,
//             height: 1.4,
//             fontFamily: 'SofiaSans',
//             fontSize: 30,
//           ),
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
//                 width: 300.0,
//                 height: 300.0,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.blueGrey,
//                     width: 2.0,
//                   ),
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12.0),
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
//                 fontSize: 28,
//                 fontFamily: 'SofiaSans',
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               'Probability: ${(probability * 100).toStringAsFixed(2)}%',
//               style: const TextStyle(fontSize: 20),
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
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 18,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.blueGrey,
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: const Text(
//                   'Back to Home',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'SofiaSans',
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:image/image.dart' as img;

// void main() {
//   runApp(MaterialApp(
//     home: PlantDiseaseDetectionScreen(),
//   ));
// }

// class PlantDiseaseDetectionScreen extends StatefulWidget {
//   @override
//   _PlantDiseaseDetectionScreenState createState() =>
//       _PlantDiseaseDetectionScreenState();
// }

// class _PlantDiseaseDetectionScreenState
//     extends State<PlantDiseaseDetectionScreen> {
//   File? _imageFile;
//   bool _processing = false;
//   String _diseaseResult = '';
//   Interpreter? _interpreter;

//   @override
//   void initState() {
//     super.initState();
//     // Load the TensorFlow Lite model when the screen initializes
//     _loadModel();
//   }

//   void _loadModel() async {
//     try {
//       // Load the TensorFlow Lite model for plant disease detection
//       final interpreterOptions = InterpreterOptions()..threads = 1;
//       _interpreter = await Interpreter.fromAsset(
//         'assets/model_unquant.tflite',
//         options: interpreterOptions,
//       );

//       // Check if interpreter is initialized
//       assert(_interpreter != null, 'Failed to load TensorFlow Lite model.');

//       print('TensorFlow Lite model loaded successfully.');
//     } catch (e) {
//       print('Error loading TensorFlow Lite model: $e');
//     }
//   }

//   void _pickImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       setState(() {
//         _imageFile = File(pickedImage.path);
//       });
//     }
//   }

//   void _detectDisease() async {
//     try {
//       setState(() {
//         _processing = true;
//       });

//       // Perform inference on the selected image
//       final imgBytes = _imageFile!.readAsBytesSync();
//       var input = img.decodeImage(imgBytes)!;

//       // Resize the image to match the input dimensions expected by the model
//       input = img.copyResize(input, width: 224, height: 224);

//       // Ensure the image has three channels (RGB)
//       if (input.channels != 3) {
//         input = img.grayscale(input); // Convert to grayscale if not already
//         input = discardAlphaChannel(input); // Discard alpha channel if it exists
//       }

//       // Debug: Print the dimensions of the resized image
//       print('Resized image dimensions: ${input.width}x${input.height}');

//       // Convert the resized image to bytes and buffer
//       final inputBytes = input.getBytes();
//       final inputBuffer = inputBytes.buffer.asUint8List();

//       // Reshape the input buffer to match the expected shape [1, 224, 224, 3]
//       final inputShape = [1, 224, 224, 3];
//       final reshapedInputBuffer = inputBuffer.reshape(inputShape);

//       // Debug: Print the input buffer shape
//       print('Input buffer shape: ${reshapedInputBuffer.shape}');
//       print('Input buffer length: ${reshapedInputBuffer.length}');

//       // Check if the interpreter object is null
//       if (_interpreter == null) {
//         print('Error: TensorFlow Lite interpreter is null.');
//         return;
//       }

//       // Perform inference and update the result
//       final output = List<double>.filled(15, 0); // Update the size to match the number of labels

//       // Debug: Print message before running inference
//       print('Running inference...');

//       _interpreter!.run(reshapedInputBuffer, output);

//       // Debug: Print message after running inference
//       print('Inference completed successfully.');

//       // Process the output and display the result
//       final diseaseIndex =
//           output.indexOf(output.reduce((a, b) => a > b ? a : b));
//       final diseaseLabels = [
//         'Pepper Bell Bacterial Spot',
//         'Pepper Bell Healthy',
//         'Potato Early Blight',
//         'Potato Healthy',
//         'Potato Late Blight',
//         'Tomato Bacterial Spot',
//         'Tomato Early Blight',
//         'Tomato Healthy',
//         'Tomato Late Blight',
//         'Tomato Leaf Mold',
//         'Tomato Septoria Leaf Spot',
//         'Tomato Spotted Spider Mites',
//         'Tomato Target Spot',
//         'Tomato Mosaic Virus',
//         'Tomato Yellow Leaf Curl Virus',
//       ];

//       setState(() {
//         _diseaseResult = diseaseLabels[diseaseIndex];
//         _processing = false;
//       });
//     } catch (e) {
//       print('Error detecting disease: $e');
//       setState(() {
//         _processing = false;
//       });
//     }
//   }

//   img.Image discardAlphaChannel(img.Image image) {
//     // Create a new image without the alpha channel
//     final newImage = img.Image(image.width, image.height);

//     for (int y = 0; y < image.height; y++) {
//       for (int x = 0; x < image.width; x++) {
//         final pixel = image.getPixel(x, y);
//         final rgbPixel = img.getRed(pixel) << 16 | img.getGreen(pixel) << 8 | img.getBlue(pixel);
//         newImage.setPixel(x, y, rgbPixel);
//       }
//     }

//     return newImage;
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Plant Disease Detection'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _imageFile != null
//                 ? Image.file(
//                     _imageFile!,
//                     height: 200,
//                   )
//                 : Icon(
//                     Icons.image,
//                     size: 100,
//                   ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Select Image'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _detectDisease,
//               child: _processing
//                   ? CircularProgressIndicator()
//                   : Text('Detect Disease'),
//             ),
//             SizedBox(height: 20),
//             _diseaseResult.isNotEmpty
//                 ? Column(
//                     children: [
//                       Text(
//                         'Detected Disease:',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 10),
//                       Text(_diseaseResult),
//                     ],
//                   )
//                 : SizedBox(),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Dispose of the TensorFlow Lite interpreter when the screen is disposed
//     _interpreter?.close();
//     super.dispose();
//   }
// }


// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:image/image.dart' as img;

// void main() {
//   runApp(MaterialApp(
//     home: PlantDiseaseDetectionScreen(),
//   ));
// }

// class PlantDiseaseDetectionScreen extends StatefulWidget {
//   @override
//   _PlantDiseaseDetectionScreenState createState() =>
//       _PlantDiseaseDetectionScreenState();
// }

// class _PlantDiseaseDetectionScreenState
//     extends State<PlantDiseaseDetectionScreen> {
//   File? _imageFile;
//   bool _processing = false;
//   String _diseaseResult = '';
//   Interpreter? _interpreter;

//   @override
//   void initState() {
//     super.initState();
//     // Load the TensorFlow Lite model when the screen initializes
//     _loadModel();
//   }

//   void _loadModel() async {
//     try {
//       // Load the TensorFlow Lite model for plant disease detection
//       final interpreterOptions = InterpreterOptions()..threads = 1;
//       _interpreter = await Interpreter.fromAsset(
//         'assets/model_unquant.tflite',
//         options: interpreterOptions,
//       );

//       // Check if interpreter is initialized
//       assert(_interpreter != null, 'Failed to load TensorFlow Lite model.');

//       print('TensorFlow Lite model loaded successfully.');
//     } catch (e) {
//       print('Error loading TensorFlow Lite model: $e');
//     }
//   }

//   void _pickImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       setState(() {
//         _imageFile = File(pickedImage.path);
//       });
//     }
//   }
// void _detectDisease() async {
//   try {
//     setState(() {
//       _processing = true;
//     });

//     // Perform inference on the selected image
//     final imgBytes = _imageFile!.readAsBytesSync();
//     var input = img.decodeImage(imgBytes)!;

//     // Resize the image to match the input dimensions expected by the model
//     input = img.copyResize(input, width: 224, height: 224);

//     // Convert the resized image to bytes and buffer
//     final inputBytes = input.getBytes();
//     final inputBuffer = Float32List(224 * 224 * 3); // Create input buffer

//     // Normalize and fill the input buffer
//     for (var i = 0; i < inputBytes.length; i++) {
//       inputBuffer[i] = inputBytes[i] / 255.0;
//     }

//     // Check if the interpreter object is null
//     if (_interpreter == null) {
//       print('Error: TensorFlow Lite interpreter is null.');
//       return;
//     }

//     // Get the output tensor size from the model
//     final outputTensor = _interpreter!.getOutputTensor(0);
//     final outputSize = outputTensor.shape.reduce((a, b) => a * b);

//     // Perform inference and update the result
//     final output = Float32List(outputSize);

//     _interpreter!.run(inputBuffer.buffer, output.buffer);

//     // Process the output and display the result
//     final diseaseLabels = [
//       'Pepper Bell Bacterial Spot',
//       'Pepper Bell Healthy',
//       'Potato Early Blight',
//       'Potato Healthy',
//       'Potato Late Blight',
//       'Tomato Bacterial Spot',
//       'Tomato Early Blight',
//       'Tomato Healthy',
//       'Tomato Late Blight',
//       'Tomato Leaf Mold',
//       'Tomato Septoria Leaf Spot',
//       'Tomato Spotted Spider Mites',
//       'Tomato Target Spot',
//       'Tomato Mosaic Virus',
//       'Tomato Yellow Leaf Curl Virus',
//     ];

//     // Find the index of the maximum value in the output array
//     int diseaseIndex = 0;
//     double maxConfidence = output[0];
//     for (int i = 1; i < output.length; i++) {
//       if (output[i] > maxConfidence) {
//         maxConfidence = output[i];
//         diseaseIndex = i;
//       }
//     }

//     setState(() {
//       _diseaseResult = diseaseLabels[diseaseIndex];
//       _processing = false;
//     });
//   } catch (e) {
//     print('Error detecting disease: $e');
//     setState(() {
//       _processing = false;
//     });
//   }
// }




//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Plant Disease Detection'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _imageFile != null
//                 ? Image.file(
//                     _imageFile!,
//                     height: 200,
//                   )
//                 : Icon(
//                     Icons.image,
//                     size: 100,
//                   ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Select Image'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _detectDisease,
//               child: _processing
//                   ? CircularProgressIndicator()
//                   : Text('Detect Disease'),
//             ),
//             SizedBox(height: 20),
//             _diseaseResult.isNotEmpty
//                 ? Column(
//                     children: [
//                       Text(
//                         'Detected Disease:',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 10),
//                       Text(_diseaseResult),
//                     ],
//                   )
//                 : SizedBox(),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Dispose of the TensorFlow Lite interpreter when the screen is disposed
//     _interpreter?.close();
//     super.dispose();
//   }
// }
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:image/image.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';

// class PlantDiseaseDetectionScreen extends StatefulWidget {
//   @override
//   _PlantDiseaseDetectionScreenState createState() =>
//       _PlantDiseaseDetectionScreenState();
// }

// class _PlantDiseaseDetectionScreenState
//     extends State<PlantDiseaseDetectionScreen> {
//   Interpreter? _interpreter;
//   List<String> _labels = [];
//   bool _isModelLoaded = false;
//   List<double> _outputBuffer = [];

//   @override
//   void initState() {
//     super.initState();
//     loadModel();
//   }

//   Future<void> loadModel() async {
//     try {
//       _interpreter =
//           await Interpreter.fromAsset('assets/model_unquant.tflite');
//       _labels = await File('assets/labels.txt').readAsLines();
//       setState(() {
//         _isModelLoaded = true;
//       });
//     } catch (e) {
//       print('Error loading model: $e');
//       setState(() {
//         _isModelLoaded = true; // Set to true to avoid loader blocking UI
//       });
//     }
//   }

//   Future<void> performInference(File imageFile) async {
//     if (_interpreter == null || !_isModelLoaded) return;

//     try {
//       // Preprocess the image
//       var input = await preprocessImage(imageFile);

//       // Perform inference
//       _interpreter!.run(input, _outputBuffer);

//       // Process output
//       var result = processOutput(_outputBuffer);

//       // Update UI or take further actions based on result
//       print(result);
//     } catch (e) {
//       print('Error performing inference: $e');
//     }
//   }

//   Future<List<List<double>>> preprocessImage(File imageFile) async {
//     // Read the image file as bytes
//     List<int> imageBytes = await imageFile.readAsBytes();

//     // Use the image package for resizing and normalizing the image
//     var image = decodeImage(Uint8List.fromList(imageBytes));
//     var resizedImage = copyResize(image!, width: 224, height: 224);

//     // Normalize pixel values to be between 0 and 1
//     List<List<double>> input = [];

//     // Convert the resized image to a list of doubles
//     for (var y = 0; y < resizedImage.height; y++) {
//       List<double> row = [];
//       for (var x = 0; x < resizedImage.width; x++) {
//         var pixel = resizedImage.getPixel(x, y);
//         row.add((pixel & 0xFF) / 255); // Red channel
//         row.add(((pixel >> 8) & 0xFF) / 255); // Green channel
//         row.add(((pixel >> 16) & 0xFF) / 255); // Blue channel
//       }
//       input.add(row);
//     }

//     return input;
//   }

//   dynamic processOutput(List<double> output) {
//     // Placeholder method for processing the output
//     // You can process the output according to your model's output format
//     // For example, finding the index of the maximum value in the output buffer
//     // and using it to retrieve the corresponding label from _labels

//     // For simplicity, let's return the output buffer as is for now
//     return output;
//   }

//   @override
//   void dispose() {
//     _interpreter?.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Plant Disease Detection'),
//       ),
//       body: _isModelLoaded
//           ? Center(
//               child: ElevatedButton(
//                 onPressed: () async {
//                   // Select an image from gallery
//                   final imageFile =
//                       await ImagePicker().pickImage(source: ImageSource.gallery);
//                   if (imageFile != null) {
//                     // Trigger inference with the selected image
//                     performInference(File(imageFile.path));
//                   }
//                 },
//                 child: Text('Select Image'),
//               ),
//             )
//           : Center(
//               child: CircularProgressIndicator(),
//             ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';

// class PlantDiseaseDetectionScreen extends StatefulWidget {
//   @override
//   _PlantDiseaseDetectionScreenState createState() =>
//       _PlantDiseaseDetectionScreenState();
// }

// class _PlantDiseaseDetectionScreenState
//     extends State<PlantDiseaseDetectionScreen> {
//   late File _image = File(''); // Initialize with a default empty file
//   List _output = []; // Initialize _output as an empty list
//   bool _loading = false;
//   late Interpreter _interpreter;

//   @override
//   void initState() {
//     super.initState();
//     _loading = true;
//     _initModel().then((_) {
//       setState(() {
//         _loading = false;
//       });
//     });
//   }

//   Future<void> _initModel() async {
//     try {
//       // Load the model
//       _interpreter = await Interpreter.fromAsset(
//         'assets/model_unquant.tflite',
//       );

//       // Allocate memory for the model
//       _interpreter.allocateTensors();
//     } on Exception catch (e) {
//       print("Failed to load model: $e");
//     }
//   }

//   Future<void> _classifyImage(File image) async {
//     try {
//       // Preprocess the image
//       // Run inference on the image
//       // Process the output
//       setState(() {
//         _loading = false;
//       });
//     } on Exception catch (e) {
//       print("Failed to classify image: $e");
//     }
//   }

//   Future<void> _getImage(ImageSource source) async {
//     final pickedFile = await ImagePicker().pickImage(
//       source: source,
//       imageQuality: 50,
//     );

//     if (pickedFile != null) {
//       setState(() {
//         _loading = true;
//         _image = File(pickedFile.path);
//       });

//       await _classifyImage(_image);
//     }
//   }

//   @override
//   void dispose() {
//     _interpreter.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Plant Disease Detection'),
//       ),
//       body: _loading
//           ? Center(child: CircularProgressIndicator())
//           : _image.path.isEmpty // Check if _image is empty
//               ? Center(child: Text('No image selected.'))
//               : Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(height: 20),
//                     Expanded(
//                       child: Hero(
//                         tag: 'image_hero', // Unique tag for the image
//                         child: Image.file(_image),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     _output.isNotEmpty
//                         ? Expanded(
//                             child: Column(
//                               children: [
//                                 Hero(
//                                   tag: 'result_hero', // Unique tag for the result
//                                   child: Text(
//                                     "Result: ${_output[0]["label"]}",
//                                     style: TextStyle(fontSize: 20),
//                                   ),
//                                 ),
//                                 SizedBox(height: 10),
//                                 Text(
//                                   "Confidence: ${(_output[0]["confidence"] * 100).toStringAsFixed(2)}%",
//                                   style: TextStyle(fontSize: 20),
//                                 ),
//                               ],
//                             ),
//                           )
//                         : Container(),
//                   ],
//                 ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _getImage(ImageSource.gallery);
//         },
//         tooltip: 'Pick Image',
//         child: Icon(Icons.image),
//       ),
//     );
//   }
// }



// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:image/image.dart' as img;

// void main() {
//   runApp(MaterialApp(
//     home: PlantDiseaseDetectionScreen(),
//   ));
// }

// class PlantDiseaseDetectionScreen extends StatefulWidget {
//   @override
//   _PlantDiseaseDetectionScreenState createState() =>
//       _PlantDiseaseDetectionScreenState();
// }

// class _PlantDiseaseDetectionScreenState
//     extends State<PlantDiseaseDetectionScreen> {
//   File? _imageFile;
//   bool _processing = false;
//   String _diseaseResult = '';
//   Interpreter? _interpreter;

//   @override
//   void initState() {
//     super.initState();
//     // Load the TensorFlow Lite model when the screen initializes
//     _loadModel();
//   }

//   void _loadModel() async {
//     try {
//       // Load the TensorFlow Lite model for plant disease detection
//       final interpreterOptions = InterpreterOptions()..threads = 1;
//       _interpreter = await Interpreter.fromAsset(
//         'assets/model_unquant.tflite',
//         options: interpreterOptions,
//       );

//       // Check if interpreter is initialized
//       assert(_interpreter != null, 'Failed to load TensorFlow Lite model.');

//       print('TensorFlow Lite model loaded successfully.');
//     } catch (e) {
//       print('Error loading TensorFlow Lite model: $e');
//     }
//   }

//   void _pickImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       setState(() {
//         _imageFile = File(pickedImage.path);
//       });
//     }
//   }

//   void _detectDisease() async {
//     try {
//       setState(() {
//         _processing = true;
//       });

//       // Perform inference on the selected image
//       final imgBytes = _imageFile!.readAsBytesSync();
//       var input = img.decodeImage(imgBytes)!;

//       // Resize the image to match the input dimensions expected by the model
//       input = img.copyResize(input, width: 224, height: 224);

//       // Ensure the image has three channels (RGB)
//       if (input.channels != 3) {
//         input = img.grayscale(input); // Convert to grayscale if not already
//         input = expandChannels(input); // Expand channels to 3
//       }

//       // Debug: Print the dimensions of the resized image
//       print('Resized image dimensions: ${input.width}x${input.height}');

//       // Convert the resized image to bytes and buffer
//       final inputBytes = input.getBytes();
//       final inputBuffer = inputBytes.buffer.asUint8List();

//       // Reshape the input buffer to match the expected shape [1, 224, 224, 3]
//       final inputShape = [1, 224, 224, 4];
//       final reshapedInputBuffer = inputBuffer.reshape(inputShape);

//       // Debug: Print the input buffer shape
//       print('Input buffer shape: ${reshapedInputBuffer.shape}');
//       print('Input buffer length: ${reshapedInputBuffer.length}');

//       // Check if the interpreter object is null
//       if (_interpreter == null) {
//         print('Error: TensorFlow Lite interpreter is null.');
//         return;
//       }

//       // Perform inference and update the result
//       final output = List<double>.filled(15, 0); // Update the size to match the number of labels

//       // Debug: Print message before running inference
//       print('Running inference...');

//       _interpreter!.run(reshapedInputBuffer, output);

//       // Debug: Print message after running inference
//       print('Inference completed successfully.');

//       // Process the output and display the result
//       final diseaseIndex =
//           output.indexOf(output.reduce((a, b) => a > b ? a : b));
//       final diseaseLabels = [
//         'Pepper Bell Bacterial Spot',
//         'Pepper Bell Healthy',
//         'Potato Early Blight',
//         'Potato Healthy',
//         'Potato Late Blight',
//         'Tomato Bacterial Spot',
//         'Tomato Early Blight',
//         'Tomato Healthy',
//         'Tomato Late Blight',
//         'Tomato Leaf Mold',
//         'Tomato Septoria Leaf Spot',
//         'Tomato Spotted Spider Mites',
//         'Tomato Target Spot',
//         'Tomato Mosaic Virus',
//         'Tomato Yellow Leaf Curl Virus',
//       ];

//       setState(() {
//         _diseaseResult = diseaseLabels[diseaseIndex];
//         _processing = false;
//       });
//     } catch (e) {
//       print('Error detecting diseasee: $e');
//       setState(() {
//         _processing = false;
//       });
//     }
//   }

//   img.Image expandChannels(img.Image image) {
//     // Create a new image with three channels (RGB)
//     final newImage = img.Image(image.width, image.height);

//     // Copy the RGB channels from the original image to the new image
//     for (int y = 0; y < image.height; y++) {
//       for (int x = 0; x < image.width; x++) {
//         final pixel = image.getPixel(x, y);
//         final r = img.getRed(pixel);
//         final g = img.getGreen(pixel);
//         final b = img.getBlue(pixel);
        
//         // Set the pixel value in the new image with RGB channels
//         newImage.setPixel(x, y, img.getColor(r, g, b));
//       }
//     }

//     return newImage;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Plant Disease Detection'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _imageFile != null
//                 ? Image.file(
//                     _imageFile!,
//                     height: 200,
//                   )
//                 : Icon(
//                     Icons.image,
//                     size: 100,
//                   ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Select Image'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _detectDisease,
//               child: _processing
//                   ? CircularProgressIndicator()
//                   : Text('Detect Disease'),
//             ),
//             SizedBox(height: 20),
//             _diseaseResult.isNotEmpty
//                 ? Column(
//                     children: [
//                       Text(
//                         'Detected Disease:',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 10),
//                       Text(_diseaseResult),
//                     ],
//                   )
//                 : SizedBox(),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Dispose of the TensorFlow Lite interpreter when the screen is disposed
//     _interpreter?.close();
//     super.dispose();
//   }
// }



// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:image/image.dart' as img;

// void main() {
//   runApp(MaterialApp(
//     home: PlantDiseaseDetectionScreen(),
//   ));
// }

// class PlantDiseaseDetectionScreen extends StatefulWidget {
//   @override
//   _PlantDiseaseDetectionScreenState createState() =>
//       _PlantDiseaseDetectionScreenState();
// }

// class _PlantDiseaseDetectionScreenState
//     extends State<PlantDiseaseDetectionScreen> {
//   File? _imageFile;
//   bool _processing = false;
//   String _diseaseResult = '';
//   Interpreter? _interpreter;

//   @override
//   void initState() {
//     super.initState();
//     // Load the TensorFlow Lite model when the screen initializes
//     _loadModel();
//   }

//   void _loadModel() async {
//     try {
//       // Load the TensorFlow Lite model for plant disease detection
//       final interpreterOptions = InterpreterOptions()..threads = 1;
//       _interpreter = await Interpreter.fromAsset(
//         'assets/model_unquant.tflite',
//         options: interpreterOptions,
//       );

//       // Check if interpreter is initialized
//       assert(_interpreter != null, 'Failed to load TensorFlow Lite model.');

//       print('TensorFlow Lite model loaded successfully.');
//     } catch (e) {
//       print('Error loading TensorFlow Lite model: $e');
//     }
//   }

//   void _pickImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       setState(() {
//         _imageFile = File(pickedImage.path);
//       });
//     }
//   }

//   void _detectDisease() async {
//     try {
//       setState(() {
//         _processing = true;
//       });

//       // Perform inference on the selected image
//       final imgBytes = _imageFile!.readAsBytesSync();
//       var input = img.decodeImage(imgBytes)!;

//       // Resize the image to match the input dimensions expected by the model
//       input = img.copyResize(input, width: 224, height: 224);

//       // Ensure the image has three channels (RGB)
//       if (input.channels != 3) {
//         input = img.grayscale(input); // Convert to grayscale if not already
//         input = expandChannels(input); // Expand channels to 3
//       }

//       // Debug: Print the dimensions of the resized image
//       print('Resized image dimensions: ${input.width}x${input.height}');

//       // Convert the resized image to bytes and buffer
//       final inputBytes = input.getBytes();
//       final inputBuffer = inputBytes.buffer.asUint8List();

//       // Reshape the input buffer to match the expected shape [1, 224, 224, 3]
//       final inputShape = [1, 224, 224, 3];
//       final reshapedInputBuffer = inputBuffer.reshape(inputShape);

//       // Debug: Print the input buffer shape
//       print('Input buffer shape: ${reshapedInputBuffer.shape}');
//       print('Input buffer length: ${reshapedInputBuffer.length}');

//       // Check if the interpreter object is null
//       if (_interpreter == null) {
//         print('Error: TensorFlow Lite interpreter is null.');
//         return;
//       }

//       // Perform inference and update the result
//       final output = List<double>.filled(15, 0); // Update the size to match the number of labels

//       // Debug: Print message before running inference
//       print('Running inference...');

//       _interpreter!.run(reshapedInputBuffer, output);

//       // Debug: Print message after running inference
//       print('Inference completed successfully.');

//       // Process the output and display the result
//       final diseaseIndex =
//           output.indexOf(output.reduce((a, b) => a > b ? a : b));
//       final diseaseLabels = [
//         'Pepper Bell Bacterial Spot',
//         'Pepper Bell Healthy',
//         'Potato Early Blight',
//         'Potato Healthy',
//         'Potato Late Blight',
//         'Tomato Bacterial Spot',
//         'Tomato Early Blight',
//         'Tomato Healthy',
//         'Tomato Late Blight',
//         'Tomato Leaf Mold',
//         'Tomato Septoria Leaf Spot',
//         'Tomato Spotted Spider Mites',
//         'Tomato Target Spot',
//         'Tomato Mosaic Virus',
//         'Tomato Yellow Leaf Curl Virus',
//       ];

//       setState(() {
//         _diseaseResult = diseaseLabels[diseaseIndex];
//         _processing = false;
//       });
//     } catch (e) {
//       print('Error detecting disease: $e');
//       setState(() {
//         _processing = false;
//       });
//     }
//   }

//   img.Image expandChannels(img.Image image) {
//     // Create a new image with three channels (RGB)
//     final newImage = img.Image(image.width, image.height);

//     // Copy the grayscale image to all three channels
//     for (int y = 0; y < image.height; y++) {
//       for (int x = 0; x < image.width; x++) {
//         final pixel = image.getPixel(x, y);
//         newImage.setPixel(x, y, pixel);
//         newImage.setPixel(x, y, pixel);
//         newImage.setPixel(x, y, pixel);
//       }
//     }

//     return newImage;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Plant Disease Detection'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _imageFile != null
//                 ? Image.file(
//                     _imageFile!,
//                     height: 200,
//                   )
//                 : Icon(
//                     Icons.image,
//                     size: 100,
//                   ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Select Image'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _detectDisease,
//               child: _processing
//                   ? CircularProgressIndicator()
//                   : Text('Detect Disease'),
//             ),
//             SizedBox(height: 20),
//             _diseaseResult.isNotEmpty
//                 ? Column(
//                     children: [
//                       Text(
//                         'Detected Disease:',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 10),
//                       Text(_diseaseResult),
//                     ],
//                   )
//                 : SizedBox(),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Dispose of the TensorFlow Lite interpreter when the screen is disposed
//     _interpreter?.close();
//     super.dispose();
//   }
// }


// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:image/image.dart' as img;

// void main() {
//   runApp(MaterialApp(
//     home: PlantDiseaseDetectionScreen(),
//   ));
// }

// class PlantDiseaseDetectionScreen extends StatefulWidget {
//   @override
//   _PlantDiseaseDetectionScreenState createState() =>
//       _PlantDiseaseDetectionScreenState();
// }

// class _PlantDiseaseDetectionScreenState
//     extends State<PlantDiseaseDetectionScreen> {
//   File? _imageFile;
//   bool _processing = false;
//   String _diseaseResult = '';
//   Interpreter? _interpreter;

//   @override
//   void initState() {
//     super.initState();
//     // Load the TensorFlow Lite model when the screen initializes
//     _loadModel();
//   }

//   void _loadModel() async {
//     try {
//       // Load the TensorFlow Lite model for plant disease detection
//       final interpreterOptions = InterpreterOptions()..threads = 1;
//       _interpreter = await Interpreter.fromAsset(
//         'assets/model_unquant.tflite',
//         options: interpreterOptions,
//       );

//       // Check if interpreter is initialized
//       assert(_interpreter != null, 'Failed to load TensorFlow Lite model.');

//       print('TensorFlow Lite model loaded successfully.');
//     } catch (e) {
//       print('Error loading TensorFlow Lite model: $e');
//     }
//   }

//   void _pickImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       setState(() {
//         _imageFile = File(pickedImage.path);
//       });
//     }
//   }

//   void _detectDisease() async {
//     try {
//       setState(() {
//         _processing = true;
//       });

//       // Perform inference on the selected image
//       final imgBytes = _imageFile!.readAsBytesSync();
//       var input = img.decodeImage(imgBytes)!;

//       // Resize the image to match the input dimensions expected by the model
//       input = img.copyResize(input, width: 56, height: 56);

//       // Ensure the image has three channels (RGB)
//       if (input.channels != 3) {
//         input = img.grayscale(input); // Convert to grayscale if not already
//         input = _expandChannels(input); // Expand channels to 3
//       }

//       // Debug: Print the dimensions of the resized image
//       print('Resized image dimensions: ${input.width}x${input.height}');

//       // Convert the resized image to bytes and buffer
//       final inputBytes = input.getBytes();
//       final inputBuffer = inputBytes.buffer.asUint8List();

//       // Reshape the input buffer to match the expected shape [1, 224, 224, 3]
//       final inputShape = [1, 56, 56, 64];
//       final reshapedInputBuffer = inputBuffer.reshape(inputShape);

//       // Debug: Print the input buffer shape
//       print('Input buffer shape: ${reshapedInputBuffer.shape}');
//       print('Input buffer length: ${reshapedInputBuffer.length}');

//       // Check if the interpreter object is null
//       if (_interpreter == null) {
//         print('Error: TensorFlow Lite interpreter is null.');
//         return;
//       }

//       // Perform inference and update the result
//       final output = List<double>.filled(15, 0); // Update the size to match the number of labels

//       // Debug: Print message before running inference
//       print('Running inference...');

//       _interpreter!.run(reshapedInputBuffer, output);

//       // Debug: Print message after running inference
//       print('Inference completed successfully.');

//       // Process the output and display the result
//       final diseaseIndex =
//           output.indexOf(output.reduce((a, b) => a > b ? a : b));
//       final diseaseLabels = [
//         'Pepper Bell Bacterial Spot',
//         'Pepper Bell Healthy',
//         'Potato Early Blight',
//         'Potato Healthy',
//         'Potato Late Blight',
//         'Tomato Bacterial Spot',
//         'Tomato Early Blight',
//         'Tomato Healthy',
//         'Tomato Late Blight',
//         'Tomato Leaf Mold',
//         'Tomato Septoria Leaf Spot',
//         'Tomato Spotted Spider Mites',
//         'Tomato Target Spot',
//         'Tomato Mosaic Virus',
//         'Tomato Yellow Leaf Curl Virus',
//       ];

//       setState(() {
//         _diseaseResult = diseaseLabels[diseaseIndex];
//         _processing = false;
//       });
//     } catch (e) {
//       print('Error detecting disease: $e');
//       setState(() {
//         _processing = false;
//       });
//     }
//   }

//   img.Image _expandChannels(img.Image image) {
//   // Create a new image with three channels (RGB)
//   final newImage = img.Image(image.width, image.height);

//   // Copy the grayscale image to all three channels
//   for (int y = 0; y < image.height; y++) {
//     for (int x = 0; x < image.width; x++) {
//       final pixel = image.getPixel(x, y);
//       newImage.setPixel(x, y, pixel);
//       newImage.setPixel(x, y, pixel);
//       newImage.setPixel(x, y, pixel);
//     }
//   }

//   return newImage;
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Plant Disease Detection'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _imageFile != null
//                 ? Image.file(
//                     _imageFile!,
//                     height: 200,
//                   )
//                 : Icon(
//                     Icons.image,
//                     size: 100,
//                   ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Select Image'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _detectDisease,
//               child: _processing
//                   ? CircularProgressIndicator()
//                   : Text('Detect Disease'),
//             ),
//             SizedBox(height: 20),
//             _diseaseResult.isNotEmpty
//                 ? Column(
//                     children: [
//                       Text(
//                         'Detected Disease:',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 10),
//                       Text(_diseaseResult),
//                     ],
//                   )
//                 : SizedBox(),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Dispose of the TensorFlow Lite interpreter when the screen is disposed
//     _interpreter?.close();
//     super.dispose();
//   }
// }



// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:image/image.dart' as img;

// void main() {
//   runApp(MaterialApp(
//     home: PlantDiseaseDetectionScreen(),
//   ));
// }

// class PlantDiseaseDetectionScreen extends StatefulWidget {
//   @override
//   _PlantDiseaseDetectionScreenState createState() =>
//       _PlantDiseaseDetectionScreenState();
// }

// class _PlantDiseaseDetectionScreenState
//     extends State<PlantDiseaseDetectionScreen> {
//   File? _imageFile;
//   bool _processing = false;
//   String _diseaseResult = '';
//   Interpreter? _interpreter;

//   @override
//   void initState() {
//     super.initState();
//     // Load the TensorFlow Lite model when the screen initializes
//     _loadModel();
//   }

//   void _loadModel() async {
//   try {
//     // Load the TensorFlow Lite model for plant disease detection
//     final interpreterOptions = InterpreterOptions()..threads = 1;
//     _interpreter = await Interpreter.fromAsset(
//         'assets/model_unquant.tflite',
//         options: interpreterOptions);
    
//     // Check if interpreter is initialized
//     assert(_interpreter != null, 'Failed to load TensorFlow Lite model.');

//     print('TensorFlow Lite model loaded successfully.');
//   } catch (e) {
//     print('Error loading TensorFlow Lite model: $e');
//   }
// }



//   void _pickImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       setState(() {
//         _imageFile = File(pickedImage.path);
//       });
//     }
//   }

//   void _detectDisease() async {
//   try {
//     setState(() {
//       _processing = true;
//     });

//     // Perform inference on the selected image
//     final imgBytes = _imageFile!.readAsBytesSync();
//     var input = img.decodeImage(imgBytes)!;

//     // Resize the image to match the input dimensions expected by the model
//     input = img.copyResize(input, width: 224, height: 224);

//     // Debug: Print the dimensions of the resized image
//     print('Resized image dimensions: ${input.width}x${input.height}');

//     // Convert the resized image to bytes and buffer
//     final inputBytes = input.getBytes();
//     final inputBuffer = Uint8List.view(inputBytes.buffer);

//     // Debug: Print the input buffer size
//     print('Input buffer size: ${inputBuffer.length} bytes');

//     // Check if the interpreter object is null
//     if (_interpreter == null) {
//       print('Error: TensorFlow Lite interpreter is null.');
//       return;
//     }

//     // Perform inference and update the result
//     final output = List<double>.filled(15, 0); // Update the size to match the number of labels

//     // Debug: Print message before running inference
//     print('Running inference...');
//     print('Input buffer shape: ${inputBuffer.shape}');


//     _interpreter!.run(inputBuffer, output);

//     // Debug: Print message after running inference
//     print('Inference completed successfully.');

//     // Process the output and display the result
//     final diseaseIndex = output.indexOf(output.reduce((a, b) => a > b ? a : b));
//     final diseaseLabels = [
//       'Pepper Bell Bacterial Spot',
//       'Pepper Bell Healthy',
//       'Potato Early Blight',
//       'Potato Healthy',
//       'Potato Late Blight',
//       'Tomato Bacterial Spot',
//       'Tomato Early Blight',
//       'Tomato Healthy',
//       'Tomato Late Blight',
//       'Tomato Leaf Mold',
//       'Tomato Septoria Leaf Spot',
//       'Tomato Spotted Spider Mites',
//       'Tomato Target Spot',
//       'Tomato Mosaic Virus',
//       'Tomato Yellow Leaf Curl Virus',
//     ];
    
//     setState(() {
//       _diseaseResult = diseaseLabels[diseaseIndex];
//       _processing = false;
//     });
//   } catch (e) {
//     print('Error detecting disease: $e');
//     setState(() {
//       _processing = false;
//     });
//   }
// }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Plant Disease Detection'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _imageFile != null
//                 ? Image.file(
//                     _imageFile!,
//                     height: 200,
//                   )
//                 : Icon(
//                     Icons.image,
//                     size: 100,
//                   ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Select Image'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _detectDisease,
//               child: _processing
//                   ? CircularProgressIndicator()
//                   : Text('Detect Disease'),
//             ),
//             SizedBox(height: 20),
//             _diseaseResult.isNotEmpty
//                 ? Column(
//                     children: [
//                       Text(
//                         'Detected Disease:',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 10),
//                       Text(_diseaseResult),
//                     ],
//                   )
//                 : SizedBox(),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Dispose of the TensorFlow Lite interpreter when the screen is disposed
//     _interpreter?.close();
//     super.dispose();
//   }
// }

// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:image/image.dart' as img;
// // import 'package:helloworld/assets/model_unquant.tfile';

// void main() {
//   runApp(MaterialApp(
//     home: PlantDiseaseDetectionScreen(),
//   ));
// }

// class PlantDiseaseDetectionScreen extends StatefulWidget {
//   @override
//   _PlantDiseaseDetectionScreenState createState() =>
//       _PlantDiseaseDetectionScreenState();
// }

// class _PlantDiseaseDetectionScreenState
//     extends State<PlantDiseaseDetectionScreen> {
//   File? _imageFile;
//   bool _processing = false;
//   String _diseaseResult = '';
//   Interpreter? _interpreter;

//   @override
//   void initState() {
//     super.initState();
//     // Load the TensorFlow Lite model when the screen initializes
//     _loadModel();
//   }

//   void _loadModel() async {
//     // Load the TensorFlow Lite model for plant disease detection
//     final interpreterOptions = InterpreterOptions()..threads = 1;
//     _interpreter = await Interpreter.fromAsset(
//         'assets/model_unquant.tfile',
//         options: interpreterOptions);
//   }

//   void _pickImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       setState(() {
//         _imageFile = File(pickedImage.path);
//       });
//     }
//   }

//   void _detectDisease() async {
//     setState(() {
//       _processing = true;
//     });

//     // Perform inference on the selected image
//     final imgBytes = _imageFile!.readAsBytesSync();
//     var input = img.decodeImage(imgBytes)!;
//     input = img.copyResize(input, width: 224, height: 224);

//     final inputBytes = input.getBytes();
//     final inputBuffer = Uint8List.view(inputBytes.buffer);

//     final output = List<double>.filled(38, 0);

//     _interpreter!.run(inputBuffer, output);

//     final diseaseIndex = output.indexOf(output.reduce((a, b) => a > b ? a : b));

//     // Replace the result index with your actual labels
//     final diseaseLabels = [
//       'Apple___Apple_scab',
//       'Apple___Black_rot',
//       // Add more labels here
//     ];

//     setState(() {
//       _diseaseResult = diseaseLabels[diseaseIndex];
//       _processing = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Plant Disease Detection'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _imageFile != null
//                 ? Image.file(
//                     _imageFile!,
//                     height: 200,
//                   )
//                 : Icon(
//                     Icons.image,
//                     size: 100,
//                   ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Select Image'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _detectDisease,
//               child: _processing
//                   ? CircularProgressIndicator()
//                   : Text('Detect Disease'),
//             ),
//             SizedBox(height: 20),
//             _diseaseResult.isNotEmpty
//                 ? Column(
//                     children: [
//                       Text(
//                         'Detected Disease:',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 10),
//                       Text(_diseaseResult),
//                     ],
//                   )
//                 : SizedBox(),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Dispose of the TensorFlow Lite interpreter when the screen is disposed
//     _interpreter?.close();
//     super.dispose();
//   }
// }
    }