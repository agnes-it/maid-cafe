import axios from 'axios';
import {BASE_API_URL} from '../config.js';

const api = axios.create({ baseURL: BASE_API_URL, timeout: 220000 });

export function getBills() {
  return api.get('bills');
}
