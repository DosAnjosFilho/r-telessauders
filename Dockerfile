FROM openanalytics/r-base

LABEL maintainer "Eraldo Barbosa <eraldo.barbosa@telessauders.ufrgs.br>"

# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
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
RUN R -e "install.packages(c('tidyverse', 'tidymodels'), repos='https://cloud.r-project.org/')"

# basic shiny
RUN R -e "install.packages(c('shiny', 'rmarkdown', 'shinydashboard', 'DT'), repos='https://cloud.r-project.org/')"

# advanced shiny
RUN R -e "install.packages(c('shinyWidgets', 'shinyjs', 'V8'), repos='https://cloud.r-project.org/')"

# maps
RUN R -e "install.packages(c('leaflet', 'rgdal'), repos='https://cloud.r-project.org/')"

# sql
RUN R -e "install.packages(c('pool', 'odbc'), repos='https://cloud.r-project.org/')"

# plots
RUN R -e "install.packages(c('plotly'), repos='https://cloud.r-project.org/')"

# extras
RUN R -e "install.packages(c('janitor', 'attempt', 'tinytex', 'gtsummary'), repos='https://cloud.r-project.org/')"

COPY Rprofile.site /usr/lib/R/etc/

EXPOSE 3838
