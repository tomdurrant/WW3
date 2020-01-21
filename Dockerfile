FROM ubuntu:19.04
MAINTAINER Tom Durrant <t.durrant@oceanum.science>

ARG COMP='Gnu'
ARG SWITCH='Ifremer1'
ARG PROGS='ww3_grid ww3_strt ww3_prnc ww3_shel ww3_multi ww3_ounf ww3_ounp'

# Upgrade and install required libs
RUN apt-get -y update &&\
    apt-get -y upgrade &&\
	apt-get -y install make gcc gfortran vim mpich \
                       libnetcdf-dev libnetcdff-dev &&\
    apt-get clean 


# Compile and install model
COPY model /source/model
COPY regtests /source/regtests
WORKDIR /source/model/bin


# Set required environment variables
ENV WWATCH3_NETCDF=NC4
ENV NETCDF_CONFIG=/usr/bin/nc-config

# Compile model
RUN ./w3_setup /source/model -q -c ${COMP} -s ${SWITCH} 
RUN ./w3_make ${PROGS}
