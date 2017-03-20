import { h, Component } from 'preact';
import Clock from '../clock';
import style from './style';

export default class Header extends Component {
  render() {
    return (
      <header class={style.header}>
        <h1>Kitchen Panel</h1>
        <nav>
          <Clock />
        </nav>
      </header>
    );
  }
}
