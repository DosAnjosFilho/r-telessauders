FROM rocker/r-ver

LABEL maintainer "Eraldo Barbosa <eraldo.barbosa@telessauders.ufrgs.br>"

# Number of processes to use for parallel install
ENV NCPUS=4

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
    unixodbc \
    unixodbc-dev \
    odbc-postgresql

# system libraries for flextable
RUN apt-get install -y --no-install-recommends \
    libfontconfig1-dev \
    libcairo2-dev

# tidyverse
RUN install2.r --error --skipinstalled -n $NCPUS \
    tidyverse
    
# tidymodels
RUN install2.r --error --skipinstalled -n $NCPUS \
    tidymodels

# shiny
RUN install2.r --error --skipinstalled -n $NCPUS \
    shiny \
    shinydashboard \
    DT \
    waiter \
    shinyFeedback \
    shinycssloaders

# maps
RUN install2.r --error --skipinstalled -n $NCPUS \
    leaflet \
    sf

# sql
RUN install2.r --error --skipinstalled -n $NCPUS \
    pool \
    odbc

# plots
RUN install2.r --error --skipinstalled -n $NCPUS \
    plotly

# rmarkdown
RUN install2.r --error --skipinstalled -n $NCPUS \
    tinytex \
    rmarkdown \
    flexdashboard
    
# stats
RUN install2.r --error --skipinstalled -n $NCPUS \
    gtsummary \
    flextable \
    car

# extras
RUN install2.r --error --skipinstalled -n $NCPUS \
    janitor \
    attempt \
    remotes \
    kableExtra

RUN echo "local({ options(shiny.port = 3838, shiny.host = '0.0.0.0') })" >> /usr/local/lib/R/etc/Rprofile.site

EXPOSE 3838

CMD ["R"]
