import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String _namaDestinasi = 'Punti Kayu';
  String _namaKotaDestinasi = 'Palembang';
  double _rating = 4.5;
  String _dropDownValue = 'Disc hingga 20%';
  var _menuItems = ['Disc hingga 20%', '2', '3'];
  int jumlahOrangDewasa = 0;
  int jumlahOrangAnak = 0;
  int hargaDewasa = 25000;
  int hargaAnak = 15000;
  int totalHargaDewasa = 0;
  int totalHargaAnak = 0;
  int totalHarga = 0;

  DateTime _focusedDay = DateTime.now();
  final ValueNotifier<DateTime> _focusedDayNotifier = ValueNotifier<DateTime>(DateTime.now());
  DateTime? _rangeStart = DateTime.now();
  DateTime? _rangeEnd;
  final ValueNotifier<DateTime?> _rangeStartNotifier = ValueNotifier<DateTime?>(null);
  final ValueNotifier<DateTime?> _rangeEndNotifier = ValueNotifier<DateTime?>(null);
  int _year = DateTime.now().year;
  final ValueNotifier<int> _yearNotifier = ValueNotifier<int>(DateTime.now().year);



  void kurangOrangDewasa() {
    setState(() {
      if(jumlahOrangDewasa > 0) {
        jumlahOrangDewasa--;
        totalHargaDewasa = hargaDewasa * jumlahOrangDewasa;
        totalHarga -= hargaDewasa;
      }
    });
  }

  void tambahOrangDewasa() {
    setState(() {
      jumlahOrangDewasa++;
      totalHargaDewasa = hargaDewasa * jumlahOrangDewasa;
      totalHarga += hargaDewasa;
    });
  }

  void kurangOrangAnak() {
    setState(() {
      if(jumlahOrangAnak > 0) {
        jumlahOrangAnak--;
        totalHargaAnak = hargaAnak * jumlahOrangAnak;
        totalHarga -= hargaAnak;
      }
    });
  }

  void tambahOrangAnak() {
    setState(() {
      jumlahOrangAnak++;
      totalHargaAnak = hargaAnak * jumlahOrangAnak;
      totalHarga += hargaAnak;
    });
  }

  void _updateFocusedDay(DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      _focusedDayNotifier.value = _focusedDay;
    });
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeStartNotifier.value = _rangeStart;
      _rangeEndNotifier.value = _rangeEnd;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext builder) {
        return ValueListenableBuilder(
          valueListenable: _focusedDayNotifier,
          builder: (context, focusedDay, _) {
            return ValueListenableBuilder<DateTime?>(
              valueListenable: _rangeStartNotifier,
              builder: (context, rangeStart, _) {
                return ValueListenableBuilder<DateTime?>(
                  valueListenable: _rangeEndNotifier,
                  builder: (context, rangeEnd, _) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(40))
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                              'Pilih tanggal',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.orangeAccent
                              ),
                          ),

                          Text(
                            '${DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime.now().toLocal())}',
                            style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF4280BD)
                            ),
                          ),
                          
                          TableCalendar(
                            firstDay: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                            lastDay: DateTime(DateTime.now().year + 1, DateTime.now().month, DateTime.now().day),
                            focusedDay: _focusedDay,
                            locale: "id_ID",
                            headerStyle: const HeaderStyle(
                              formatButtonVisible: false,
                              titleCentered: true,
                              titleTextStyle: TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              ),
                              leftChevronIcon: Icon(
                                  Icons.chevron_left,
                                  color: const Color(0xFF4280BD)
                              ),
                              rightChevronIcon: Icon(
                                  Icons.chevron_right,
                                  color: const Color(0xFF4280BD)
                              ),
                              headerPadding: EdgeInsets.all(0)
                            ),
                            calendarStyle: const CalendarStyle(
                              isTodayHighlighted: false,
                              defaultTextStyle: TextStyle(fontWeight: FontWeight.bold),
                              rangeStartDecoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              rangeStartTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                              rangeEndDecoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              rangeEndTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                              rangeHighlightColor: Colors.orange,
                              withinRangeTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                              weekendTextStyle: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            rowHeight: 30,
                            availableGestures: AvailableGestures.all,
                            rangeSelectionMode: RangeSelectionMode.toggledOn,
                            rangeStartDay: _rangeStart,
                            rangeEndDay: _rangeEnd,
                            onRangeSelected: _onRangeSelected,
                            onHeaderTapped: selectMonth,
                          ),

                          const Expanded(
                              child: SizedBox()
                          ),

                          Container(
                            width: double.infinity,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 45,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4280BD),
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Pilih Tanggal',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                );
              },
            );
          }
        );
      },
    );
  }

  void selectMonth(DateTime focusedDay) {
    _selectMonth(context);
  }

  Future<void> _selectMonth(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext builder) {
        return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40))
            ),
            height: MediaQuery.of(context).size.height * 0.7,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pilih bulan',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent
                  ),
                ),

                Text(
                  '${DateFormat('MMMM yyyy', 'id_ID').format(DateTime.now().toLocal())}',
                  style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF4280BD)
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: _yearNotifier,
                        builder: (context, year, _) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _year--;
                                      _yearNotifier.value = _year;
                                    },
                                    icon: const Icon(
                                      Icons.chevron_left,
                                      color: Color(0xFF4280BD)
                                    )
                                  ),
                                  Text(
                                    '$_year',
                                    style: const TextStyle(
                                        color: Colors.orangeAccent,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        _year++;
                                        _yearNotifier.value = _year;
                                      },
                                      icon: const Icon(
                                          Icons.chevron_right,
                                          color: Color(0xFF4280BD)
                                      )
                                  ),
                                ],
                              ),
                              MonthCalendar(year: _year, updateFocusedDay: _updateFocusedDay, focusedDay: _rangeStart!,)
                            ],
                          );
                        }
                      ),
                    ],
                  ),
                ),

                const Expanded(
                    child: SizedBox()
                ),

                Container(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4280BD),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Pilih Bulan',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F8FF),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            // TODO: 1. Buat tulisan Tiket
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                  'Tiket',
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 30,
                    fontWeight: FontWeight.w500
                  )
              ),
            ),

            // TODO: 2. Buat kotak destinasi
            Padding(
              padding: const EdgeInsets.only(
                right: 20.0,
                bottom: 20.0,
                left: 20.0
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 5)
                    )
                  ]
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    const SizedBox(
                        height: 100,
                        width: 80,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            _namaDestinasi,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4280BD)
                            ),
                        ),
                        Text(
                            _namaKotaDestinasi,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4280BD)
                            ),
                        ),
                        RatingBar(
                            ratingWidget: RatingWidget(
                              full: const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              half: const Icon(
                                Icons.star_half,
                                color: Colors.amber,
                              ),
                              empty: const Icon(
                                Icons.star_border,
                                color: Colors.amber,
                              )
                            ),
                            onRatingUpdate: (_) {},
                            allowHalfRating: true,
                            initialRating: _rating,
                            ignoreGestures: true,
                            itemSize: 15,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),

            // TODO: 3. Buat Stack Keterangan
            Expanded(
              child: Stack(
                children: [
              
                  // TODO: 4. Buat 3 kotak biru di belakang
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 80,
                        color: const Color(0xFF4280BD),
                      ),
              
                      const SizedBox(height: 15),
              
                      Container(
                        height: 40,
                        color: const Color(0xFF4280BD),
                      ),
              
                      const SizedBox(height: 15),
              
                      Container(
                        height: 240,
                        color: const Color(0xFF4280BD),
                      ),
                    ],
                  ),
              
                  Column(
                    children: [
                      // TODO: 5. Kotak tanggal
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0,
                            right: 20.0,
                            bottom: 10.0,
                            left: 20.0
                        ),
                        child: Container(
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Icon(
                                    Icons.calendar_month_rounded,
                                    color: Color(0xFF4280BD)
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'TANGGAL',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFF4280BD)
                                      ),
                                    ),
                                    Text((_rangeStart == null)? DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime.now().toLocal()) :
                                    (_rangeEnd == null)? DateFormat('dd MMMM yyyy', 'id_ID').format(_rangeStart!.toLocal()) :
                                    '${DateFormat('dd MMMM yyyy', 'id_ID').format(_rangeStart!.toLocal())} - ${DateFormat('dd MMMM yyyy', 'id_ID').format(_rangeEnd!.toLocal())}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: IconButton(
                                    icon: const Icon(Icons.edit_calendar_rounded),
                                    color: const Color(0xFF4280BD),
                                    onPressed: () => _selectDate(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  
                      // TODO 6: Voucher
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0,
                            right: 20.0,
                            bottom: 10.0,
                            left: 20.0
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              flex: 3,
                              child: Text(
                                  'Voucher',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                              ),
                            ),

                            Expanded(
                              flex: 3,
                              child: Container(
                                width: double.infinity,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: DropdownButton(
                                  items: _menuItems.map((String item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue){
                                    setState(() {
                                      _dropDownValue = newValue!;
                                    });
                                  },
                                  value: _dropDownValue,
                                  style: const TextStyle(
                                      color: Color(0xFF4280BD),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15
                                  ),
                                  isExpanded: true,
                                )
                              ),
                            )
                          ],
                        ),
                      ),
                  
                      // TODO 7: Jumlah Orang
                      Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            bottom: 0,
                            right: 20,
                            top: 15
                          ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                                'Jumlah Orang',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                            ),
                  
                            const SizedBox(height: 5),
                  
                            Container(
                              height: 65,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Icon(
                                        Icons.people,
                                        color: Color(0xFF4280BD)
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'DEWASA',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFF4280BD),
                                          ),
                                        ),
                                        Text(
                                          '$jumlahOrangDewasa',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Text(
                                          'IDR $hargaDewasa',
                                          style: const TextStyle(
                                              color: Colors.orangeAccent,
                                              fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        IconButton(
                                            onPressed: () => kurangOrangDewasa(),
                                            icon: const Icon(
                                                Icons.remove_circle,
                                                color: Color(0xFF4280BD),
                                            ),
                                        ),

                                        Text('$jumlahOrangDewasa'),

                                        IconButton(
                                            onPressed: () => tambahOrangDewasa(),
                                            icon: const Icon(
                                              Icons.add_circle,
                                              color: Color(0xFF4280BD),
                                            )
                                        )
                                      ],
                                    )
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 10),

                            Container(
                              height: 65,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Icon(
                                        Icons.people,
                                        color: Color(0xFF4280BD)
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'ANAK',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFF4280BD),
                                          ),
                                        ),
                                        Text(
                                          '$jumlahOrangAnak',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Text(
                                          'IDR $hargaAnak',
                                          style: const TextStyle(
                                              color: Colors.orangeAccent,
                                              fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () => kurangOrangAnak(),
                                            icon: const Icon(
                                              Icons.remove_circle,
                                              color: Color(0xFF4280BD),
                                            ),
                                          ),

                                          Text('$jumlahOrangAnak'),

                                          IconButton(
                                              onPressed: () => tambahOrangAnak(),
                                              icon: const Icon(
                                                Icons.add_circle,
                                                color: Color(0xFF4280BD),
                                              )
                                          )
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      // TODO 8: Kotak Harga
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)
                                ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 3,
                                        blurRadius: 3,
                                        offset: Offset(2, 15)
                                    )
                                  ]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  right: 20,
                                  bottom: 20,
                                  left: 20
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    const Text(
                                        'Harga',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54
                                      ),
                                    ),

                                    const Divider(
                                      color: Color(0xFF4280BD),
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Dewasa'),
                                        Text('IDR $totalHargaDewasa'),
                                      ],
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Anak'),
                                        Text('IDR $totalHargaAnak'),
                                      ],
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Voucher',
                                          style: TextStyle(color: Colors.orangeAccent),
                                        ),
                                        Text(
                                          'IDR 50',
                                          style: TextStyle(color: Colors.orangeAccent),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Total Harga',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w900
                                          ),
                                        ),
                                        Text(
                                          'IDR $totalHarga',
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w900,
                                              color: Color(0xFF4280BD)
                                          ),
                                        ),
                                      ],
                                    ),

                                    Expanded(child: SizedBox()),

                                    Container(
                                      height: 45,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF4280BD),
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: Offset(0, 2)
                                          )
                                        ]
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Pesan Sekarang',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
    );
  }
}

class MonthCalendar extends StatefulWidget {
  int year;
  final void Function(DateTime) updateFocusedDay;
  final DateTime focusedDay;

  MonthCalendar({super.key, required this.year, required this.updateFocusedDay, required this.focusedDay});

  @override
  State<MonthCalendar> createState() => _MonthCalendarState();
}

class _MonthCalendarState extends State<MonthCalendar> {
  final DateTime _today = DateTime.now();
  final DateTime _oneYearFromToday = DateTime(DateTime.now().year+1, DateTime.now().month, DateTime.now().day);
  late int _selectedYear;
  late int _selectedMonth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedYear = widget.focusedDay.year;
    _selectedMonth = widget.focusedDay.month;
  }

  bool isMonthAvailable(int month, int year) {
    if(year < _today.year || year > _oneYearFromToday.year) {
      return false;
    } else if(DateTime(year, month).isBefore(DateTime(_today.year, _today.month)) || DateTime(year, month).isAfter(_oneYearFromToday)) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildMonthContainer(1, 'Januari'),
            buildMonthContainer(2, 'Februari'),
            buildMonthContainer(3, 'Maret'),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildMonthContainer(4, 'April'),
            buildMonthContainer(5, 'Mei'),
            buildMonthContainer(6, 'Juni'),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildMonthContainer(7, 'Juli'),
            buildMonthContainer(8, 'Agustus'),
            buildMonthContainer(9, 'September'),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildMonthContainer(10, 'Oktober'),
            buildMonthContainer(11, 'November'),
            buildMonthContainer(12, 'Desember'),
          ],
        ),
      ],
    );
  }

  Widget buildMonthContainer(int index, String name) {
    return GestureDetector(
      onTap: () {
        if(isMonthAvailable(index, widget.year)) {
          setState(() {
            _selectedMonth = index;
            _selectedYear = widget.year;

            if(_selectedMonth == _today.month && _selectedYear == _today.year) {
              widget.updateFocusedDay(DateTime.now());
            } else {
              widget.updateFocusedDay(DateTime(_selectedYear, _selectedMonth, 1));
            }
          });
        }
      },
      child: Container(
        width: 100,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.025),
          color: (_selectedYear == widget.year && index == _selectedMonth)? Colors.orange : Colors.transparent,
        ),
        alignment: Alignment.center,
        child: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: (!isMonthAvailable(index, widget.year))? Colors.grey :
            (_selectedYear == widget.year && index == _selectedMonth)? Colors.white : Colors.black,
          ),
        ),

      ),
    );
  }
}


