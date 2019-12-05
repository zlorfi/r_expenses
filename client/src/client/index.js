import axios from 'axios'
const SERVER_DOMAIN = process.env.SERVER_DOMAIN

const getHeaders = () => ({
  headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  }
})

// HTTP GET Request - Returns Resolved or Rejected Promise
export const clientGet = (path) => {
  return new Promise((resolve, reject) => {
    axios.get(path, getHeaders())
      .then(response => { resolve(response) })
      .catch(error => { reject(handleError(error)) })
  })
}
// HTTP PATCH Request - Returns Resolved or Rejected Promise
export const clientPatch = (path, data) => {
  return new Promise((resolve, reject) => {
    axios.patch(path, data, getHeaders())
      .then(response => { resolve(response) })
      .catch(error => { reject(handleError(error)) })
  })
}
// HTTP POST Request - Returns Resolved or Rejected Promise
export const clientPost = (path, data) => {
  console.log(path)
  return new Promise((resolve, reject) => {
    axios.post(path, data, getHeaders())
      .then(response => { resolve(response) })
      .catch(error => { reject(handleError(error)) })
  })
}
// HTTP DELETE Request - Returns Resolved or Rejected Promise
export const clientDelete = (path) => {
  return new Promise((resolve, reject) => {
    axios.delete(path, getHeaders())
      .then(response => { resolve(response) })
      .catch(error => { reject(handleError(error)) })
  })
}

const handleError = (error) => {
  const { status, message } = error
  switch (status) {
    case 401:
      // do something when you're unauthenticated
    case 403:
      // do something when you're unauthorized to access a resource
    case 500:
      // do something when your server exploded
    default:
      // handle normal errors with some alert or whatever
  }
  return message
}