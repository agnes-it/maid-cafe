import {h, Component} from 'preact';
import style from './style';

export default class Home extends Component {
	constructor() {
		super();

		this.state = {
			currentBill: 1,
			bills: [
				{
					id: 1,
					table: 1,
					start_bill: new Date(),
					active: true,
					additional_info: `pouca batata frita.`,
					menu: [
						{
							item: "Combo 3"
						}, {
							item: "Milk Shake Morango"
						}
					]
				}, {
					id: 2,
					table: 2,
					start_bill: new Date(),
					active: false,
					additional_info: ``,
					menu: [
						{
							item: "Filé à Parmegiana"
						}, {
							item: "Coca-Cola 2L"
						}
					]
				}, {
					id: 3,
					table: 3,
					start_bill: new Date(),
					active: false,
					additional_info: ``,
					menu: [
						{
							item: "Mesa de Sushi"
						}, {
							item: "Coca-Cola Lata"
						}
					]
				}
			]
		};

		this.changeBill = this.changeBill.bind(this);
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
		return (
			<div class={style.home}>
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
									Start at: {bill.start_bill.toLocaleTimeString()}
								</small>
								<a onClick={() => {}} class={style.btn}>Finish</a>
							</div>
							<div class={style.table_desc}>
								<span>{bill.menu.map(choice => choice.item).join(', ')}</span>
								{bill.additional_info
									? <p>
											Informações: {bill.additional_info}
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
