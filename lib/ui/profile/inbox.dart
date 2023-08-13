import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/bloc/inbox_bloc.dart';
import 'package:kangsayur_seller/bloc/event/inbox_event.dart';
import 'package:kangsayur_seller/bloc/state/inbox_state.dart';
import 'package:kangsayur_seller/repository/inbox_repository.dart';
import 'package:intl/intl.dart';
import '../../common/color_value.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Inbox',
          style: Theme.of(context).textTheme.headline6!.copyWith(
            color: ColorValue.neutralColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: ColorValue.neutralColor,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => InboxPageBloc(inboxPageRepository: InboxRepository())..add(GetInbox()),
        child: BlocBuilder<InboxPageBloc, InboxState>(
          builder: (context, state) {
            if(state is InboxLoading) {
              return const Center(child: CircularProgressIndicator());
            }else if (state is InboxLoaded){
              final data = state.inboxModel;
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Terbaru",
                        style: textTheme.headline6!.copyWith(
                          color: ColorValue.neutralColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        itemCount: data.data.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xFFF4F4F4),
                                    ),
                                    child: const Icon(
                                      Icons.email_outlined,
                                      color: ColorValue.neutralColor,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.data[index].judul,
                                              style: textTheme.bodyText1!.copyWith(
                                                color: ColorValue.neutralColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              DateFormat('dd MMMM yyyy',).format(
                                                DateTime.parse(
                                                  data.data[index].tanggal.toString(),
                                                ),
                                              ),
                                              style: textTheme.bodyText2!.copyWith(
                                                color: ColorValue.neutralColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          data.data[index].body,
                                          style: textTheme.bodyText2!.copyWith(
                                            color: ColorValue.neutralColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: ColorValue.neutralColor.withOpacity(0.2),
                              ),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            }else if (state is InboxError) {
              return const Center(child: Text('Terjadi Kesalahan'),);
            }else{
              return const Center(child: Text('Terjadi Kesalahan'),);
            }
          },
        ),
      ),
    );
  }
}
