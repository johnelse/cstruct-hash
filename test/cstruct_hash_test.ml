open OUnit

let non_empty_test_strings = [
	"foobar";
	"as89f7d8f798d7f987f0daf";
	";£*%($)(^$&";
	"\\\n\\xyz";
]

let all_test_strings = "" :: non_empty_test_strings

let test_hash_all data =
	let cstruct = Cstruct.of_string data in
	let string_digest = Digest.string data in
	let cstruct_digest = Cstruct_hash.md5sum cstruct 0 (String.length data) in
	assert_equal string_digest cstruct_digest

let suite_test_hash_all =
	"suite_test_hash_all" >:::
		(List.map
			(fun test_string ->
				let test_name =
					Printf.sprintf
						"test_hash_all: \"%s\""
						(String.escaped test_string)
				in
				test_name >:: (fun () -> test_hash_all test_string))
			all_test_strings)

let test_hash_part data =
	let offset = 1 in
	let length = 4 in
	let cstruct = Cstruct.of_string data in
	let string_digest = Digest.string (String.sub data offset length) in
	let cstruct_digest = Cstruct_hash.md5sum cstruct offset length in
	assert_equal string_digest cstruct_digest

let suite_test_hash_part =
	"suite_test_hash_part" >:::
		(List.map
			(fun test_string ->
				let test_name =
					Printf.sprintf
						"test_hash_part: \"%s\""
						(String.escaped test_string)
				in
				test_name >:: (fun () -> test_hash_part test_string))
			non_empty_test_strings)

let test_negative_length () =
	let cstruct = Cstruct.of_string "foobar" in
	assert_raises
		(Invalid_argument "length")
		(fun () -> Cstruct_hash.md5sum cstruct 2 (-5))

let test_negative_offset () =
	let cstruct = Cstruct.of_string "foobar" in
	assert_raises
		(Invalid_argument "offset")
		(fun () -> Cstruct_hash.md5sum cstruct (-3) 4)

let test_too_large_length () =
	let cstruct = Cstruct.of_string "foobar" in
	assert_raises
		(Invalid_argument "length")
		(fun () -> Cstruct_hash.md5sum cstruct 3 5)

let test_too_large_offset () =
	let cstruct = Cstruct.of_string "foobar" in
	assert_raises
		(Invalid_argument "offset")
		(fun () -> Cstruct_hash.md5sum cstruct 7 2)

let suite_test_bounds_checking =
	"suite_test_bounds_checking" >:::
		[
			"test_negative_length" >:: test_negative_length;
			"test_negative_offset" >:: test_negative_offset;
			"test_too_large_length" >:: test_too_large_length;
			"test_too_large_offset" >:: test_too_large_offset;
		]

let base_suite =
	"base_suite" >:::
		[
			suite_test_hash_all;
			suite_test_hash_part;
			suite_test_bounds_checking;
		]

let _ = run_test_tt_main base_suite
