# First stage: Get base node image - alpine
FROM node:alpine AS builder

# Set working directory to usr/app
WORKDIR /usr/app

# Copy over react app files
COPY ./ ./
RUN npm install
RUN npm run build

# Second stage: Get base node image - alpine
FROM node:alpine

# Run something not sure what it is
RUN yarn global add serve

# Set working direction to usr/app
WORKDIR /usr/app

# Copy over build files from first stage
COPY --from=builder /usr/app/build ./

# Run the app
CMD ["serve", "-p", "80", "-s", "."]