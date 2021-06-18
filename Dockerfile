FROM rocker/r-ver:4.1.0

LABEL maintainer "Eraldo Barbosa <eraldo.barbosa@telessauders.ufrgs.br>"

# system libraries of general use and tidyverse
RUN apt-get update \
  && apt-get install -y --no-install-recommends \ 
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev

# system libraries for maps
RUN apt-get install -y --no-install-recommends \ 
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev

# system libraries for pool
RUN apt-get install -y --no-install-recommends \ 
    unixodbc-dev \
    odbc-postgresql

# system libraries for flextable
RUN apt-get install -y --no-install-recommends \
    libfontconfig1-dev \
    libcairo2-dev

# tidyverse
RUN install2.r --error --skipinstalled \
    tidyverse

# shiny
RUN install2.r --error --skipinstalled \
    shiny \
    shinydashboard \
    DT \
    shinyFeedback \
    shinycssloaders

# maps
RUN install2.r --error --skipinstalled \
    leaflet \
    sf

# sql
RUN install2.r --error --skipinstalled \
    pool \
    odbc

# plots
RUN install2.r --error --skipinstalled \
    plotly
    
# officer
RUN install2.r --error --skipinstalled \
    flextable \
    officer \
    mschart    

# stats
RUN install2.r --error --skipinstalled \
    gtsummary \
    janitor

# extras
RUN install2.r --error --skipinstalled \
    attempt

RUN echo "local({ options(shiny.port = 3838, shiny.host = '0.0.0.0') })" >> /usr/local/lib/R/etc/Rprofile.site

EXPOSE 3838
