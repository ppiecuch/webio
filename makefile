#
# Makefile for Linux webio sample Web server program
#

INCUDES = webfs.h  webio.h  websys.h  wfsdata.h

OBJS = \
	htmldata.o 	\
	webclib.o	\
	webfs.o		\
	webio.o		\
	webobjs.o	\
	websys.o	\
	webtest.o	\
	webutils.o	\
	imgdata.o

all: webio

webio: $(OBJS) $(INCLUDES)
	gcc $(OBJS) -o webio

.c.o:
	gcc -g -DLINUX -DLINUX_DEMO -c $*.c -o $*.o

clean:
	rm -f *.o
	rm -f webio    
	# delete the C generated by fsbuilder
	rm -f imgdata.c htmldata.c

webclib.o:  webclib.c   $(INCLUDES) makefile
webfs.o:    webfs.c     $(INCLUDES) makefile
webio.o:    webio.c     $(INCLUDES) makefile
webobjs.o:  webobjs.c   $(INCLUDES) makefile
websys.o:   websys.c    $(INCLUDES) makefile
webtest.o:  webtest.c   $(INCLUDES) makefile
webutils.o: webutils.c  $(INCLUDES) makefile
imgdata.o:  imgdata.c   $(INCLUDES) makefile
htmldata.o: htmldata.c  $(INCLUDES) makefile

# rules to generate the C files containing embedded html & images
imgdata.c: fsbuild/fsbuilder snail.gif prlogo.gif filelist
	fsbuild/fsbuilder -o htmldata.c filelist

htmldata.c: fsbuild/fsbuilder index.html filelist
	fsbuild/fsbuilder -o htmldata.c filelist

#rule to get the latest fsbuilder, assumes sibling ../fsbuild dir
fsbuild/fsbuilder:
	$(MAKE) -C fsbuild
