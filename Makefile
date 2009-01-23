# makefile for util
# $Id$
include ../rules.in
DESTDIR=$(HOME)/local/bin
tname=$*
install: install-workspace-archive install-findext install-findfile install-vacuum-mail
install-findext:
	install "bin/findext.pl" $(DESTDIR)/findext

# wildcard for everything else
install-%:
	install "bin/$(tname).sh" $(DESTDIR)/$(tname)
