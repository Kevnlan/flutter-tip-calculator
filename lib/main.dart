import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// This is the default bill amount
const defaultBillAmount = 0.0;

// This is the default tip percentage
const defaultTipPercentage = 15;

// This is the TextEditingController which is used to keep track of the change in bill amount
final _billAmountController =
    TextEditingController(text: defaultBillAmount.toString());

// This is the TextEditingController which is used to keep track of the change in tip percentage
final _tipPercentageController =
    TextEditingController(text: defaultTipPercentage.toString());

// This stores the latest value of bill amount calculated
double _billAmount = defaultBillAmount;

// This stores the latest value of tip percentage calculated
int _tipPercentage = defaultTipPercentage;

_getTipAmount() => _billAmount * _tipPercentage / 100;

_getTotalAmount() => _billAmount + _getTipAmount();

@override
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tip Calculator',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white70,
      ),
      body: Container(
        color: Colors.white70,
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  key: Key("billAmount"),
                  controller: _billAmountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: 'Enter the Bill Amount',
                    labelText: 'Bill Amount',
                    labelStyle: TextStyle(
                        fontSize: 25,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  key: Key("tipPercentage"),
                  controller: _tipPercentageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter the Tip Percentage',
                    labelText: 'Tip Percentage',
                    labelStyle: TextStyle(
                        fontSize: 25,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(2, 2),
                        spreadRadius: 2,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      AmountText(
                        'Tip Amount: ${_getTipAmount()}',
                        key: Key('tipAmount'),
                      ),
                      AmountText(
                        'Total Amount: ${_getTotalAmount()}',
                        key: Key('totalAmount'),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );

  }

  void initState() {
    super.initState();
    _billAmountController.addListener(_onBillAmountChanged);
    _tipPercentageController.addListener(_onTipAmountChanged);
  }

  _onBillAmountChanged() {
    setState(() {
      _billAmount = double.tryParse(_billAmountController.text) ?? 0.0;
    });
  }

  _onTipAmountChanged() {
    setState(() {
      _tipPercentage = int.tryParse(_tipPercentageController.text) ?? 0;
    });
  }

  @override
  void dispose() {
    // To make sure we are not leaking anything, dispose any used TextEditingController
    // when this widget is cleared from memory.
    _billAmountController.dispose();
    _tipPercentageController.dispose();
    super.dispose();
  }
}
class AmountText extends StatelessWidget {
  final String text;

  const AmountText(
      this.text, {
        Key key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(text.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent, fontSize: 20)),
    );
  }
}

