FROM continuumio/anaconda3:latest

SHELL ["/bin/bash", "-c"]

RUN mkdir -p /root/airflow
WORKDIR /root/airflow

RUN apt update
RUN apt install -y build-essential

ENV PATH /opt/conda/bin:$PATH
COPY mp_env.yml .
RUN conda env create --file mp_env.yml
RUN echo "conda activate $(head -1 mp_env.yml | cut -d' ' -f2)" >> ~/.bashrc

ENV AIRFLOW_HOME /root/airflow

# worker complains that it is running as root
ENV C_FORCE_ROOT true

COPY docker-entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]

CMD ["airflow", "webserver"]
