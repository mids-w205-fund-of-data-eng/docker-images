FROM ubuntu:xenial

RUN apt-get update && apt-get install -y \
  tmux \
  python3 \
  bash-completion \
  vim
