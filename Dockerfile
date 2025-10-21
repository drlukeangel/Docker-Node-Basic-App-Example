#This image was made for the blog post posted here:
#http://lukeangel.co/docker/dockerizing-a-node-js-web-app/
#The first thing we need to do is define from what
#image we want to build from. Here we will use the
#latest LTS (long term support) version of node available from the Docker Hub:
FROM node:lts-alpine

# Next we create a directory to hold the application
#code inside the image, this will be the working directory for your application:
WORKDIR /usr/src/app

#This image comes with Node.js and NPM already installed
#so the next thing we need to do is to install your app dependencies using the npm binary:
# Copy package files first for better layer caching
COPY package*.json ./
RUN npm install --production

#To bundle your app's source code inside the Docker image, use the COPY instruction:
#note the (.) means that everything from this level and its childern will be copied
#into the user/src/app directory of the container
# Bundle app source
COPY . .

# Run as non-root user for security
USER node

#This app accepts requests over port 8080 so now have to make sure it exposes it
EXPOSE 8080

#Last but not least, define the command to run your app using CMD which defines your runtime.
#Here we will use the basic npm start which will run node server.js to start your server:
CMD [ "npm", "start" ]
