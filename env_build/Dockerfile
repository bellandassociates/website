# Use Ubuntu version 24.04 as the base
FROM ubuntu:24.04

# Set working directory
WORKDIR /workdir
COPY env_build/requirements.txt /workdir/requirements.txt

# Install dependencies
RUN apt update && apt install -y \
    curl \
    r-base r-base-dev #\
    && rm -rf /var/lib/apt/lists/*

# Specify the Quarto version using an ARG
ARG QUARTO_VERSION=1.6.8

# Download and install Quarto
RUN curl -L -O https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-arm64.deb \
&& dpkg -i quarto-${QUARTO_VERSION}-linux-arm64.deb

RUN apt-get upgrade -y && apt-get update -y \
    && apt-get install -y python3 pip \
    && pip3 install --break-system-packages -r requirements.txt \
    && quarto add --no-prompt mcanouil/quarto-iconify \
    && quarto install extension --no-prompt quarto-ext/fontawesome \
       schochastics/academicons \
    && R -e "install.packages('knitr', repos='https://cran.rstudio.com/')" \
    && R -e "install.packages('rmarkdown', repos='https://cran.rstudio.com/')"

# Expose port 8080 for Quarto preview server
EXPOSE 8080
CMD ["sh", "-c", "cd src && quarto render"]
#CMD ["sh", "-c", "quarto render src && gunicorn app:app --bind 0.0.0.0:8080"]
