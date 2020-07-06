const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const config = require('./config')

app.use(bodyParser.json())
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
)

app.get('/', (request, response) => {
  response.json({ info: 'Hello world' })
})

app.listen(config.port, () => {
  console.log(`App running on port ${config.port}.`)
})
