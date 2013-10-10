.PHONY: clean test

dist/build/lib-cstruct_hash/cstruct_hash.cmxa:
	obuild configure --enable-tests
	obuild build

clean:
	rm -rf dist

test:
	obuild test --output
