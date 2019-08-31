FROM amazonlinux:2

USER root

RUN yum groupinstall -y "Development Tools" && \
    yum install -y openssl-devel readline-devel fontconfig-devel freetype git && \
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv && \
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

ENV PATH "/root/.rbenv/bin:$PATH"

COPY .ruby-version /app/
WORKDIR /app

RUN echo 'eval "$(rbenv init -)"' >> ~/.bash_profile && \
    source ~/.bash_profile && \
    rbenv install $(cat .ruby-version) && \
    rbenv global $(cat .ruby-version) && \
    rbenv exec gem install bundler && \
    rbenv rehash
