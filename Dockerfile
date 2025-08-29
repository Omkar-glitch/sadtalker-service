FROM paidax/dev-containers:cuda11.6-py3.8

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && \
    apt install -y \
    ffmpeg \
    wget \
    unzip \
    bzip2 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY download_models.sh .
RUN chmod +x ./download_models.sh && ./download_models.sh

RUN pip install torch==1.12.1+cu113 torchvision==0.13.1+cu113 torchaudio==0.12.1 --extra-index-url https://download.pytorch.org/whl/cu113

RUN pip install \
    fastapi[all] \
    onnxruntime-gpu \
    loguru \
    uvicorn \
    python-multipart \
    pydantic \
    runpod

RUN pip install httpcore==0.15

COPY main.py sadtalker_default.jpeg ./
COPY src/ src/
COPY handler.py .

CMD ["python", "handler.py"]
