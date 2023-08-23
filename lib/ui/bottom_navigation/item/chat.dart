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
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
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
    final textTheme = Theme.of(context).textTheme;
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
              return Shimmer(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.withOpacity(0.5),
                    Colors.grey.withOpacity(0.3),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    child: Container(
                                      width: 100,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 30,
                                height: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Divider(
                        height: 1,
                        color: ColorValue.hintColor,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              );
            }else if (state is ListChatSellerLoaded){
              final listChatSellerModel = state.listChatSellerModel;
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                  child: listChatSellerModel.list.isEmpty ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Lottie.asset("assets/json/chatnf.json", width: 300, height: 300,),
                          Text(
                            'Belum terdapat chat dengan pelanggan yang masuk',
                            style: textTheme.headline6!.copyWith(
                              color: ColorValue.neutralColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )  : Column(
                    children: [
                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(5),
                      //     border: Border.all(
                      //       color: ColorValue.hintColor,
                      //       width: 0.5,
                      //     ),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 16),
                      //     child: TextFormField(
                      //       controller: _searchPelangganController,
                      //       keyboardType: TextInputType.text,
                      //       decoration: InputDecoration(
                      //         border: InputBorder.none,
                      //         hintText: "Cari Pelanggan",
                      //         icon: const Icon(
                      //           Icons.search,
                      //           color: ColorValue.hintColor,
                      //         ),
                      //         hintStyle:
                      //         Theme.of(context).textTheme.bodyText1!.copyWith(
                      //           color: ColorValue.hintColor,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 24,
                      // ),
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
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Lottie.asset("assets/json/chatnf.json", width: 300, height: 300,),
                      Text(
                        'Belum terdapat chat dengan pelanggan yang masuk',
                        style: textTheme.headline6!.copyWith(
                          color: ColorValue.neutralColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
