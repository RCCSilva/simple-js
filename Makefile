v8build:
	docker build -t v8-build .

v8:	
	rm -fr debian
	rm -fr deps/v8
	mkdir -p deps/v8
	mkdir -p debian
	docker run -dt --rm --name v8-build v8-build /bin/sh
	docker cp v8-build:/build/v8/out.gn/x64.release/obj/libv8_monolith.a debian/libv8_monolith.a
	docker cp v8-build:/build/v8/include deps/v8/
	docker cp v8-build:/build/v8/src deps/v8/
	docker cp v8-build:/build/v8/out.gn/x64.release/gen deps/v8/
	docker kill v8-build