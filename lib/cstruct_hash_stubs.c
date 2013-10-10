#include <stdio.h>

#include <caml/alloc.h>
#include <caml/bigarray.h>
#include <caml/callback.h>
#include <caml/fail.h>
#include <caml/memory.h>
#include <caml/signals.h>

#include <openssl/md5.h>

CAMLprim value cstruct_md5sum(value buffer, value offset, value length) {
    CAMLparam3(buffer, offset, length);
    CAMLlocal1(result);

    unsigned char* data;
    unsigned char digest[MD5_DIGEST_LENGTH];

    data = (unsigned char*) Data_bigarray_val(buffer);
    MD5(data, Int_val(length), digest);

    result = caml_copy_string((char*) digest);

    CAMLreturn(result);
}
