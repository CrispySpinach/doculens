import 'dart:ffi';

import 'package:ffi/ffi.dart';

typedef NativeCompareFunc = Double Function(
  Pointer<Utf8> docA,
  Pointer<Utf8> docB,
  Int32 shingleSize,
);

typedef DartCompareFunc = double Function(
  Pointer<Utf8> docA,
  Pointer<Utf8> docB,
  int shingleSize,
);

class FfiService {
  late final DynamicLibrary _library;

  late final DartCompareFunc _compare;

  FfiService() {
    _library =
        DynamicLibrary.open(
      'doculens.dll',
    );

    _compare =
        _library.lookupFunction<
            NativeCompareFunc,
            DartCompareFunc>(
      'compareDocuments',
    );
  }

  double compare(
    String docA,
    String docB,
    int shingleSize,
  ) {
    final docAPtr =
        docA.toNativeUtf8();

    final docBPtr =
        docB.toNativeUtf8();

    final result =
        _compare(
      docAPtr,
      docBPtr,
      shingleSize,
    );

    malloc.free(docAPtr);
    malloc.free(docBPtr);

    return result;
  }
}