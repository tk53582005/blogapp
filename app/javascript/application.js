import "@hotwired/turbo-rails"
import "./controllers"

import "trix"
import "@rails/actiontext"

import axios from "axios"
import { initArticle } from "./article"

// CSRF トークンを設定
const token = document
  .querySelector('meta[name="csrf-token"]')
  ?.getAttribute("content")

if (token) {
  axios.defaults.headers.common["X-CSRF-Token"] = token
}

document.addEventListener("turbo:load", () => {
  initArticle()
})