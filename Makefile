# makefile for util
# $Id$
DESTDIR=$(HOME)/local/bin
tname=$*
install:: install-workspace-archive install-findext install-findfile install-vacuum-mail install-workspace-syncup install-backup-homedir install-syncup-homedir
install-findext::
	install "bin/findext.pl" $(DESTDIR)/findext
install-%-pl::
	install "bin/$(tname).pl" $(DESTDIR)/$(tname)

# wildcard for everything else
install-%:
	install "bin/$(tname).sh" $(DESTDIR)/$(tname)

install-ytwiki_proxy:
	install "bin/ytwiki_proxy.sh" /usr/local/bin/ytwiki_proxy

install-urlutil:
	install "bin/urldecode" bin/urlencode ~/local/bin/
