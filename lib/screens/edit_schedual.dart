import 'package:flutter/material.dart';
import 'package:flutter_netap/model/saveschedulemodel.dart';
import 'package:flutter_netap/provider/schedualProvider.dart';
import 'package:flutter_netap/widgets/custom_button.dart';
import 'package:flutter_netap/widgets/custom_edit_schedual_textfield.dart';
import 'package:provider/provider.dart';

class EditSchedual extends StatelessWidget {
  static final routeName = 'editSchedual';
  //update and delete Schedual
  @override
  Widget build(BuildContext context) {
    return Consumer<SchedualProvider>(builder: (context, provider, x) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(152, 2, 255, 1),
          title: Text('Edit Profile'),
        ),
        body: Form(
          key: provider.schedualKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25,
                ),
                CustomEditSchedualTextfeild(
                  icons: Icon(Icons.class__rounded),
                  label: 'ClassName',
                  controller: provider.classNameController,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomEditSchedualTextfeild(
                  icons: Icon(Icons.date_range_sharp),
                  label: 'StartDate',
                  controller: provider.startDateController,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomEditSchedualTextfeild(
                  icons: Icon(Icons.date_range_sharp),
                  label: 'EndDate',
                  controller: provider.endDateController,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomEditSchedualTextfeild(
                  icons: Icon(Icons.location_pin),
                  label: 'ClassLocation',
                  controller: provider.classLocationController,
                ),
                SizedBox(
                  height: 40,
                ),
                CustomEditSchedualTextfeild(
                  icons: Icon(Icons.timelapse),
                  label: 'StartTime',
                  controller: provider.startTimeController,
                ),
                SizedBox(
                  height: 40,
                ),
                CustomEditSchedualTextfeild(
                  icons: Icon(Icons.timelapse),
                  label: 'EndTime',
                  controller: provider.endTimeController,
                ),
                CustomButton(
                    title: 'Save Edit', function: provider.editSchedual())
              ],
            ),
          ),
        ),
      );
    });

    // Scaffold(
    //     appBar: AppBar(title: Text('Edit Schedual'), actions: [
    //   IconButton(
    //       onPressed: () {
    //         Provider.of<SchedualProvider>(context, listen: false)
    //             .deleteSchedual();
    //       },
    //       icon: Icon(Icons.delete)),
    // ]),
    // body: ,);
  }
}
