FROM python:3.5-stretch
MAINTAINER Nofel Tiani <nofel.tiani@gmail.com>

RUN apt-get update && apt-get upgrade -y

RUN pip install -U nltk

# prepare the environment
RUN mkdir -p /infersent/dataset && mkdir -p /infersent/encoder

#Download the vectors
RUN mkdir /infersent/dataset/GloVe && \
	curl -Lo /infersent/dataset/GloVe/glove.840B.300d.zip http://nlp.stanford.edu/data/glove.840B.300d.zip && \
	unzip /infersent/dataset/GloVe/glove.840B.300d.zip -d /infersent/dataset/GloVe/
	
RUN	mkdir /infersent/dataset/fastText && \
	curl -Lo /infersent/dataset/fastText/crawl-300d-2M.vec.zip https://dl.fbaipublicfiles.com/fasttext/vectors-english/crawl-300d-2M-subword.zip && \
	unzip /infersent/dataset/fastText/crawl-300d-2M.vec.zip -d /infersent/dataset/fastText/

RUN rm -rf /infersent/dataset/GloVe/glove.840B.300d.zip && \
	rm -rf /infersent/dataset/fastText/crawl-300d-2M.vec.zip
	
# download the infersent models
RUN curl -Lo /infersent/encoder/infersent1.pickle https://dl.fbaipublicfiles.com/infersent/infersent1.pkl
RUN curl -Lo /infersent/encoder/infersent2.pickle https://dl.fbaipublicfiles.com/infersent/infersent2.pkl

COPY infersent .