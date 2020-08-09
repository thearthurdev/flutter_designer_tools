import 'package:flutter/material.dart';
import 'package:flutter_designer_tools/src/settings_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MockupOverlaySettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      (create, watch) {
        final provider = watch(settingsProvider);

        bool mockupEnabled = provider.mockupEnabled;
        ImageProvider portraitMockup = provider.portraitMockup;
        ImageProvider landscapeMockup = provider.landscapeMockup;
        double mockupOpacity = provider.mockupOpacity;

        return Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          margin: EdgeInsets.all(8.0),
          constraints: BoxConstraints(maxWidth: 500.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.pinkAccent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                value: mockupEnabled,
                onChanged: (b) => provider.toggleMockupEnabled(b),
                secondary: Icon(
                  Icons.image,
                  color: Colors.white,
                ),
                title: Text(
                  'Mockup Overlay',
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Overlay a mockup to get a live preview of the layout or widget you are working on. Enable Juxtapose for even closer comparison by sliding to reveal/conceal the mockup.',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    height: 1.5,
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 12.0, 8.0),
                title: Text(
                  'Select Mockup',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
                trailing: Tooltip(
                  message: 'Reset Mockups',
                  waitDuration: Duration(milliseconds: 700),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              FittedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Portrait',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.0,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Material(
                                type: MaterialType.transparency,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: 80.0,
                                    height: 140.0,
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      border: Border.all(
                                        width: 2.0,
                                        color: Colors.white,
                                      ),
                                      image: portraitMockup == null
                                          ? null
                                          : DecorationImage(
                                              image: portraitMockup,
                                            ),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 24.0),
                          Column(
                            children: [
                              Text(
                                'Landscape',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.0,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Material(
                                type: MaterialType.transparency,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: 140.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      border: Border.all(
                                        width: 2.0,
                                        color: Colors.white,
                                      ),
                                      image: landscapeMockup == null
                                          ? null
                                          : DecorationImage(
                                              image: landscapeMockup,
                                            ),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '${mockupOpacity.toInt()}% Opacity',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Slider(
                min: 10.0,
                max: 100.0,
                value: mockupOpacity,
                onChanged: (value) => provider.setMockupOpacity(value),
              ),
            ],
          ),
        );
      },
    );
  }
}
