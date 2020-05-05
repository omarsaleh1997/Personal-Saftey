import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/models/newEvent.dart';
import 'package:personal_safety/providers/event.dart';
import 'package:personal_safety/screens/event_details.dart';
import 'package:provider/provider.dart';

class EventListItem extends StatefulWidget {
  final NewEventData event;

  EventListItem({@required this.event, Key key}) : super(key: key);

  @override
  _EventListItemState createState() => _EventListItemState();
}

class _EventListItemState extends State<EventListItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text(
              'Do you want to remove the Event ?',
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<EventModel>(context, listen: false)
            .deleteEvent(widget.event);
      },
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            height: 146,
            child: Card(
                child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventDetailScreen(
                              data: widget.event,
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 70,
                      height: 120,
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Image(
                          image: FileImage(
                            widget.event.image,
                          ),
                          fit: BoxFit.cover,
                        ),
                        //margin: EdgeInsets.all(10),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "UserName",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Container(
                            width: 240,
                              child:
//                              widget.event.description.length > 80
//                                  ? Text(
//                                      widget.event.description
//                                              .substring(0, 40) +
//                                          '...see more',
//                                overflow: TextOverflow.clip,
//                                maxLines: 2,
//                                softWrap: false,
//                                style: TextStyle(
//                                    color: primaryColor, fontSize: 13),
//                                    )
//                                  :
                              Text(
                                      widget.event.description,
                                overflow: TextOverflow.fade,
                                maxLines: 2,
                                softWrap: false,
                                      style: TextStyle(
                                          color: primaryColor, fontSize: 13),
                                    )),
                          Padding(
                            padding: const EdgeInsets.only(top:10),
                            child: Container(
                                child: Container(
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: Color(0xff006C8E),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(5))),
                                    child: Text(
                                      widget.event.isPublic == true
                                          ? "Public Help"
                                          : 'Nearby Help',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ))),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                DateFormat('dd/MM/yyyy hh:mm')
                                    .format(DateTime.now()),
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Container(
                                height: 50,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "4k",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.favorite_border,
                                          color: widget.event.isFav
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            widget.event.toggleFavoriteStatus();
                                          });
                                        }),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ),
        ),
      ]),
    );
  }
}
