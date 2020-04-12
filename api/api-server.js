const http = require('http');

// this is the default ip of the raspberry pi
const hostname = '192.168.4.1';

// this will be the port the setting api will communicate
const port = 3000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello World');
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
