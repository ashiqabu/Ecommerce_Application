import 'package:flutter/material.dart';
import 'package:test_cyra/core/constant.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  String? _selectedValue;
  bool _isChecked = false;
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isSwitched = false;
  bool _isSwitched1 = false;
  bool _isSwitched2 = false;

  final List myList = ['A', 'B', 'C', 'D'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radio List Tile Example'),
      ),
      body: Column(
        children: [
          RadioListTile<String>(
            title: const Text('Option 1'),
            value: 'option1',
            groupValue: _selectedValue,
            onChanged: (value) {
              setState(() {
                _selectedValue = value;
              });
            },
            secondary: const Icon(Icons.star),
          ),
          RadioListTile<String>(
            title: const Text('Option 2'),
            value: 'option2',
            groupValue: _selectedValue,
            onChanged: (value) {
              setState(() {
                _selectedValue = value;
              });
            },
            secondary: const Icon(Icons.star),
          ),
          RadioListTile<String>(
            title: const Text('Option 3'),
            value: 'option3',
            groupValue: _selectedValue,
            onChanged: (value) {
              setState(() {
                _selectedValue = value;
              });
            },
            secondary: const Icon(Icons.star),
          ),
          kHeight(50),
          Card(
            margin: const EdgeInsets.only(left: 50, right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('checkbox-1 '),
                Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    }),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.only(left: 50, right: 50, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('checkbox-2 '),
                Checkbox(
                    value: _isChecked1,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked1 = value ?? false;
                      });
                    }),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.only(left: 50, right: 50, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('checkbox-3 '),
                Checkbox(
                    value: _isChecked2,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked2 = value ?? false;
                      });
                    }),
              ],
            ),
          ),
          kHeight(50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Switch-1'),
              Switch(
                  value: _isSwitched,
                  onChanged: (bool? value) {
                    setState(() {
                      _isSwitched = value ?? false;
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Switch-2'),
              Switch(
                  value: _isSwitched1,
                  onChanged: (bool? value) {
                    setState(() {
                      _isSwitched1 = value ?? false;
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Switch-3'),
              Switch(
                  value: _isSwitched2,
                  onChanged: (bool? value) {
                    setState(() {
                      _isSwitched2 = value ?? false;
                    });
                  }),
            ],
          ),
          kHeight(20),
        ],
      ),
    );
  }
}
