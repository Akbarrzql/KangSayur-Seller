import 'package:flutter/cupertino.dart';
import '../../model/all_ulasan_user_model.dart';

@immutable
abstract class AllUlasanPageState {}

class InitialAllUlasanPageState extends AllUlasanPageState {}

class AllUlasanPageLoading extends AllUlasanPageState {}

class AllUlasanPageLoaded extends AllUlasanPageState {
  final AllUlasanSellerModel allUlasanSellerModel;

  AllUlasanPageLoaded(this.allUlasanSellerModel);
}

class AllUlasanPageError extends AllUlasanPageState {
  final String errorMessage;

  AllUlasanPageError(this.errorMessage);
}
