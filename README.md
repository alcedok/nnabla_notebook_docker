## NNabla Docker Image

### Summary

The containers allows the user to run Sony's NNabla (Neural Network Libraries) on Jupyter-Notebooks (Python 2.7), installed using  Miniconda2, running in a ubuntu 16.04 environment. 

One uses CPU and the other uses any of the CUDA supported GPUs. The GPU extension requires nvidia-docker in order to run. 

Notebook runs on http://localhost:8888

Included in the image you will find the tutorials provided by Sony which are pulled from their git repo [sony/nnabla](https://github.com/sony/nnabla)

### How to

- Clone this repository

- Build Docker image running build.sh `bash build.sh`

 - Start container using start.sh `bash start.sh local`

 - Open browser and go to http://localhost:8888, you will be asked to enter "hellofriend"