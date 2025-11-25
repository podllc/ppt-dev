# ============================================================================
# PrescriberPoint Development Environment
# ============================================================================
# Unified .NET 9 development image with all required tools
# ============================================================================

FROM mcr.microsoft.com/dotnet/sdk:9.0 AS dotnet

WORKDIR /workspace

# Install Node.js 20, SQL Server tools, and common development tools
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get install -y \
    curl \
    gnupg \
    lsb-release \
    ca-certificates \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get update && apt-get install -y \
        nodejs \
        make \
        git \
        vim \
        nano \
        htop \
        tree \
        jq \
        openssh-client \
        wget \
        unzip \
        zip

# Install Microsoft SQL Server tools
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc && \
    curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y mssql-tools18 unixodbc-dev

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install GitHub CLI
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install -y gh

# Set up PATH for tools
ENV PATH="$PATH:/opt/mssql-tools18/bin"

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create user with sudo access
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && mkdir -p /etc/sudoers.d \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Install global npm packages as root
RUN --mount=type=cache,target=/root/.npm \
    npm install -g @anthropic-ai/claude-code

# Switch to user
USER $USERNAME

# Install .NET global tools for the user
RUN dotnet tool install --global dotnet-ef --version 9.0.0 \
    && dotnet tool install --global NSwag.ConsoleCore \
    && dotnet tool install --global dotnet-script \
    && dotnet tool install --global dotnet-reportgenerator-globaltool \
    && dotnet tool install --global coverlet.console

# Install Azure CLI extensions for user
RUN az extension add --name containerapp --yes || true
RUN az extension add --name application-insights --yes || true

# Set up PATH for user's dotnet tools
ENV PATH="/home/$USERNAME/.dotnet/tools:$PATH"

WORKDIR /workspace

CMD ["bash"]
