import 'package:flutter/material.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:kangsayur_seller/ui/chat/detail_chat.dart';
import 'package:kangsayur_seller/ui/chat/pengaturan_chat.dart';
import 'package:kangsayur_seller/ui/widget/list_chat.dart';
import 'package:kangsayur_seller/ui/widget/textfiled.dart';

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
      body: SafeArea(
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
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListChart(
                      imagePelanggan: 'assets/images/ava_profile.png',
                      namePelanggan: 'Nama Pelanggan',
                      pesanPelanggan: 'Halo, saya mau tanya...',
                      waktuPesan: '10.00',
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailChatPage(),
                            ),
                          ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
