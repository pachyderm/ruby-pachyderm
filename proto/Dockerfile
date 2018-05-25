FROM ruby:2.4.4-onbuild
LABEL maintainer="jdoliner@pachyderm.io"

ADD run /
ENV PATH $PATH:/usr/local/bundle/bin/
ENTRYPOINT ["/run"]
