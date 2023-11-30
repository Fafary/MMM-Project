import 'package:flutter/material.dart';

import '../model/campagne_model.dart';
import '../model/user_model.dart';
import 'campagne_screen.dart';

class CampaignCard extends StatefulWidget {
  final String title;
  final String description;
  final UserDatabase user;
  final Campagne campagne;

  const CampaignCard({
    Key? key,
    required this.title,
    required this.description,
    required this.user,
    required this.campagne,
  }) : super(key: key);

  @override
  CampaignCardState createState() => CampaignCardState();
}

class CampaignCardState extends State<CampaignCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CampaignScreen(
                  campagne: widget.campagne,
                  user: widget.user,
                ),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isHovered ? Colors.green : Colors.grey,
                  offset: const Offset(2, 2),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0x4D9489F5),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.nature_people_rounded,
                        color: Colors.blue,
                        size: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            color: Color(0xFF212121),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            widget.description,
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xFF757575),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            navigateToMapScreen(widget.campagne);
                          },
                          child: const Text('Voir la carte'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navigateToMapScreen(Campagne campagne) {
    Navigator.of(context).pushNamed('/map', arguments: campagne);
  }
}
