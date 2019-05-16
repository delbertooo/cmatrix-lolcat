FROM ruby:2.6

RUN apt-get update \
	&& apt-get install -y --no-install-recommends cmatrix \
	&& rm -rf /var/lib/apt/lists/* \
    && gem install lolcat

CMD cmatrix | lolcat