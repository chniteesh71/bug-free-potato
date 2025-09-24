FROM node:22-alpine3.21

# Set working directory
WORKDIR .

# Copy package.json & package-lock.json first (for caching)
COPY ./src .

# Install dependencies
RUN npm ci --only=production

# Copy all source files
COPY ./src .

RUN ls -l

# Expose port
EXPOSE 3000

# Start the app
CMD ["node", "index.js"]
