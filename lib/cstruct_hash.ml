external unsafe_md5sum : Cstruct.buffer -> int -> int -> string = "cstruct_md5sum"

let md5sum t offset length =
	if offset > t.Cstruct.len then invalid_arg "offset";
	if length < 0 then invalid_arg "length";
	if offset + length > t.Cstruct.len then invalid_arg "length";
	let offset_internal = offset + t.Cstruct.off in
	if offset_internal < 0 then invalid_arg "offset";
	unsafe_md5sum t.Cstruct.buffer offset_internal length
