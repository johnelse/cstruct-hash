open OUnit

let test_strings = [
	"";
	"foo";
	"as89f7d8f798d7f987f0daf";
	";£*%($)(^$&";
	"\\\n\\";
]

let test data =
	let cstruct = Cstruct.of_string data in
	let string_digest = Digest.string data in
	let cstruct_digest = Cstruct_hash.md5sum cstruct 0 (String.length data) in
	assert_equal string_digest cstruct_digest

let test_hash_all =
	"test_hash_all" >:::
		(List.map
			(fun test_string ->
				let test_name =
					Printf.sprintf
						"test_hash_all: \"%s\""
						(String.escaped test_string)
				in
				test_name >:: (fun () -> test test_string))
			test_strings)

let base_suite =
	"base_suite" >:::
		[
			test_hash_all;
		]

let _ = run_test_tt_main base_suite
