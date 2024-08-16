import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/splash.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  String _selectedGender = '';
  String _selectedState = ''; // Initialize with a default state
  late String _password;
  late String _confirmPassword;
  bool _obscureText = true;
  bool _obscureConfirmText = true;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _stateController;

  final List<String> _states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Daman & Diu',
    'Dadranagar & Haveli'
        'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal'
  ];

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _stateController = TextEditingController(text: _selectedState);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      String firstName = _firstNameController.text;
      String lastName = _lastNameController.text;
      String email = _emailController.text;
      print('First Name: $firstName');
      print('Last Name: $lastName');
      print('Email: $email');
      print('Gender: $_selectedGender');
      print('State: $_selectedState');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Form Data'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('First Name: $firstName'),
                Text('Last Name: $lastName'),
                Text('Email: $email'),
                Text('Gender: $_selectedGender'),
                Text('State: $_selectedState'),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Form Validation Failed'),
            content: Text('Please fix the errors in the form.'),
            actions: <Widget>[
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _firstNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    hintText: 'Enter Your First Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String value) {},
                  validator: (value) {
                    return value!.isEmpty ? 'Please Enter First Name' : null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _lastNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    hintText: 'Enter Your Last Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String value) {},
                  validator: (value) {
                    return value!.isEmpty ? 'Please Enter Your Last Name' : null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter Your Email',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email address';
                    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text('Gender: '),
                    Radio<String>(
                      value: 'Male',
                      groupValue: _selectedGender,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                    Text('Male'),
                    Radio<String>(
                      value: 'Female',
                      groupValue: _selectedGender,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                    Text('Female'),
                  ],
                ),
                SizedBox(height: 15),
                TypeAheadFormField<String>(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _stateController,
                    decoration: InputDecoration(
                      labelText: 'State',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search), // Add this line for the magnifying glass icon
                    ),
                  ),
                  suggestionsCallback: (pattern) {
                    return _states.where((state) =>
                        state.toLowerCase().contains(pattern.toLowerCase()));
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      _stateController.text = suggestion;
                      _selectedState = suggestion;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a state';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 15),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter Your Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: _obscureConfirmText,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Re-enter Your Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmText = !_obscureConfirmText;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm password';
                    }
                    if (value != _password) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _confirmPassword = value;
                    });
                  },
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: const Text(
                    'Already have an account? Click here to login.',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () => _submitForm(context),
                      child: const Text('Submit'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  late String _password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter Your Email',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email address';
                    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter Your Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ?Icons.visibility_off : Icons.visibility ,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () => _submitForm(context), // Pass the context here
                      child: const Text('Submit'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) { // Accept context as a parameter
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with your actions
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form submitted successfully'))
      );
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  get splash => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registration Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blue),
      ),
     home: Splash(),
     //  home: AnimatedSplashScreen(
     //  // splash: Icons.account_box_outlined,
     //  curve: Curves.easeInOutExpo,
     //  // duration: 3000,
     //  // nextScreen: MyHomePage(title: 'nnn',),
     //  // splashTransition: SplashTransition.fadeTransition,
     //  //   backgroundColor: Colors.black,
     //
     //    splash: Text('NehInfo', style: TextStyle(
     //        color: Colors.red,
     //        fontSize: 40,
     //      fontWeight: FontWeight.bold,
     //
     //    ),),
     //      nextScreen: MyHomePage(title: 'Registration Page',),
     // ),
    );
  }
}