import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/controllers/journal_controller.dart';
import 'package:intl/intl.dart';

class CalendarPickerDialog {
  static void show(BuildContext context, JournalController journalC) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyles.radiusL),
          ),
          child: Container(
            padding: EdgeInsets.all(AppStyles.paddingL),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pilih Tanggal',
                      style: AppStyles.welcome2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppStyles.primaryDark,
                      ),
                    ),
                    // Tambahkan indicator tanggal yang dipilih
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppStyles.paddingS,
                        vertical: AppStyles.paddingXS,
                      ),
                      decoration: BoxDecoration(
                        color: AppStyles.primaryLight,
                        borderRadius: BorderRadius.circular(AppStyles.radius),
                      ),
                      child: Text(
                        DateFormat('dd/MM/yyyy').format(journalC.selectedDate.value),
                        style: TextStyle(
                          color: AppStyles.primaryDark,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppStyles.spaceM),
                
                // Calendar Widget
                CalendarDatePicker2(
                  config: CalendarDatePicker2Config(
                    calendarType: CalendarDatePicker2Type.single,
                    selectedDayHighlightColor: AppStyles.primaryDark,
                    weekdayLabelTextStyle: TextStyle(
                      color: AppStyles.primaryDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    controlsTextStyle: TextStyle(
                      color: AppStyles.primaryDark,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    selectedDayTextStyle: TextStyle(
                      color: AppStyles.light,
                      fontWeight: FontWeight.bold,
                    ),
                    dayTextStyle: TextStyle(
                      color: AppStyles.dark,
                    ),
                    todayTextStyle: TextStyle(
                      color: AppStyles.primaryDark,
                      fontWeight: FontWeight.bold,
                    ),
                    disabledDayTextStyle: TextStyle(
                      color: AppStyles.dark.withOpacity(0.3),
                    ),
                    selectableDayPredicate: (day) {
                      // Allow tanggal dari 30 hari yang lalu sampai hari ini
                      final now = DateTime.now();
                      final thirtyDaysAgo = now.subtract(Duration(days: 30));
                      final today = DateTime(now.year, now.month, now.day);
                      final checkDate = DateTime(day.year, day.month, day.day);
                      
                      return checkDate.isAfter(thirtyDaysAgo.subtract(Duration(days: 1))) && 
                             checkDate.isBefore(today.add(Duration(days: 1)));
                    },
                    firstDate: DateTime.now().subtract(Duration(days: 365)), // 1 tahun ke belakang
                    lastDate: DateTime.now(),
                    currentDate: journalC.selectedDate.value,
                    centerAlignModePicker: true,
                    customModePickerIcon: SizedBox(),
                    dayMaxWidth: 50,
                  ),
                  value: [journalC.selectedDate.value],
                  onValueChanged: (dates) {
                    if (dates.isNotEmpty && dates.first != null) {
                      final selectedDate = dates.first!;
                      print('Calendar date selected: ${DateFormat('yyyy-MM-dd').format(selectedDate)}');
                      
                      // Update tanggal di controller
                      journalC.setDate(selectedDate);
                      
                      // Tutup dialog
                      Navigator.of(context).pop();
                      
                      // Show loading indicator sementara
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(AppStyles.light),
                                ),
                              ),
                              SizedBox(width: AppStyles.spaceS),
                              Text('Memuat data journal...'),
                            ],
                          ),
                          duration: Duration(seconds: 2),
                          backgroundColor: AppStyles.primaryDark,
                        ),
                      );
                    }
                  },
                ),
                
                SizedBox(height: AppStyles.spaceM),
                
                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Today button
                    TextButton.icon(
                      onPressed: () {
                        final today = DateTime.now();
                        journalC.setDate(today);
                        Navigator.of(context).pop();
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Menampilkan journal hari ini'),
                            duration: Duration(seconds: 1),
                            backgroundColor: AppStyles.welcome,
                          ),
                        );
                      },
                      icon: Icon(Icons.today, size: 18),
                      label: Text('Hari Ini'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppStyles.primaryDark,
                      ),
                    ),
                    
                    // Cancel button
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Batal',
                        style: TextStyle(color: AppStyles.dark),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 