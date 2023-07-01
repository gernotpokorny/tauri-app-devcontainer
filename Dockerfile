# Run `make build-debian-bookworm-18` to build this image

FROM rust:bookworm

# Install base utils
RUN apt-get update
RUN apt-get install -y \
	curl \
	psmisc

# Install Node.js
RUN curl -fsSL "https://deb.nodesource.com/setup_18.x" | bash -
RUN apt-get install -y nodejs

# Install Yarn
RUN corepack enable

# Install Tarpaulin
RUN cargo install cargo-tarpaulin

# Install Tauri dependencies
# https://tauri.app/v1/guides/getting-started/prerequisites#setting-up-linux
RUN apt-get install -y \
	libwebkit2gtk-4.0-dev \
	build-essential \
	curl \
	wget \
	libssl-dev \
	libgtk-3-dev \
	libayatana-appindicator3-dev \
	librsvg2-dev	

# Install tauri-driver dependencies
RUN apt-get install -y \
	webkit2gtk-4.0-dev \
	webkit2gtk-driver \
	xvfb

# Whatever dependencies
RUN apt-get install -y file

# Install tauri-driver
# https://tauri.app/v1/guides/testing/webdriver/introduction#system-dependencies
RUN cargo install tauri-driver

ENV DISPLAY=host.docker.internal:0.0

WORKDIR /app

COPY . .

#RUN npm install
#RUN cd src-tauri && cargo build