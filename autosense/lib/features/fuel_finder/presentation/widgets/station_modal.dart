import 'package:flutter/material.dart';
import '../../models/station.dart';
import '../../models/pump.dart';

class StationModal extends StatefulWidget {
  final Station? station;
  final Function(Station) onSave;
  final Function? onEdit;
  final Function? onDelete;
  final bool isEditing;

  const StationModal({
    Key? key,
    this.station,
    required this.onSave,
    this.onEdit,
    this.onDelete,
    this.isEditing = false,
  }) : super(key: key);

  @override
  _StationModalState createState() => _StationModalState();
}

class _StationModalState extends State<StationModal> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;

  List<Pump> _pumps = [];
  List<Pump> _tempPumps = [];
  Station? _backupStation;

  String? _nameError;
  String? _addressError;
  String? _cityError;
  Map<String, String?> _pumpErrors = {}; // Use Pump ID as key

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.station?.name ?? '')
      ..addListener(_validateName);
    _addressController =
        TextEditingController(text: widget.station?.address ?? '')
          ..addListener(_validateAddress);
    _cityController = TextEditingController(text: widget.station?.city ?? '')
      ..addListener(_validateCity);
    _pumps = widget.station?.pumps ?? [];
    _tempPumps = List.from(_pumps);
    _backupStation = widget.station; // backup original station
  }

  void _validateName() {
    setState(() {
      _nameError = _nameController.text.isEmpty ? 'Required field' : null;
    });
  }

  void _validateAddress() {
    setState(() {
      _addressError = _addressController.text.isEmpty ? 'Required field' : null;
    });
  }

  void _validateCity() {
    setState(() {
      _cityError = _cityController.text.isEmpty ? 'Required field' : null;
    });
  }

  @override
  void dispose() {
    _nameController.removeListener(_validateName);
    _addressController.removeListener(_validateAddress);
    _cityController.removeListener(_validateCity);
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label, {String? errorText}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: errorText != null ? Colors.red : Colors.grey),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      errorText: errorText,
    );
  }

  void _addNewPump() {
    final newPump = Pump(
      id: UniqueKey().toString(), // Generate unique ID for each pump
      fuelType: '',
      price: 0.0,
      available: true,
    );
    setState(() {
      _tempPumps.add(newPump);
    });
  }

  void _updatePump(Pump updatedPump, int index) {
    setState(() {
      _tempPumps[index] = updatedPump;
      if (updatedPump.fuelType.isEmpty || updatedPump.price < 0) {
        _pumpErrors[updatedPump.id] = 'Invalid';
      } else {
        _pumpErrors.remove(updatedPump.id);
      }
    });
  }

  void _removePump(int index) {
    setState(() {
      _pumpErrors.remove(_tempPumps[index].id);
      _tempPumps.removeAt(index);
    });
  }

  void _saveStation() {
    _validateName();
    _validateAddress();
    _validateCity();

    for (int i = 0; i < _tempPumps.length; i++) {
      if (_tempPumps[i].fuelType.isEmpty || _tempPumps[i].price < 0) {
        _pumpErrors[_tempPumps[i].id] = 'Invalid';
      } else {
        _pumpErrors.remove(_tempPumps[i].id);
      }
    }

    if (_nameError == null &&
        _addressError == null &&
        _cityError == null &&
        _pumpErrors.isEmpty) {
      Station newStation = Station(
        id: widget.station?.id ?? '',
        name: _nameController.text,
        address: _addressController.text,
        city: _cityController.text,
        latitude: widget.station?.latitude ?? 0,
        longitude: widget.station?.longitude ?? 0,
        pumps: _tempPumps,
      );
      widget.onSave(newStation);
      Navigator.of(context).pop();
    }
  }

  void _cancelChanges() {
    setState(() {
      _tempPumps = List.from(_pumps);
      _nameController.text = _backupStation?.name ?? '';
      _addressController.text = _backupStation?.address ?? '';
      _cityController.text = _backupStation?.city ?? '';
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            16, 16, 16, MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.isEditing)
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.black),
                      decoration:
                          _inputDecoration('Name', errorText: _nameError),
                    ),
                  ],
                ),
              ),
            ListTile(
              title: Text(
                widget.isEditing ? '' : widget.station?.name ?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  'https://picsum.photos/seed/${widget.station?.id ?? 'default'}/50/50', // Random thumbnail image
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.isEditing)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: TextFormField(
                            controller: _addressController,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 12),
                            decoration: _inputDecoration('Address',
                                errorText: _addressError),
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      widget.station?.address ?? '',
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  const SizedBox(height: 5),
                  if (widget.isEditing)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: TextFormField(
                            controller: _cityController,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 12),
                            decoration:
                                _inputDecoration('City', errorText: _cityError),
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      widget.station?.city ?? '',
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Pumps',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 10),
            Column(
              children: _tempPumps.map((pump) {
                int index = _tempPumps.indexOf(pump);
                return Column(
                  key: ValueKey(
                      pump.id), // Use ValueKey to maintain unique identity
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(66, 79, 58, 185),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 20,
                          child: const Icon(
                            Icons.local_gas_station,
                            color: Colors.white,
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          initialValue: pump.fuelType,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          decoration: _inputDecoration(
                                              'Fuel Type',
                                              errorText: _pumpErrors[pump
                                                  .id]), // Use pump id for errors
                                          onChanged: (value) {
                                            _updatePump(
                                                pump.copyWith(fuelType: value),
                                                index);
                                          },
                                          enabled: widget
                                              .isEditing, // Only allow editing when in edit mode
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          initialValue: pump.price.toString(),
                                          style: const TextStyle(
                                              color: Colors.black),
                                          decoration: _inputDecoration(
                                            'Price',
                                            errorText: _pumpErrors[pump
                                                .id], // Use pump id for errors
                                          ),
                                          onChanged: (value) {
                                            _updatePump(
                                                pump.copyWith(
                                                    price: double.tryParse(
                                                            value) ??
                                                        0.0),
                                                index);
                                          },
                                          enabled: widget
                                              .isEditing, // Only allow editing when in edit mode
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (widget.isEditing)
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () => _removePump(index),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: pump.available ? Colors.green : Colors.red,
                            size: 10,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            pump.available ? 'Available' : 'Not Available',
                            style: TextStyle(
                              fontSize: 10,
                              color: pump.available ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                );
              }).toList(),
            ),
            if (widget.isEditing) ...[
              ElevatedButton.icon(
                onPressed: _addNewPump,
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  'Add New Pump',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  minimumSize: const Size(double.infinity, 40),
                ),
              ),
            ],
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget.isEditing
                  ? [
                      OutlinedButton(
                        onPressed: _cancelChanges,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          backgroundColor: Colors.white,
                          minimumSize: const Size(100, 40),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _saveStation,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          minimumSize: const Size(100, 40),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ]
                  : [
                      OutlinedButton(
                        onPressed: () {
                          if (widget.onDelete != null) {
                            widget.onDelete!(widget.station!);
                            Navigator.of(context).pop();
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          backgroundColor: Colors.white,
                          minimumSize: const Size(100, 40),
                        ),
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => widget.onEdit!(widget.station!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          minimumSize: const Size(100, 40),
                        ),
                        child: const Text(
                          'Edit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
            ),
          ],
        ),
      ),
    );
  }
}
