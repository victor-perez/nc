RUN apt-get update \
  && apt-get install -y gpg software-properties-common \
  && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | \
    gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    tee /etc/apt/sources.list.d/nvidia-container-toolkit.list \
  && curl -O https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb \
  && dpkg -i cuda-keyring_1.1-1_all.deb \
  && add-apt-repository contrib \
  && apt-get update \
  && apt-get install -y \
    supervisor \
    nvidia-container-toolkit \
    cudnn-cuda-11 \
    ffmpeg \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /var/log/supervisord /var/run/supervisord

ADD supervisord.conf /

ENV NEXTCLOUD_UPDATE=1

CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]
