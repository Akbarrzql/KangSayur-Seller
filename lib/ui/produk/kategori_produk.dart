import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../bloc/bloc/produk_bloc.dart';
import '../../bloc/event/produk_event.dart';
import '../../bloc/state/produk_state.dart';
import '../../common/color_value.dart';
import '../../repository/produk_repository.dart';
import '../promo/promo.dart';

class KategoriProdukPage extends StatefulWidget {
  const KategoriProdukPage({Key? key}) : super(key: key);

  @override
  State<KategoriProdukPage> createState() => _KategoriProdukPageState();
}

class _KategoriProdukPageState extends State<KategoriProdukPage> {
  List<bool> isChecked = [false, false, false, false, false, false];

  void _navigateToPromoPage(List<bool> selectedCategories) {
    List<int> selectedIndexes = [];
    for (var i = 0; i < selectedCategories.length; i++) {
      if (selectedCategories[i]) {
        selectedIndexes.add(i);
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PromoPage(
          selectedCategories: isChecked,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Pilih Kategori Produk',
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
        create: (context) =>
            ProdukPageBloc(produkPageRepository: ProdukRepository())
              ..add(GetProduk()),
        child: BlocBuilder<ProdukPageBloc, ProdukPageState>(
          builder: (context, state) {
            if (state is ProdukPageLoading) {
              return shimmerList();
            } else if (state is ProdukPageLoaded) {
              final categoryNames = state.produkModel.data;
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    child: Column(
                      children: [
                        for (var i = 0; i < categoryNames.length; i++)
                          Column(
                            children: [
                              _kategori_lapak(
                                context,
                                categoryNames[i].namaProduk,
                                "https://kangsayur.nitipaja.online${categoryNames[i].variantImg}",
                                categoryNames[i].hargaVariant.toString(),
                                categoryNames[i].stok.toString(),
                                isChecked[i],
                                (value) =>
                                    setState(() => isChecked[i] = value!),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        const Spacer(),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              List<int> selectedIndexes = [];
                              for (var i = 0; i < isChecked.length; i++) {
                                if (isChecked[i]) {
                                  selectedIndexes.add(i);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PromoPage(
                                        selectedCategories: isChecked,
                                        idProduk: categoryNames[i].produkId,
                                        idVariant: categoryNames[i].variant.map((v) => v.id).toList(),
                                        price: categoryNames[i].hargaVariant,
                                        stock: categoryNames[i].stok,
                                        image: "https://kangsayur.nitipaja.online${categoryNames[i].variantImg}",
                                        title: categoryNames[i].namaProduk,
                                        variant: categoryNames[i].variant.map((v) => v.variant.toString()).toList(),
                                        variantPrice: categoryNames[i].variant.map((v) => v.hargaVariant).toList(),
                                      ),
                                    ),
                                  );
                                }
                              }


                              // for (var i = 0; i < categoryNames.length; i++) {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => PromoPage(
                              //         selectedCategories: isChecked,
                              //         idProduk: categoryNames[i].produkId.toString(),
                              //         price: categoryNames[i].hargaVariant.toString(),
                              //         stock: categoryNames[i].stok.toString(),
                              //         image: "https://kangsayur.nitipaja.online${categoryNames[i].variantImg}",
                              //         title: categoryNames[i].namaProduk,
                              //       ),
                              //     ),
                              //   );
                              // }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: ColorValue.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(
                              'Simpan',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is ProdukPageError) {
              return shimmerList();
            } else {
              return shimmerList();
            }
          },
        ),
      ),
    );
  }

  Widget _kategori_lapak(
    BuildContext context,
    String nama_produk,
    String foto_produk,
    String rating_produk,
    String produk_terjual,
    bool isChecked,
    Function(bool?) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: isChecked,
            onChanged: onChanged,
          ),
          //image container radius 8
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              foto_produk,
              width: 50,
              height: 50,
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nama_produk,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: ColorValue.neutralColor,
                    ),
              ),
              const SizedBox(height: 5),
              //icon star warna kuning
              Row(
                children: [
                  Text(
                    NumberFormat.currency(
                            locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                        .format(int.parse(rating_produk)),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: ColorValue.neutralColor,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                "Stok : " + produk_terjual,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: ColorValue.neutralColor,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget shimmerList(){
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            child: Column(
              children: [
                for (var i = 0; i < 6; i++)
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: isChecked[i],
                              onChanged: (value) =>
                                  setState(() => isChecked[i] =
                                  value!),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius:
                                BorderRadius.circular(8),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius:
                                    BorderRadius.circular(2),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                //icon star warna kuning
                                Row(
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: ColorValue.primaryColor,
                                        borderRadius:
                                        BorderRadius.circular(2),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Container(),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
