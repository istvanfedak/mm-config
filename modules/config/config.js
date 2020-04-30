"use string";

const fs = require('fs');
const express = require('express');
const graphqlHTTP = require('express-graphql');
const { buildSchema } = require('graphql');

const configPathName = '/usr/local/mm-config/config/config.json';
const hostname = '0.0.0.0';
const config = JSON.parse(fs.readFileSync(configPathName));
// get port from config file
const port = config['modules'].find(obj => obj.module === 'config')['port'];

const schema = buildSchema(`
  type Query {
    modules: [module!]!
    module(name: String!): module
  }

  type module {
    module: String
    port: Int
  }
`);

const root = {
  modules: () => {
    return config['modules'];
  },
  module: ({name}) => {
    return config['modules'].find(obj => obj.module === name)
  }
};

const app = express();

app.use('/', graphqlHTTP({
  schema: schema,
  rootValue: root,
  graphiql: true,
}));

app.listen(port, hostname);
console.log(`Running a GraphQL API server at http://${hostname}:${port}`);

