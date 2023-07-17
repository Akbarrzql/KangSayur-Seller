import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kangsayur_seller/ui/chat/detail_chat_seller.dart';

import '../../common/color_value.dart';

class SellerCarePage extends StatefulWidget {
  const SellerCarePage({Key? key}) : super(key: key);

  @override
  State<SellerCarePage> createState() => _SellerCarePageState();
}

class _SellerCarePageState extends State<SellerCarePage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Seller Care',
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ada yang bisa kami bantu?",
                style: textTheme.headline6!.copyWith(
                  color: ColorValue.neutralColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                "Kami siap membantu Anda. Silakan untuk memulai percakapan.",
                style: textTheme.bodyText2!.copyWith(
                  color: ColorValue.hintColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 24,),
              Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: ColorValue.hintColor,
                width: 0.5,
              ),
            ),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                            child: Row(
                              children: [
                                Container(
                                alignment: Alignment.topCenter,
                                  child: SvgPicture.asset(
                                  'assets/svg/seller_chat_care_icon.svg',
                                  width: 35,
                                  height: 35,
                                ),
                              ),
                              const SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ada Seputar pertanyaan lebih lanjut?",
                                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: ColorValue.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Text(
                                  "Tanyakan Disini!",
                                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: ColorValue.hintColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: ColorValue.hintColor,
                    thickness: 0.5,
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 193,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Buat Kamu lebih mengerti tentang keluhanmu!",
                                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: ColorValue.hintColor,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                "Pertanyaanmu akan langsung dijawab oleh admin kami dalam waktu 1x24 jam",
                                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: ColorValue.hintColor,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: 110,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const DetailChatSellerPage(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: ColorValue.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Chat Admin",
                                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 5,),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: SvgPicture.asset(
                            'assets/svg/seller_icon_card.svg',
                            width: 90,
                            height: 90,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                ],
              ),
            ),
          ),
              const SizedBox(height: 24,),
              Text(
                "Pertanyaan yang sering diajukan",
                style: textTheme.headline6!.copyWith(
                  color: ColorValue.neutralColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                "Beberapa Pertanyaan yang sering ditanyakan oleh pengguna",
                style: textTheme.bodyText2!.copyWith(
                  color: ColorValue.hintColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 24,),
              expansion("Mengapa uang saya belum diberikan?", "Uang anda belum diberikan karena anda belum mengirimkan barang yang telah dibeli oleh pembeli, dan uang akan diberikan setelah pembeli sudah menerima barang yang anda kirimkan."),
              expansion("Berapa lama waktu untuk verifikasi produk?", "Waktu verifikasi produk adalah 1x24 jam setelah anda mengirimkan produk yang anda jual. Jika lebih dari 1x24 jam, silahkan hubungi admin kami."),
              expansion("Bagaimana cara mengirimkan produk yang saya jual?", "Anda dapat mengirimkan produk yang anda jual melalui jasa pengiriman yang telah anda sedikan pada aplikasi driver kami. Jika anda belum memiliki jasa pengiriman, anda dapat menghubungi admin kami untuk membantu anda."),
            ],
          ),
        ),
      ),
    );
  }

  Widget expansion(String header, String body) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color:  ColorValue.hintColor,
        ),
        color: Colors.transparent,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            hintColor: Colors.transparent,
          ),
          child: ExpansionTile(
            title: Text(
              header,
              style: const TextStyle(
                  fontSize: 12,
                  color: ColorValue.neutralColor,
                  fontWeight: FontWeight.w500),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 21),
                child: Text(
                  body,
                  style: const TextStyle(
                      fontSize: 10, color: ColorValue.neutralColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
