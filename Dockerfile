FROM node:22-alpine3.21

# Set working directory
WORKDIR /app

# Copy package.json & package-lock.json first (for caching)
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy all source files
COPY ./src .

# Expose port
EXPOSE 3000

# Start the app
CMD ["node", "index.js"]
