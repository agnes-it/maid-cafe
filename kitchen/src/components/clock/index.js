import { h, Component } from 'preact';
import style from './style';

export default class Clock extends Component {
  constructor() {
    super();

    this.state = {
      hours: '',
      minutes: '',
      seconds: ''
    };

    this.tick = this.tick.bind(this);
  }

  componentDidMount() {
    this.tick();
  }

  tick() {
    const date = new Date;
    this.setState({
      ...this.state,
      hours: `${date.getHours()}`.padStart(2, '0'),
      minutes: `${date.getMinutes()}`.padStart(2, '0'),
      seconds: `${date.getSeconds()}`.padStart(2, '0')
    });
  }

  render() {
    setTimeout(this.tick, 100);
    return (
      <h1>{this.state.hours}:{this.state.minutes}:{this.state.seconds}</h1>
    );
  }
}
