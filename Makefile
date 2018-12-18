CFLAGS += -Wall -Wextra -Werror -Oz

libmininix-exec.so: mininix-exec.c
	$(CC) $(CFLAGS) mininix-exec.c -shared -fPIC -o libmininix-exec.so

install: libmininix-exec.so
	install libmininix-exec.so $(PREFIX)/lib/libmininix-exec.so

uninstall:
	rm -f $(PREFIX)/lib/libmininix-exec.so

test: libmininix-exec.so
	@LD_PRELOAD=${CURDIR}/libmininix-exec.so ./run-tests.sh

clean:
	rm -f libmininix-exec.so tests/*-actual

.PHONY: clean install test uninstall
