import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_search.dart';

import '../../../../core/generic components/mahattaty_scaffold.dart';

class UserTicketsScreen extends StatelessWidget {
  const UserTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MahattatyScaffold(
      appBarContent: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'My Ticket',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      bgHeight: backgroundHeight.medium,
      body: const MyTicketScreenBody(),
    );
  }
}

class MyTicketScreenBody extends StatefulWidget {
  const MyTicketScreenBody({super.key});

  @override
  State<MyTicketScreenBody> createState() => _MyTicketScreenBodyState();
}

class _MyTicketScreenBodyState extends State<MyTicketScreenBody> {
  final TextEditingController _controller = TextEditingController();
  List<String> filters = [
    'All',
    'Lenia Express',
    'Jelingga Train',
    'Jordan Les',
    'Jordan Les',
    'Jordan Les'
  ];
  int? _value = 1;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: MahattatySearch(
            onPressed: (String value) {},
          ),
        ),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (BuildContext context, int index) {
              isSelected = _value == index;
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ChoiceChip(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  showCheckmark: false,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  selectedColor: Colors.white,
                  disabledColor: Colors.white,
                  labelStyle: isSelected
                      ? TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 17)
                      : TextStyle(color: Theme.of(context).colorScheme.surface),
                  label: Text(filters[index]),
                  selected: isSelected,
                  //_value == index,
                  onSelected: (selected) {
                    // filter change
                    setState(
                      () {
                        selected ? _value = index : _value = null;
                        isSelected = selected;
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
        const Expanded(
          child: MyTicketDetails(),
        )
      ],
    );
  }
}

class MyTicketDetails extends StatefulWidget {
  const MyTicketDetails({super.key});

  @override
  State<MyTicketDetails> createState() => _MyTicketDetailsState();
}

class _MyTicketDetailsState extends State<MyTicketDetails>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TabBar(
            overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
            isScrollable: false,
            dividerHeight: 0,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.transparent,
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            controller: tabController,
            tabs: const [
              Tab(
                text: 'Up Coming',
              ),
              Tab(
                text: 'Done',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                MyTicketUpComingScreen(),
                MyTicketDoneScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyTicketDoneScreen extends StatelessWidget {
  const MyTicketDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column();
  }
}

class MyTicketUpComingScreen extends StatelessWidget {
  const MyTicketUpComingScreen({super.key});

  final List<String> date = const ['14 june 2023', '26 june 2023'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        itemCount: date.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Travel on ${date[index]}',
                style: const TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.start,
              ),
            ],
          );
        },
      ),
    );
  }
}
