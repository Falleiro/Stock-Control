// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyD-XfAUwc0i3wY0gwWu5APWaDcwS3eXVnQ",
  authDomain: "stock-control-pdm.firebaseapp.com",
  projectId: "stock-control-pdm",
  storageBucket: "stock-control-pdm.appspot.com",
  messagingSenderId: "598026633058",
  appId: "1:598026633058:web:5a6438ddadf2245aa8f63b",
  measurementId: "G-R31PW1BFZF"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);