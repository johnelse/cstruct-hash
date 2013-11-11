#include <string.h>

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

    result = caml_alloc_string(MD5_DIGEST_LENGTH);
    data = (unsigned char*) Data_bigarray_val(buffer);
    data += Int_val(offset);

    MD5(data, Int_val(length), (unsigned char*) String_val(result));

    CAMLreturn(result);
}
