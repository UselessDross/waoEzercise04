FROM node:20 as final
FROM node:20 as build


WORKDIR /app

COPY *.json ./
RUN npm install -g nodemon
RUN npm install
COPY src ./src
# Compile TypeScript files
RUN npm run tsc


FROM final

COPY --from=build . app


ARG PORT_ARG=8080
ENV PORT=$PORT_ARG
EXPOSE $PORT

CMD [ "npm", "start" ]