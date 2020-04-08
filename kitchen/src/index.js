import React from "react";
import ReactDOM from "react-dom";
import App from "./components/App";
import "./styles.less";
import "./style/index.less";

var mountNode = document.getElementById("app");
ReactDOM.render(<App />, mountNode);
