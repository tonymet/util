include ../rules.in
DESTDIR=$(HOME)/local/bin
#tname=$(strip ${subst 'install-', '', $@})
tname=$(subst 'install', 'kaka', 'installbutter')
install-all: install-workspace-archive install-findext install-findfile
install-workspace-archive:
	install bin/workspace-archive.sh $(DESTDIR)/workspace-archive
# makefile for typical build tasks
install-findext:
	install bin/findext.pl $(DESTDIR)/findext
install-findfile:
	install bin/findfile.sh $(DESTDIR)/findfile
#install-yroot-names:
#	install bin/yroot-names.sh $(DESTDIR)/yroot-names
#
install-vacuum-mail:
	install "bin/vacuum-mail.sh" $(DESTDIR)/vacuum-mail

install-%:
	echo $(tname); \
	install "bin/$(tname).sh" $(DESTDIR)/$name
