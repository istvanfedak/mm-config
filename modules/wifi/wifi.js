'use string';

const fs = require('fs');
const express = require('express');
const graphqlHTTP = require('express-graphql');
const { buildSchema } = require('graphql');
const getWifiList = require('./lib/getWifiList');
const connectToWifi = require('./lib/connectToWifi');

const configPathName = '/usr/local/mm-config/config/config.json';
const hostname = '0.0.0.0';
const config = JSON.parse(fs.readFileSync(configPathName));
// get port from config file
const port = config['modules'].find(obj => obj.module === 'wifi')['port'];

const schema = buildSchema(`
  type Query {
    wifiList: [wifi!]!
    wifi(name: String!): wifi
    connectToWifi(name: String!, password: String!): Boolean!
  }

  type wifi {
    name: String
    signalStrength: Int
  }
  
`);

const root = {
  wifiList: () => {
    return getWifiList();
  },
  wifi: ({name}) => {
    return getWifiList().find(obj => obj.name === name);
  },
  connectToWifi: ({name, password}) => {
    return connectToWifi(name, password);
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

