import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/state/list_chat_seller_state.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:kangsayur_seller/repository/list_chat_repository.dart';
import 'package:kangsayur_seller/ui/chat/detail_chat.dart';
import 'package:kangsayur_seller/ui/chat/pengaturan_chat.dart';
import 'package:kangsayur_seller/ui/widget/list_chat.dart';
import 'package:kangsayur_seller/ui/widget/textfiled.dart';
import 'package:intl/intl.dart';
import '../../../bloc/bloc/list_chat_seller_bloc.dart';
import '../../../bloc/event/list_chat_seller_event.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _searchPelangganController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Chat',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: ColorValue.neutralColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PengaturanTokoPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.settings_outlined,
              color: ColorValue.neutralColor,
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => ListChatSellerPageBloc(listChatSellerPageRepository: ListChatSellerRepository())..add(GetListChatSeller()),
        child: BlocBuilder<ListChatSellerPageBloc, ListChatSellerState>(
          builder: (context, state) {
            if (state is ListChatSellerLoading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }else if (state is ListChatSellerLoaded){
              final listChatSellerModel = state.listChatSellerModel;
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: ColorValue.hintColor,
                            width: 0.5,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: _searchPelangganController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Cari Pelanggan",
                              icon: const Icon(
                                Icons.search,
                                color: ColorValue.hintColor,
                              ),
                              hintStyle:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: ColorValue.hintColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ListView.builder(
                        itemCount: listChatSellerModel.list.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListChart(
                              imagePelanggan: 'https://kangsayur.nitipaja.online${listChatSellerModel.list[index].photo}',
                              namePelanggan: listChatSellerModel.list[index].name,
                              pesanPelanggan: listChatSellerModel.list[index].lastConvo.message,
                              waktuPesan: DateFormat('HH:mm').format(DateTime.parse(listChatSellerModel.list[index].lastConvo.createdAt.toString())),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailChatPage(
                                    data: listChatSellerModel.list[index],
                                  ),
                                ),
                              ));
                        },
                      )
                    ],
                  ),
                ),
              );
            }else if (state is ListChatSellerError){
              return Center(
                child: Text(state.errorMessage),
              );
            }else{
              return const Center(
                child: Text('Error'),
              );
            }
          },
        ),
      ),
    );
  }
}
