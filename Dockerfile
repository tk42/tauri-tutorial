FROM rust:1.82-slim-bookworm

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    build-essential \
    libssl-dev \
    pkg-config \
    libgtk-3-dev \
    libwebkit2gtk-4.1-dev \
    file \
    libxdo-dev \
    libglib2.0-dev \
    glib2.0 \
    glib2.0-dev \
    gobject-2.0 \
    gobject-2.0-dev \
    gio-2.0 \
    gio-2.0-dev \
    libayatana-appindicator3-dev \
    librsvg2-dev \
    sudo \
    lld \
    llvm \
    clang \
    mingw-w64 \
    nsis

RUN bash -c "curl -fsSL https://deb.nodesource.com/setup_22.x | bash -" && \
    apt-get install -y nodejs

RUN npm install -g npm@latest
RUN corepack enable
RUN yarn set version stable --yarn-path

# targetにx86_64-pc-windows-msvcを追加
RUN rustup target add x86_64-pc-windows-msvc

# cargo-xwinコマンドを使えるようにする:
RUN cargo install cargo-xwin

ENV CC_x86_64_pc_windows_msvc=clang-cl
ENV CFLAGS_x86_64_pc_windows_msvc="--target=x86_64-pc-windows-msvc -Wno-unused-command-line-argument"