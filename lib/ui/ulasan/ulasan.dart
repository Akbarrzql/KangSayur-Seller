import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/state/ulasan_seller_state.dart';
import 'package:kangsayur_seller/repository/balasan_user_repository.dart';
import 'package:kangsayur_seller/ui/ulasan/review_ulasan_all.dart';
import 'package:kangsayur_seller/ui/ulasan/ulasan_seller.dart';
import 'package:kangsayur_seller/ui/widget/card_kelola_ulasan.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../bloc/bloc/ulasan_seller_bloc.dart';
import '../../bloc/event/ulasan_seller_event.dart';
import '../../common/color_value.dart';
import '../../repository/ulasan_seller_repository.dart';

class UlasanPage extends StatefulWidget {
  const UlasanPage({Key? key}) : super(key: key);

  @override
  State<UlasanPage> createState() => _UlasanPageState();
}

class _UlasanPageState extends State<UlasanPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Kelola Ulasan',
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
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ReviewUlasanPage()));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: ColorValue.neutralColor, width: 0.5),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lihat semua ulasan",
                          style: textTheme.bodyText2!.copyWith(
                            color: ColorValue.neutralColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_outlined, size: 16, color: ColorValue.neutralColor,),
                      ],
                    ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocProvider(
                create: (context) => UlasanSellerPageBloc(ulasanSellerPageRepository: UlasanSellerRepository(), balasanUserSellerRepository: BalasanUserSellerRepository())..add(GetUlasanSeller()),
                child: BlocBuilder<UlasanSellerPageBloc, UlasanSellerPageState>(
                  builder: (context, state) {
                    if (state is UlasanSellerPageLoading) {
                      return shimmerAllUlasan();
                    } else if (state is UlasanSellerPageLoaded) {
                      final ulasanSeller = state.ulasanSellerModel;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: ulasanSeller.data.length,
                        itemBuilder: (context, index) {
                          return CardKelolaUlasan(
                            gambarProduk: 'https://kangsayur.nitipaja.online/${ulasanSeller.data[index].gambarVariant}',
                            namaProduk: ulasanSeller.data[index].namaProduk,
                            namaPemesan: ulasanSeller.data[index].namaCustomer,
                            tanggalUlasPembeli: DateFormat('dd MMMM yyyy').format(DateTime.parse(ulasanSeller.data[index].tanggalReview.toString())),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Ulasan(
                                data: ulasanSeller.data[index],
                              )));
                            },
                          );
                        },
                      );
                    } else if (state is UlasanSellerPageError) {
                      return Center(
                        child: Text(state.errorMessage),
                      );
                    } else {
                      return const Center(
                        child: Text(''),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  Widget shimmerAllUlasan(){
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
