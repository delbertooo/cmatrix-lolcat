FROM ruby:2.6-alpine

ENV CMATRIX_DOWNLOAD_SHA256 6b0b9aff4585147843c4cf8a8c9c6048500f66dc4887a38922197dfa326b57c8

RUN set -eux; \
	apk add --no-cache --virtual .cmatrix-builddeps \
		autoconf \
		glib-dev \
		ncurses-dev \
		g++ \
		make \
		tar \
	; \
	wget -O cmatrix.tar.gz "https://github.com/abishekvashok/cmatrix/archive/1.2.tar.gz"; \
	echo "$CMATRIX_DOWNLOAD_SHA256 *cmatrix.tar.gz" | sha256sum -c; \
	mkdir -p /usr/src/cmatrix; \
	tar -xvf cmatrix.tar.gz -C /usr/src/cmatrix --strip-components=1; \
	rm cmatrix.tar.gz; \
	cd /usr/src/cmatrix; \
	./configure \
	make; \
	make install; \
	apk del --no-network .cmatrix-builddeps; \
	cd /; \
	rm -r /usr/src/cmatrix; \
	gem install lolcat; \
	cmatrix -V; \
	lolcat -v

CMD cmatrix | lolcat