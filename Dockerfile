FROM nvidia/cuda:11.7.1-devel-ubuntu20.04
# use nvidia/cuda:11.7.1-devel-ubuntu20.04 because
# 1. pytorch uses cuda 11.7
# 2. cudf pip installation is only available for
#    ubuntu20 and python 3.8 or 3.9
# 3. cudf needs /usr/local/cuda/nvmm which is preinstalled
#    in the devel-image
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && apt-get install -y \
    wget \
    curl \
    ncdu \
    ranger \
    git \
    git-lfs \
    tig \
    htop \
    # firefox for jupyter-notebooks to interact with metaflow
    firefox \
    python3-venv \
    python3-pip \
    # emacs-libs
    libsm-dev libjansson4 libncurses5 libgccjit0 \
    librsvg2-2 libjpeg9 libtiff5 libgif7 libpng16-16 \
    libgtk-3-0 libharfbuzz0b libxpm4 \
    && pip install --upgrade pip \
    && ln -s /usr/bin/python3 /usr/bin/python \
    # emacs
    && wget https://github.com/emacs-ng/emacs-ng/releases/download/v0.0.d5c8bdf/emacs-ng_0.0.d5c8bdf_amd64.deb \
    && dpkg -i emacs-ng_0.0.d5c8bdf_amd64.deb \
    && ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
    # python language server
    && pip3 install pyright \
    # terraform
    && curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - \
    && apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    && apt-get update && apt-get install -y terraform \
    # ripgrep
    && curl -Lo ripgrep.deb "https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb" \
    && apt install -y ./ripgrep.deb
