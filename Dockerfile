# Use an official Node.js runtime as the base image
FROM node:20-alpine as build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the application code to the container
COPY . .

# Set the base path for Docker
ENV VITE_BASE_PATH=/pos-system-client/

# Build the application
RUN npm run build

# Use a lightweight web server to serve the built files
FROM nginx:alpine

# Copy the built files from the previous stage to the Nginx web server directory
COPY --from=build /app/dist /usr/share/nginx/html/pos-system-client

# Copy the custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 to access the application
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]