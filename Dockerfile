# Multi-stage build for efficient image size
FROM python:3.13.3-alpine as builder

# Install uv for faster Python package management
RUN pip install --no-cache-dir uv

# Set working directory
WORKDIR /app

# Copy dependency files
COPY pyproject.toml ./

# Create virtual environment and install dependencies
RUN uv venv /app/.venv
ENV PATH="/app/.venv/bin:$PATH"
RUN uv pip install --no-cache-dir -e .

# Production stage
FROM python:3.13.3-alpine

# Install runtime dependencies if needed
RUN apk add --no-cache bash

# Create non-root user for security
RUN adduser -D -h /home/mcp -s /bin/bash mcp

# Set working directory
WORKDIR /app

# Copy virtual environment from builder stage
COPY --from=builder /app/.venv /app/.venv

# Copy application files
COPY server.py ./
COPY pyproject.toml ./

# Set ownership to non-root user
RUN chown -R mcp:mcp /app

# Switch to non-root user
USER mcp

# Set environment variables
ENV PATH="/app/.venv/bin:$PATH"
ENV PYTHONPATH="/app"
ENV PYTHONUNBUFFERED=1

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import sys; sys.exit(0)"

# Set the entrypoint to run the MCP server
ENTRYPOINT ["python", "server.py"]
