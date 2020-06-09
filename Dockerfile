FROM rocker/r-ver

LABEL maintainer "Eraldo Barbosa <eraldo.barbosa@telessauders.ufrgs.br>"

# system libraries of general use and tidyverse
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    pandoc

# system libraries for shinyjs
RUN apt-get install -y libv8-dev

# system libraries for maps
RUN apt-get install -y libgdal-dev \
    libudunits2-dev

# system libraries for pool
RUN apt-get install -y unixodbc unixodbc-dev --install-suggests
RUN apt-get install -y odbc-postgresql

# system libraries for flextable
RUN apt-get install -y libfontconfig1-dev \
    libcairo2-dev

# tidyverse
RUN install2.r --error \
    tidyverse

# basic shiny
RUN install2.r --error \
    shiny \
    shinydashboard \
    DT

# advanced shiny
RUN install2.r --error \
    shinyWidgets \
    shinyjs \
    V8 \
    shinycssloaders

# maps
RUN install2.r --error \
    leaflet \
    rgdal \
    geobr

# sql
RUN install2.r --error \
    pool \
    odbc

# plots
RUN install2.r --error \
    plotly

# rmarkdown
RUN install2.r --error \
    rmarkdown \
    flexdashboard \
    tinytex \
    flextable
    
# stats
RUN install2.r --error \
    gtsummary \
    car

# extras
RUN install2.r --error \
    janitor \
    attempt

RUN echo "local({ options(shiny.port = 3838, shiny.host = '0.0.0.0') })" >> /usr/local/lib/R/etc/Rprofile.site

EXPOSE 3838

CMD ["R"]
