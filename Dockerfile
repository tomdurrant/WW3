FROM ubuntu:18.04
MAINTAINER Tom Durrant <t.durrant@oceanum.science>

ARG PHYSICS
ARG COMP
ARG SWITCH
ARG PROGS


# Upgrade and install required libs
RUN apt-get -y update &&\
    apt-get -y upgrade &&\
	apt-get -y install make gcc gfortran vim mpich \
                       libnetcdf-dev libnetcdff-dev &&\
    apt-get clean 


# Compile and install model
COPY model /source/model
WORKDIR /source

# Set required environment variables
#ENV COMP=${comp}
#ENV SWITCH=${switch}
#ENV PROGS=$progs
ENV WWATCH3_NETCDF=NC4
ENV NETCDF_CONFIG=/usr/bin/nc-config
RUN /source/model/bin/w3_setup /source/model -q -c ${COMP} -s ${SWITCH} 
#RUN /source/model/bin/w3_make ${PROGS}
RUN /source/model/bin/w3_make ww3_grid ww3_ounf
