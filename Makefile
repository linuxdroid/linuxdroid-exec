CFLAGS += -Wall -Wextra -Werror -Oz

liblinuxdroid-exec.so: linuxdroid-exec.c
	$(CC) $(CFLAGS) linuxdroid-exec.c -shared -fPIC -o liblinuxdroid-exec.so

install: liblinuxdroid-exec.so
	install liblinuxdroid-exec.so $(PREFIX)/lib/liblinuxdroid-exec.so

uninstall:
	rm -f $(PREFIX)/lib/liblinuxdroid-exec.so

test: liblinuxdroid-exec.so
	@LD_PRELOAD=${CURDIR}/liblinuxdroid-exec.so ./run-tests.sh

clean:
	rm -f liblinuxdroid-exec.so tests/*-actual

.PHONY: clean install test uninstall
