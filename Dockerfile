FROM ubuntu:focal

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y r-base

RUN Rscript -e "install.packages('optparse')"
RUN Rscript -e "install.packages('readr')"



COPY run_model.R /usr/local/bin/
COPY model_test_SC1.rds /usr/local/bin/
RUN chmod a+x /usr/local/bin/run_model.R

ENTRYPOINT ["Rscript", "/usr/local/bin/run_model.R"]