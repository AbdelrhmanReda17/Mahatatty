import 'package:flutter/material.dart';

class TrainTypeSelector extends StatefulWidget {

  const TrainTypeSelector({
    super.key,
    required this.isSelected,
    required this.trainType,
    required this.onSelected,
  });

  final bool isSelected;
  final String trainType;
  final ValueChanged<bool> onSelected;


  @override
  State<StatefulWidget> createState() => _TrainTypeSelectorState();
}

class _TrainTypeSelectorState extends State<TrainTypeSelector>{
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected; // Initialize local state
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onSelected(_isSelected);
      },
      child: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          color: _isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: _isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                widget.trainType,
                style: _isSelected
                    ? TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 14)
                    : const TextStyle(fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }



}