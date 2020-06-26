FROM debian:buster-slim

# Install Debian packages
RUN apt-get update --yes && apt-get install --no-install-recommends --yes \
  automake \
  bash \
  bison \
  bzip2 \
  ca-certificates \
  curl \
  file \
  flex \
  g++ \
  gawk \
  gcc \
  gperf \
  help2man \
  libncurses5-dev \
  libtool-bin \
  make \
  patch \
  python-dev \
  texinfo \
  unzip \
  xz-utils \
&& apt-get clean --yes

ENV XCC_PREFIX=/usr/xcc

# Add the crosstool-ng script and image-specific toolchain configuration into
# /dockcross/.
#
# Afterwards, we will leave the "ct-ng" config in the image as a reference
# for users.
COPY \
  imagefiles/install-crosstool-ng-toolchain.sh \
  defconfig \
  /dockcross/

# Build and install the toolchain, cleaning up artifacts afterwards.
RUN mkdir /dockcross/crosstool \
&& cd /dockcross/crosstool \
&& /dockcross/install-crosstool-ng-toolchain.sh \
  -p "${XCC_PREFIX}" \
  -c /dockcross/defconfig \
&& rm -rf /dockcross/crosstool /dockcross/install-crosstool-ng-toolchain.sh
