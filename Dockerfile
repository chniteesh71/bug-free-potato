FROM node:22-alpine3.21

# Set working directory (make a dedicated folder)
WORKDIR /app

# Copy package files first for caching
COPY ./src/package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy the rest of the source code
COPY ./src .

# Verify files exist
RUN ls -l /app && ls -l /app/routes || true

# Expose port
EXPOSE 3000

# Start the app
CMD ["node", "index.js"]
