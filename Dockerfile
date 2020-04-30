FROM rocker/r-ver

LABEL maintainer "Eraldo Barbosa <eraldo.barbosa@telessauders.ufrgs.br>"

# system libraries of general use
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libgdal-dev

# system libraries for shinyjs
RUN apt-get install -y libv8-dev

# system libraries for pool
RUN apt-get install -y unixodbc unixodbc-dev --install-suggests
RUN apt-get install -y odbc-postgresql

# tidyverse
RUN install2.r --error \
    tidyverse \
    tidymodels

# basic shiny
RUN install2.r --error \
    shiny \
    rmarkdown \
    shinydashboard \
    DT

# advanced shiny
RUN install2.r --error \
    shinyWidgets \
    shinyjs \
    V8

# maps
RUN install2.r --error \
    leaflet \
    rgdal

# sql
RUN install2.r --error \
    pool \
    odbc

# plots
RUN install2.r --error \
    plotly

# extras
RUN install2.r --error \
    janitor \
    attempt \
    tinytex \
    gtsummary

COPY Rprofile.site /usr/lib/R/etc/

EXPOSE 3838
