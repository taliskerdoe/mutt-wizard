.POSIX:

OS = $(shell uname -s)
ifndef PREFIX
  PREFIX = /usr/local
endif
ifndef MANPREFIX
  MANPREFIX = $(PREFIX)/share/man
endif

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f bin/mw bin/mailsync bin/openfile $(DESTDIR)$(PREFIX)/bin/
	chmod 755 $(DESTDIR)$(PREFIX)/bin/mw $(DESTDIR)$(PREFIX)/bin/mailsync $(DESTDIR)$(PREFIX)/bin/openfile
	mkdir -p $(DESTDIR)$(PREFIX)/share/mutt-wizard
	chmod 755 $(DESTDIR)$(PREFIX)/share/mutt-wizard
	cp -f share/mailcap share/domains.csv share/mutt-wizard.muttrc $(DESTDIR)$(PREFIX)/share/mutt-wizard
	chmod 644 $(DESTDIR)$(PREFIX)/share/mutt-wizard/mailcap $(DESTDIR)$(PREFIX)/share/mutt-wizard/domains.csv $(DESTDIR)$(PREFIX)/share/mutt-wizard/mutt-wizard.muttrc
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	cp -f mw.1 $(DESTDIR)$(MANPREFIX)/man1/mw.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/mw.1
	if [ "$(PREFIX)" ]; then \
		sed -iba 's:/usr/local:$(PREFIX):' $(DESTDIR)$(PREFIX)/share/mutt-wizard/mutt-wizard.muttrc; \
		rm -f $(DESTDIR)$(PREFIX)/share/mutt-wizard/mutt-wizard.muttrcba; \
		sed -iba 's:/usr/local:$(PREFIX):' $(DESTDIR)$(PREFIX)/bin/mw; \
		rm -f $(DESTDIR)$(PREFIX)/bin/mwba; \
		sed -iba 's:/usr/local:$(PREFIX):' $(DESTDIR)$(MANPREFIX)/man1/mw.1; \
		rm -f $(DESTDIR)$(MANPREFIX)/man1/mw.1ba; \
	fi

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/mw $(DESTDIR)$(PREFIX)/bin/mailsync $(DESTDIR)$(PREFIX)/bin/openfile
	rm -rf $(DESTDIR)$(PREFIX)/share/mutt-wizard
	rm -f $(DESTDIR)$(MANPREFIX)/man1/mw.1

.PHONY: install uninstall
