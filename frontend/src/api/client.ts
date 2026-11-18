import axios from 'axios'

const remoteDefault = 'https://bookstore-backend-53v4.onrender.com/api'
const rawBase = import.meta.env.VITE_API_URL

let apiBase = '/api'
if (rawBase) {
  apiBase = rawBase.endsWith('/api') ? rawBase : `${rawBase.replace(/\/+$/, '')}/api`
} else if (typeof window !== 'undefined' && window.location.hostname !== 'localhost') {
  apiBase = remoteDefault
}

const apiClient = axios.create({
  baseURL: apiBase,
  headers: { 'Content-Type': 'application/json' },
})

apiClient.interceptors.request.use((config) => {
  const token = localStorage.getItem('accessToken')
  if (token) {
    config.headers.Authorization = `Bearer ${token}`
  }
  return config
})

apiClient.interceptors.response.use(
  (response) => response,
  async (error) => {
    if (error.response?.status === 401) {
      localStorage.removeItem('accessToken')
      window.location.href = '/login'
    }
    return Promise.reject(error)
  }
)

export default apiClient
