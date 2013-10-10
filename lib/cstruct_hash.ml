external unsafe_md5sum : Cstruct.buffer -> int -> int -> string = "cstruct_md5sum"

let md5sum t offset length =
	unsafe_md5sum t.Cstruct.buffer (offset + t.Cstruct.off) length
