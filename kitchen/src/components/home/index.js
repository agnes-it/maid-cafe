import {h, Component} from 'preact';
import style from './style';
import { getBills } from '../../api';

export default class Home extends Component {
	constructor() {
		super();

		this.state = {
			currentBill: 1,
			bills: []
		};

		this.changeBill = this.changeBill.bind(this);
	}

	componentWillMount() {
		getBills().then(result => {
			this.setState({
				...this.state,
				bills: result.data
			});
		});
	}

	changeBill(id) {
		const bills = this.state.bills.map(bill => {
			if (bill.id === id) {
				bill.active = true;
			} else {
				bill.active = false;
			}

			return bill;
		});

		this.setState({
			...this.state,
			currentBill: id,
			bills
		});
	}

	render() {
		if (!this.state.bills.length) {
			return (
				<div class={style.home}>
					<h1>No bills yet. Maybe we can take a breath.</h1>
				</div>
			);
		}

		return (
			<div class={style.home}>
				<h1 class={style.title}>Bills</h1>
				<ul class={style.bill_list}>
					{this.state.bills.map(bill => (
						<li onClick={() => this.changeBill(bill.id)} class={bill.active
							? style.active
							: null}>
							<div class={style.table_info}>
								<h3>
									Table: {bill.table}
								</h3>
								<small>
									Start at: {(new Date(bill.start_bill)).toLocaleTimeString()}
								</small>
								<a onClick={() => {}} class={style.btn}>Finish</a>
							</div>
							<div class={style.table_desc}>
								<span>{bill.menu.join(', ')}</span>
								{bill.additional_info
									? <p>
											Info: {bill.additional_info}
										</p>
									: null}
							</div>
						</li>
					))}
				</ul>
			</div>
		);
	}
}
