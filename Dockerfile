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
    tidyverse

# basic shiny
RUN install2.r --error \
    shiny \
    rmarkdown \
    shinydashboard \
    DT \
    flexdashboard

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

RUN echo "local({ options(shiny.port = 3838, shiny.host = '0.0.0.0') })" >> /usr/local/lib/R/etc/Rprofile.site

EXPOSE 3838

CMD ["R"]
