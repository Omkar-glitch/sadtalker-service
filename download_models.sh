#!/bin/bash

set -e

echo "Creating directories..."
mkdir -p checkpoints
mkdir -p gfpgan/weights

echo "Downloading SadTalker checkpoints..."
wget -q --show-progress -O checkpoints/BFM_Fitting.zip https://github.com/Winfredy/SadTalker/releases/download/v0.0.2/BFM_Fitting.zip
wget -q --show-progress -O checkpoints/hub.zip https://github.com/OpenTalker/SadTalker/releases/download/v0.0.2/hub.zip
wget -q --show-progress -O checkpoints/auido2exp_00300-model.pth https://github.com/OpenTalker/SadTalker/releases/download/v0.0.2/auido2exp_00300-model.pth
wget -q --show-progress -O checkpoints/facevid2vid_00189-model.pth.tar https://github.com/OpenTalker/SadTalker/releases/download/v0.0.2/facevid2vid_00189-model.pth.tar
wget -q --show-progress -O checkpoints/shape_predictor_68_face_landmarks.dat.bz2 https://github.com/OpenTalker/SadTalker/releases/download/v0.0.2/shape_predictor_68_face_landmarks.dat.bz2
wget -q --show-progress -O checkpoints/wav2lip.pth https://github.com/OpenTalker/SadTalker/releases/download/v0.0.2/wav2lip.pth
wget -q --show-progress -O checkpoints/SadTalker_V0.0.2_256.safetensors https://github.com/OpenTalker/SadTalker/releases/download/v0.0.2/SadTalker_V0.0.2_256.safetensors
wget -q --show-progress -O checkpoints/SadTalker_V0.0.2_512.safetensors https://github.com/OpenTalker/SadTalker/releases/download/v0.0.2/SadTalker_V0.0.2_512.safetensors

echo "Downloading GFPGAN models..."
wget -q --show-progress -O gfpgan/weights/GFPGANv1.4.onnx https://github.com/kenwaytis/faster-SadTalker-API/releases/download/v0.0.2-faster/GFPGANv1.4.onnx
wget -q --show-progress -O gfpgan/weights/ParseNet-latest.onnx https://github.com/kenwaytis/faster-SadTalker-API/releases/download/v0.0.2-faster/ParseNet-latest.onnx
wget -q --show-progress -O gfpgan/weights/detection_Resnet50_Final.onnx https://github.com/kenwaytis/faster-SadTalker-API/releases/download/v0.0.2-faster/detection_Resnet50_Final.onnx

echo "Extracting models..."
unzip -o checkpoints/BFM_Fitting.zip -d checkpoints/
unzip -o checkpoints/hub.zip -d checkpoints/
tar -xvf checkpoints/facevid2vid_00189-model.pth.tar -C checkpoints/
bzip2 -d checkpoints/shape_predictor_68_face_landmarks.dat.bz2

echo "Cleaning up..."
rm checkpoints/BFM_Fitting.zip
rm checkpoints/hub.zip
rm checkpoints/facevid2vid_00189-model.pth.tar
# The bzip2 command above already removes the .bz2 file

echo "Model download and extraction complete."

