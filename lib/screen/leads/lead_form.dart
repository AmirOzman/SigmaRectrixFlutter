// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:sigma_crm/model/model.dart';
import 'package:sigma_crm/widget/widget.dart';

class LeadForm extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  final String? leadname;
  final String? clientName;
  final double? rate;
  final String? desc;

  const LeadForm(
    this.client,
    this.session, {
    Key? key,
    this.leadname,
    this.clientName,
    this.rate,
    this.desc,
  }) : super(key: key);

  @override
  LeadFormState createState() => LeadFormState();
}

class LeadFormState extends State<LeadForm> {
  //below is variable for add new
  final newContact = TextEditingController();
  final newLeadName = TextEditingController();
  final newName = TextEditingController();
  final newCompanyName = TextEditingController();
  final newParentId = TextEditingController();
  final newCustomer = TextEditingController();
  final newStreet = TextEditingController();
  final newStreet2 = TextEditingController();
  final newState = TextEditingController();
  final newCity = TextEditingController();
  final newZip = TextEditingController();
  final taxIdNumber = TextEditingController();
  final newWebsite = TextEditingController();
  final newEmail = TextEditingController();
  final newJobPos = TextEditingController();
  final newPhone = TextEditingController();
  final newMobile = TextEditingController();

  //below is variable for others

  final customerName = TextEditingController();
  late TextEditingController leadname =
      TextEditingController(text: widget.leadname);

  final notes = TextEditingController();
  var companyName = '';
  var companyId = '';
  var street = '';
  var street2 = '';
  var state = '';
  var city = '';
  var zip = '';
  var website = '';
  var salesPerson = '';
  var emel = '';
  var jobPos = '';
  var phoneNum = '';
  var mobileNum = '';
  double rating = 0;
  ValueNotifier<bool> haveCompany = ValueNotifier(false);

  List companyNameList = [];
  List customerParentList = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchClientData();
    });
    super.initState();
  }

  //below is for optimization, so that we only call the code search_read once when upon page load.
  Future fetchClientData() async {
    // var fetchCustomerData;
    var fetchCustomerData = await widget.client.callKw({
      'model': 'res.partner',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context':
            {}, //because by default odoo fields.char return False when its null, therefore we change the default return '' rather than false
        'domain': [
          ['name', '!=', '']
        ],
        'fields': [
          'id',
          'email',
          'name',
          'street',
          'street2',
          'state_id',
          'city',
          'zip',
          'website',
          'email',
          'function',
          'phone',
          'mobile',
          'parent_id',
        ],
      },
    });
    if (mounted) {
      setState(() {
        companyNameList =
            fetchCustomerData; //test is a json data too //is equivalent to final List users = json.decode(response.body);
        //companyNameList = test.cast<String>();
      });
    }

    print(
        '\nUser info: \n$companyNameList'); //this is for testing only, delete later

    //below we set the domain to only is_company so that we can get company data only for parent_id of customer
    // var fetchCustomerParent;
    var fetchCustomerParent = await widget.client.callKw({
      'model': 'res.partner',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context':
            {}, //because by default odoo fields.char return False when its null, therefore we change the default return '' rather than false
        'domain': [
          ['is_company', '=', true]
          //['is_company.name',]
          // ['probability','<=',50]
        ],
        'fields': [
          'id',
          'name',
          'parent_id',
          'state_id',
        ],
      },
    });
    if (mounted) {
      setState(() {
        customerParentList =
            fetchCustomerParent; //test is a json data too //is equivalent to final List users = json.decode(response.body);
      });
      print('\nCustomer Parent info: \n$companyNameList');
    }
    // ignore: todo
    //TODO this is for testing only, delete later
    //print (test); //this is to check the info passed into the apps? i think.
    //
  }

  Future<List<GetCompany>> getCompanyName(String query) async {
    return companyNameList
        .map((json) => GetCompany.fromJson(json))
        .where((user) {
      final nameLower = user.name?.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower!.contains(queryLower);
    }).toList();
  }

  //below is for the use of typeahead field suggestion.
  //have to create a new one because we use a different domain to filter the data here.
  //parent company is fetched below, its functionality is to fetch parent_id of a new created customer,
  Future<List<GetCompany>> getCustomerParent(String query) async {
    return customerParentList
        .map((json) => GetCompany.fromJson(json))
        .where((user) {
      final nameLower = user.name?.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower!.contains(queryLower);
    }).toList();
  }

  // void addNewCompany(BuildContext context) {
  //   showBottomSheet(context: context, builder: (context) => Column());
  // }

  // Create new partner
  bool priceupdateValue = false;
  // final String _companyStatus = 'company';
  final maskZip =
      MaskTextInputFormatter(mask: "#####", filter: {"#": RegExp(r'[0-9]')});
  final maskPhone = MaskTextInputFormatter(
      mask: "##-#### ####", filter: {"#": RegExp(r'[0-9]')});
  final maskMobile = MaskTextInputFormatter(
      mask: "###-### ####", filter: {"#": RegExp(r'[0-9]')});
  Future addCompanyBottom() => showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // ignore: todo
                          //TODO radiobutton for selecting between company or individual
                          // ignore: todo
                          //TODO upload customer image feature
                          TextForm(
                            controller: newName,
                            label: "Customer Name",
                            kotak: true,
                          ),
                          const SpacingPixel(h: 20),
                          TextForm(
                            controller: newContact,
                            label: 'Contact',
                          ),
                          const SpacingPixel(h: 20),
                          TextForm(
                            controller: newStreet,
                            label: "Street Name 1",
                          ),
                          const SpacingPixel(h: 20),
                          TextForm(
                            controller: newStreet2,
                            label: "Street Name 2",
                          ),
                          const SpacingPixel(h: 20),
                          TextForm(
                            controller: newState,
                            label: "State",
                          ),
                          const SpacingPixel(h: 20),
                          TextForm(
                            controller: newCity,
                            label: "City",
                          ),
                          const SpacingPixel(h: 20),
                          TextForm(
                            controller: newZip,
                            label: "ZIP",
                            kb: TextInputType.number,
                            mask: maskZip,
                            maxLength: 5,
                          ),
                          const SpacingPixel(h: 15),
                          TextForm(
                            controller: taxIdNumber,
                            label: "Tax ID Number(TIN)",
                          ),
                          const SpacingPixel(h: 20),
                          TextForm(
                            controller: newJobPos,
                            label: "Job Position",
                          ),
                          const SpacingPixel(h: 20),
                          TextForm(
                            controller: newPhone,
                            label: "Office Telephone Number",
                            maxLength: 10,
                            mask: maskPhone,
                            kb: TextInputType.phone,
                          ),
                          const SpacingPixel(h: 20),
                          TextForm(
                            controller: newMobile,
                            label: "Phone Number",
                            maxLength: 10,
                            kb: TextInputType.phone,
                            mask: maskMobile,
                          ),
                          const SpacingPixel(h: 20),
                          TextForm(
                            controller: newEmail,
                            label: 'Email',
                          ),
                          const SpacingPixel(h: 20),
                          TextForm(
                            controller: newWebsite,
                            label: "Website",
                          ),
                          const SpacingPixel(h: 20),

                          //Visibility(visible:child: CustomTextFormField(controller: newJobPos, label: "Job Position")),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ButtonText(
                        lebar: 0.4,
                        nama: 'Submit',
                        warna: Colors.black,
                        onPressed: () {
                          widget.client.callKw(
                            {
                              'model': 'res.partner',
                              'method': 'create',
                              'args': [
                                {
                                  'name': newName.text, //partner name
                                  'street': newStreet.text,
                                  'street2': newStreet2.text,
                                  'city': newCity.text,
                                  'zip': newZip.text,
                                  'vat': taxIdNumber.text,
                                  // ignore: todo
                                  //TODO tags
                                  'function': newJobPos.text,
                                  'website': newWebsite.text,
                                  'email_from': newEmail.text,
                                  'mobile': newMobile.text,
                                  'phone': newPhone.text,
                                  'supplier': false,
                                  'customer': true,
                                  'employee': false,
                                  'country_id': 157, // country id for Malaysia
                                }
                              ],
                              'kwargs': {},
                            },
                          );
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'New Customer Profile Created',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    //String selectedValue = "not selected yet";

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBarCustom(
            client: widget.client,
            session: widget.session,
            tajuk: Text(
              'New Leads',
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.white),
            ),
            float: true,
            log: true,
            find: true),
        SliverList(
          delegate: SliverChildListDelegate([
            GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: SingleChildScrollView(
                  child: Stack(children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: screenSize.height * 0.025,
                    horizontal: screenSize.width * 0.1,
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //company name
                      Form(
                        child: Column(
                          children: [
                            TextForm(
                              focus: true,
                              controller: leadname,
                              label: "Lead Name",
                              //initialValue: widget.leadname,
                            ),
                            const SpacingPixel(
                              h: 20,
                            ),
                            //FIXMETextField Dropdown buttonf.
                            TypeAheadField<GetCompany?>(
                              textFieldConfiguration: TextFieldConfiguration(
                                // ignore: todo
                                //TODO logic for empty field and edit view for the field
                                controller: customerName,
                                decoration: const InputDecoration(
                                  labelText: 'Select a client',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),

                              //suggestionsBoxController: emel,
                              suggestionsCallback: getCompanyName,
                              itemBuilder: (context, GetCompany? suggestion) {
                                final user = suggestion?.name;

                                return ListTile(
                                  title: Text(
                                      // ignore: todo
                                      user!), //TODO here we can fill other data such as gambar etc.
                                );
                              },
                              noItemsFoundBuilder: (context) => const SizedBox(
                                height: 100,
                                child: Center(
                                  child: Text(
                                    'No Users Found.',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                              ),
                              onSuggestionSelected: (GetCompany? suggestion) {
                                final user = suggestion!;

                                customerName.text = user.name.toString();
                                if (mounted) {
                                  setState(() {
                                    companyName = user.name.toString();
                                    companyId = user.id.toString();
                                    street = user.street.toString();
                                    street2 = user.street2.toString();
                                    state = user.stateID.toString();
                                    city = user.city.toString();
                                    zip = user.zip.toString();
                                    website = user.website.toString();
                                    emel = user.email.toString();
                                    jobPos = user.function.toString();
                                    phoneNum = user.phone.toString();
                                    mobileNum = user.mobile.toString();
                                  });
                                }
                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(SnackBar(
                                    content: Text(
                                        // ignore: todo
                                        'Selected user: ${user.name} ${user.id} ${user.email}'), //TODO change Selected user to Selected company, change user (note: user with lower bracket) to company
                                  ));
                              },
                            ),
                            const SpacingAll(h: 0.02, w: 1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text: "Create ",
                                      style:
                                          const TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                            text: "new customer",
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                addCompanyBottom();
                                              },
                                            style: const TextStyle(
                                              color: Colors.blue,
                                            ),
                                            children: const [
                                              TextSpan(
                                                  text: " profile",
                                                  style: TextStyle(
                                                      color: Colors.black))
                                            ])
                                      ]),
                                ),
                              ],
                            ),
                            const SpacingAll(
                              h: 0.02,
                              w: 1,
                            ),
                            const Text(
                              'Priority Rating',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            RatingBar.builder(
                              initialRating: widget.rate ?? 0,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 3,
                              itemSize: 30,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 179, 12, 48),
                              ),
                              updateOnDrag: true,
                              onRatingUpdate: (rating) {
                                if (mounted) {
                                  setState(() {
                                    this.rating = rating;
                                  });
                                }
                                print(
                                    // ignore: todo
                                    rating); //TODO Remove this later, this is for testing only 10 march @hafizalwi
                              },
                            ),

                            const SpacingAll(h: 0.02, w: 1),

                            const Text('Tags'),

                            const SpacingAll(h: 0.01, w: 1),
                            TextForm(
                              max: 7,
                              label: 'Description',
                              controller: notes,
                              kb: TextInputType.multiline,
                              kotak: true,
                              // ignore: todo
                              //TODO check value passing kat description box
                              //initialValue:
                              //widget.desc == false || widget.desc == null
                              //    ? 'no description'
                              //    : widget.desc,
                            ),
                            const SpacingAll(h: 0.01, w: 1),
                          ],
                        ),
                      ),
                      const SpacingAll(h: 0.02, w: 1),

                      ButtonText(
                        nama: "Submit",
                        lebar: screenSize.width * 0.5,
                        onPressed: () async {
                          await widget.client.callKw({
                            'model': 'crm.lead',
                            'method': 'create',
                            'args': [
                              {
                                'partner_name': companyName,
                                'partner_id': companyId,
                                'name': leadname.text,
                                'street': 'test street',
                                'street2': street2,
                                'city': city,
                                'zip': zip,
                                'website': website,
                                'email_from': emel,
                                'function': jobPos,
                                'phone': phoneNum,
                                'mobile': mobileNum,
                                'description': notes.text,
                                'type': 'lead',

                                // 'salesperson': widget.session.userId,
                                //'priority':rating.toInt(),
                                //'priority': rating.toString(),
                                'priority': rating.toInt().toString(),
                              }
                            ],
                            'kwargs': {},
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                'Leads Created',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ])),
            ),
          ]),
        )
      ]),
    );
  }
}
