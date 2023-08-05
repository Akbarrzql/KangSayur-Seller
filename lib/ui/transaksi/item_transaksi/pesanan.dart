import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:kangsayur_seller/repository/konfirmasi_repository.dart';
import 'package:kangsayur_seller/ui/transaksi/item_transaksi/disiapkan.dart';
import 'package:kangsayur_seller/ui/widget/main_button.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import '../../../bloc/bloc/pesanan_bloc.dart';
import '../../../bloc/event/pesanan_event.dart';
import '../../../bloc/state/pesanan_state.dart';
import '../../../repository/disiapkan_repository.dart';
import '../../../repository/pesanan_repository.dart';
import '../../../repository/siap_antar_repository.dart';

class PesananPage extends StatefulWidget {
  const PesananPage({Key? key}) : super(key: key);

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {

  bool _isExpanded = false;
  int _expandedIndex = -1;
  bool loading = false;

  late PesananPageBloc _pesananPageBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pesananPageBloc = PesananPageBloc(pesananPageRepository: PesananRepository(), konfirmasiPageRepository: KonfirmasiRepository());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BlocProvider(
        create: (context) => _pesananPageBloc..add(GetPesanan()),
        child: BlocBuilder<PesananPageBloc, PesananPageState>(
          builder: (context, state) {
            if (state is PesananPageLoading) {
              return shimmerList();
            } else if (state is PesananPageLoaded) {
              return buildLoadedLayout(state);
            } else if (state is PesananPageError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.errorMessage,
                      style: textTheme.headline6,
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Lottie.network("https://assets1.lottiefiles.com/packages/lf20_09nNdJ9qB8.json", width: 300, height: 300,),
                      Text(
                        'Belum ada pesanan saat ini',
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
      )
    );
  }

  Widget buildLoadedLayout(PesananPageLoaded state){
    final textTheme = Theme.of(context).textTheme;
    return state.pesananModel.data.isNotEmpty ? ListView.builder(
      itemCount: state.pesananModel.data.length,
      itemBuilder: (context, index) {
        bool isItemExpanded = _isExpanded && index == _expandedIndex;
        return GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
              _expandedIndex = index;
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 1),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1612776561584-394d456a751d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDN8fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=500&q=60"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            state.pesananModel.data[index].statusOrder[0].namaProduk,
                            style: textTheme.headline6!.copyWith(
                              color: ColorValue.neutralColor,
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            state.pesananModel.data[index].statusOrder[0].notes.toString() ?? "Tidak ada catatan",
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: ColorValue.neutralColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          alignment: Alignment.center,
                          height: 20,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xFFD7FEDF),
                          ),
                          child: Text(
                            state.pesananModel.data[index].status,
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: ColorValue.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (isItemExpanded)
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      ListView.builder(
                        itemCount: state.pesananModel.data[index].statusOrder.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index2) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Kode Transaksi",
                                    style: textTheme.subtitle1!.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: ColorValue.neutralColor,
                                    ),
                                  ),
                                  Text(
                                    state.pesananModel.data[index].statusOrder[index2].transactionCode.toString(),
                                    style: textTheme.subtitle1!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: ColorValue.neutralColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tanggal Transaksi",
                                    style: textTheme.subtitle1!.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: ColorValue.neutralColor,
                                    ),
                                  ),
                                  Text(
                                    //convert date to date in string in format dd-MM-yyyy
                                    DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                        state.pesananModel.data[index].createdAt.toString(),
                                      ),
                                    ),
                                    style: textTheme.subtitle1!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: ColorValue.neutralColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        },
                      ),
                      main_button("Konfirmasi Pesanan", context, onPressed: () {
                        _pesananPageBloc.add(GetKonfirmasi(state.pesananModel.data[index].transactionCode.toString()));
                        setState(() {
                          _pesananPageBloc.add(GetPesanan());
                        });
                      }),
                    ],
                  )
              ],
            ),
          ),
        );
      },
    ) : Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Lottie.network("https://assets1.lottiefiles.com/packages/lf20_09nNdJ9qB8.json", width: 300, height: 300,),
            Text(
              'Belum ada pesanan saat ini',
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

  Widget shimmerList(){
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 14),
          physics: const BouncingScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: double.infinity,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: double.infinity,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: double.infinity,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}
