.PHONY: clean test install uninstall

dist/build/lib-cstruct_hash/cstruct_hash.cmxa:
	obuild configure --enable-tests
	obuild build

clean:
	rm -rf dist

test:
	obuild test --output

install:
	ocamlfind install cstruct-hash lib/META $(wildcard dist/build/lib-cstruct_hash/*)

uninstall:
	ocamlfind remove cstruct-hash
