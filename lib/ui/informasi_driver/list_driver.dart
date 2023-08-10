import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:kangsayur_seller/ui/auth/register/driver/register_driver.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/bloc/list_all_driver_bloc.dart';
import '../../bloc/event/list_all_driver_event.dart';
import '../../bloc/state/list_all_driver_state.dart';
import '../../repository/list_all_driver_repository.dart';
import '../bottom_navigation/bottom_navigation.dart';
import 'detail_driver.dart';

class ListDriver extends StatefulWidget {
  const ListDriver({Key? key}) : super(key: key);

  @override
  State<ListDriver> createState() => _ListDriverState();
}

class _ListDriverState extends State<ListDriver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Driver",
          style: TextStyle(color: Colors.black, fontSize: 18),),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomNavigation()));
            }
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ListAllDriverPageBloc(listAllDriverPageRepository: ListAllDriverRepository())..add(GetListAllDriver()),
          child: BlocBuilder<ListAllDriverPageBloc, ListAllDriverState>(
            builder: (context, state) {
              if (state is ListAllDriverLoading) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.5),
                  highlightColor: Colors.grey.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return _cardDriver("Nama Driver", "+628123456789", "https://images.unsplash.com/photo-1600320254374-ce2d293c324e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGRyaXZlcnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60");
                          },
                        )
                    ),
                  ),
                );
              } else if (state is ListAllDriverLoaded) {
                final data = state.listAllDriverModel;
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.produk.length,
                        itemBuilder: (context, index) {
                          return _cardDriver(data.produk[index].namaDriver.toString(), "+62${data.produk[index].nomorTelfon.toString()}", "https://kangsayur.nitipaja.online${data.produk[index].fotoDriver.toString()}", onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailDriver(data: data.produk[index])));
                          },);
                        },
                      )
                  ),
                );
              } else if (state is ListAllDriverError) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else {
                return const Center(
                  child: Text("Terdapat kesalahan dalam mengambil data"),
                );
              }
            },
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterDriver()));
        },
        backgroundColor: ColorValue.primaryColor,
        child: const Icon(Icons.add),
      ),
    floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }

  Widget _cardDriver(String name, String phone, String image, {void Function()? onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1)
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10,),
            Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      phone,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,),
                    ),
                  ],
                )
            ),
            const Spacer(),
            IconButton(
              onPressed: onTap,
              icon: const Icon(Icons.arrow_forward_ios, color: ColorValue.hintColor,),
            ),
          ],
        ),
      ),
    );
  }
}
