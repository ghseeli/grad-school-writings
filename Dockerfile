FROM texlive/texlive:latest

# Copy your project files into the container
COPY . /data
COPY ./ReAdTeX /ReAdTeX

# Set the working directory
WORKDIR /data

# Specify the entry point (command to run when the container starts)
ENTRYPOINT ["/data/scripts/build-pdfs.sh"]