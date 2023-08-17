import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kangsayur_seller/bloc/bloc/list_promo_bloc.dart';
import 'package:kangsayur_seller/bloc/event/list_promo_event.dart';
import 'package:kangsayur_seller/bloc/state/list_promo_state.dart';
import 'package:kangsayur_seller/repository/list_promo_repository.dart';
import 'package:kangsayur_seller/ui/promo/promo.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/color_value.dart';
import '../bottom_navigation/bottom_navigation.dart';

class ListPromoPage extends StatefulWidget {
  const ListPromoPage({Key? key}) : super(key: key);

  @override
  State<ListPromoPage> createState() => _ListPromoPageState();
}

class _ListPromoPageState extends State<ListPromoPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Informasi Iklan',
          style: Theme.of(context).textTheme.headline6!.copyWith(
            color: ColorValue.neutralColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavigation(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: ColorValue.neutralColor,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => ListPromoPageBloc(listPromoPageRepository: ListPromoRespository())..add(GetListPromo()),
        child: BlocBuilder<ListPromoPageBloc, ListPromoState>(
          builder: (context, state) {
            if (state is ListPromoLoading){
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 220,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: ColorValue.hintColor,
                                width: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          ListView.builder(
                            itemCount: 3,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                width: double.infinity,
                                height: 220,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: ColorValue.hintColor,
                                    width: 0.5,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                  alignment: Alignment.center,
                                                  height: 33,
                                                  decoration: BoxDecoration(
                                                    color: ColorValue.primaryColor,
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                ),
                                              ]
                                          ),
                                        ),
                                        const Divider(
                                          color: ColorValue.hintColor,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 80,
                                                height: 80,
                                                color: Colors.grey,
                                              ),
                                              const SizedBox(width: 10,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    height: 10,
                                                    color: Colors.grey,
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  Container(
                                                    width: 100,
                                                    height: 10,
                                                    color: Colors.grey,
                                                  ),
                                                  Container(
                                                    width: 100,
                                                    height: 10,
                                                    color: Colors.grey,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }else if (state is ListPromoSuccess){
              final listPromo = state.listPromoModel.data;
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PromoPage(selectedCategories: [],),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: ColorValue.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            minimumSize: const Size(
                              double.infinity,
                              50,
                            ),
                          ),
                          child: Text(
                            'Buat Promo',
                            style: textTheme.bodyText2!.copyWith(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        listPromo.isEmpty ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              children: [
                                Lottie.asset("assets/json/promonf.json", width: 300, height: 300,),
                                Text(
                                  'Belum ada promo yang dibuat',
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
                        ) : ListView.builder(
                          itemCount: listPromo.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: ColorValue.hintColor,
                                  width: 0.5,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                alignment: Alignment.center,
                                                height: 33,
                                                decoration: BoxDecoration(
                                                  color: ColorValue.primaryColor,
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  listPromo[index].namaToko,
                                                  style: textTheme.bodyText2!.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ]
                                        ),
                                      ),
                                      const Divider(
                                        color: ColorValue.hintColor,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                                        child: Row(
                                          children: [
                                            Image.network(
                                              'https://kangsayur.nitipaja.online${listPromo[index].gambarProduk}',
                                              width: 80,
                                              height: 80,
                                            ),
                                            const SizedBox(width: 10,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  listPromo[index].namaProduk,
                                                  style: textTheme.bodyText2!.copyWith(
                                                    color: ColorValue.neutralColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const SizedBox(height: 10,),
                                                Text(
                                                  listPromo[index].hargaAwal.toString(),
                                                  style: textTheme.bodyText2!.copyWith(
                                                    color: Colors.red,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w700,
                                                    decoration: TextDecoration.lineThrough,
                                                  ),
                                                ),
                                                Text(
                                                  listPromo[index].hargaSale.toString(),
                                                  style: textTheme.bodyText2!.copyWith(
                                                    color: ColorValue.neutralColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      // Container(
                                      //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                      //   child: ElevatedButton(
                                      //     onPressed: (){},
                                      //     style: ElevatedButton.styleFrom(
                                      //       primary: ColorValue.primaryColor,
                                      //       shape: RoundedRectangleBorder(
                                      //         borderRadius: BorderRadius.circular(5),
                                      //       ),
                                      //       minimumSize: Size(
                                      //         MediaQuery.of(context).size.width,
                                      //         40,
                                      //       ),
                                      //     ),
                                      //     child: Text(
                                      //       'Lihat Detail',
                                      //       style: textTheme.bodyText2!.copyWith(
                                      //         color: Colors.white,
                                      //         fontSize: 14,
                                      //         fontWeight: FontWeight.w600,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            }else if (state is ListPromoFailure){
              return const Center(
                child: Text('Gagal mendapatkan data'),
              );
            }else{
              return const Center(
                child: Text('Gagal mendapatkan data'),
              );
            }
          },
        ),
      ),
    );
  }
}
