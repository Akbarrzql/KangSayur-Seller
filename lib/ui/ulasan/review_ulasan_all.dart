import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/all_ulasan_event.dart';
import 'package:kangsayur_seller/bloc/state/all_ulasan_state.dart';
import 'package:kangsayur_seller/repository/all_ulasan_repository.dart';
import 'package:intl/intl.dart';
import 'package:kangsayur_seller/ui/widget/not_found_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../bloc/bloc/all_ulasan_bloc.dart';
import '../../common/color_value.dart';
import '../../repository/ulasan_seller_repository.dart';
import '../widget/review_list.dart';

class ReviewUlasanPage extends StatefulWidget {
  const ReviewUlasanPage({Key? key}) : super(key: key);

  @override
  State<ReviewUlasanPage> createState() => _ReviewUlasanPageState();
}

class _ReviewUlasanPageState extends State<ReviewUlasanPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Ulasan Pembeli',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: BlocProvider(
            create: (context) => AllUlasanPageBloc(allUlasanPageRepository: AllUlasanRepository())..add(GetAllUlasan()),
            child: BlocBuilder<AllUlasanPageBloc, AllUlasanPageState>(
              builder: (context, state) {
                if(state is AllUlasanPageLoading){
                  return shimmerAllUlasan();
                } else if (state is AllUlasanPageLoaded){
                  final data = state.allUlasanSellerModel;
                  return data.data.length == 0 ? notFound(context, "assets/json/nfreview.json", "Belum ada review dari toko kamu") : Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 24),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "5.0",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "/5.0",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffA0A0A0)),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "100% pembeli merasa puas",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${data.data.length.toString()} total ulasan",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.data.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ReviewWidget(
                                  profile: "https://kangsayur.nitipaja.online/${data.data[index].gambarUser}",
                                  name: data.data[index].namaCustomer,
                                  date: DateFormat('dd MMMM yyyy').format(DateTime.parse(data.data[index].tanggalReview.toString())),
                                  comment: data.data[index].reviewUser,
                                  commentSeller: data.data[index].reply,
                                  image: "https://kangsayur.nitipaja.online/${data.data[index].gambarVariant}",
                                  rating: data.data[index].rating.toDouble(),
                                  context: context),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                }else if (state is AllUlasanPageError){
                  return const Center(child: Text("Terdapat kesalahan pada server"));
                } else {
                  return const Center(child: Text("Terdapat kesalahan pada server"));
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget shimmerAllUlasan(){
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 24),
              SizedBox(
                width: 5,
              ),
              Text(
                "5.0",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "/5.0",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffA0A0A0)),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "100% pembeli merasa puas",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "30 total ulasan",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )
            ],
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
