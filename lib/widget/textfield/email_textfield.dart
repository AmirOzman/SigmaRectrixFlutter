import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
    required TextEditingController email,
  })  : _email = email,
        super(key: key);

  final TextEditingController _email;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: const [AutofillHints.email],
      onChanged: (text) {},
      controller: _email,
      autofocus: true,
      validator: (_email) {
        if (_email!.isEmpty ||
            !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                    r"{0,253}[a-zA-Z0-9])?)*$")
                .hasMatch(_email)) {
          //  r'^[0-9]{10}$' pattern plain match number with length 10
          return "Please enter a valid email";
        } else {
          return null;
        }
      },
      // validator: (_email) => validateEmail(_email),
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          labelText: 'Email',
          hintText: 'email@gmail.com',
          prefixIcon: Align(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: Icon(Icons.mail),
          )),
    );
  }
}
