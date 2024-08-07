FROM ubuntu

RUN apt-get update
RUN apt-get install -y nano libssl-dev pkg-config rustup build-essential

RUN rustup default stable

RUN apt-get install -y curl ca-certificates tzdata net-tools openssl unzip

# Install libtorch
RUN curl -L https://download.pytorch.org/libtorch/cu121/libtorch-cxx11-abi-shared-with-deps-2.1.0%2Bcu121.zip -o libtorch.zip
RUN unzip libtorch.zip -d /

RUN cargo install cargo-edit

RUN apt-get install -y x11-apps git

ENV LIBTORCH=/libtorch
ENV LD_LIBRARY_PATH="/libtorch/lib:$LD_LIBRARY_PATH"

# Copy the script to create or modify the user and group
# COPY create_user.sh /usr/local/bin/create_user.sh

# Make the script executable
# RUN chmod +x /usr/local/bin/create_user.sh

# Arguments for user and group
ARG USER_ID
ARG GROUP_ID
ARG USERNAME

# Run the script to create or modify the user and group
# RUN /usr/local/bin/create_user.sh ${USER_ID} ${GROUP_ID} ${USERNAME}

# Set working directory to user's home directory
WORKDIR /home/${USERNAME}

# Set environment variables for user
ENV USER=${USERNAME}
ENV HOME=/home/${USERNAME}

RUN usermod -l ${USERNAME} ubuntu
RUN groupmod --new-name ${USERNAME} ubuntu
RUN usermod -d /home/${USERNAME} ${USERNAME}
# RUN adduser --system --group --no-create-home ${USERNAME}

# RUN chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

# Change to the new user
USER ${USERNAME}
