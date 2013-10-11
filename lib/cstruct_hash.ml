let check_bounds t offset length =
	if offset > t.Cstruct.len then invalid_arg "offset";
	if length < 0 then invalid_arg "length";
	if offset + length > t.Cstruct.len then invalid_arg "length";
	if (offset + t.Cstruct.off) < 0 then invalid_arg "offset"

external unsafe_md5sum : Cstruct.buffer -> int -> int -> string = "cstruct_md5sum"

let md5sum t offset length =
	check_bounds t offset length;
	unsafe_md5sum t.Cstruct.buffer (offset + t.Cstruct.off) length
