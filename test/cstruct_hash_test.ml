let data = "as89f7d8f798d7f987f0daf"

let () =
	let cstruct = Cstruct.of_string data in
	let string_digest = Digest.string data in
	let cstruct_digest = Cstruct_hash.md5sum cstruct 0 (String.length data) in
	if string_digest <> cstruct_digest
	then failwith (Printf.sprintf "not equal: %s %s" string_digest cstruct_digest)
