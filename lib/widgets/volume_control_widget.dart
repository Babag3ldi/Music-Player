import 'package:flutter/material.dart';
import 'package:volume_controller/volume_controller.dart';

class VolumeControlWidget extends StatefulWidget {
  const VolumeControlWidget({Key? key}) : super(key: key);

  @override
  _VolumeControlWidgetState createState() => _VolumeControlWidgetState();
}

class _VolumeControlWidgetState extends State<VolumeControlWidget> {
  bool noValume = false;

  double _setVolumeValue = 0;

  @override
  void initState() {
    super.initState();

    VolumeController().getVolume().then((volume) {
      setState(() {
        _setVolumeValue = volume;
      });
    });
  }

  @override
  void dispose() {
    VolumeController().removeListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Slider(
            activeColor: Theme.of(context).colorScheme.secondary,
            inactiveColor: Colors.white30,
            min: 0,
            max: 1,
            onChanged: (double value) {
              _setVolumeValue = value;
              VolumeController().setVolume(_setVolumeValue);
              setState(() {
               
              });
            },
            value: _setVolumeValue,
          ),
        ),
        IconButton(
          onPressed: () {
            VolumeController().getVolume().then((volume) {
              if (volume > 0) {
                setState(() {
              noValume = true;
            });
                VolumeController().muteVolume();
              } else {
                VolumeController().setVolume(0.33);
                setState(() {
              noValume = false;
            });
              }
            });
            // setState(() {
            //   noValume = true;
            // });
          },
          icon: Icon(
            noValume ? Icons.volume_off : Icons.volume_up,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
