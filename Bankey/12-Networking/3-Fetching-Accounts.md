# Fetch Account

- Go over JSON `Codeable`
- Go over `Result`

Let's now create a `Codable` object for this.

[End point](https://fierce-retreat-36855.herokuapp.com/bankey/customer/1/accounts)

It returns JSON that looks like this:

```
[
  {
    "id": "1",
    "type": "Banking",
    "name": "Basic Savings",
    "amount": 929466.23,
  },
  {
    "id": "2",
    "type": "Banking",
    "name": "No-Fee All-In Chequing",
    "amount": 17562.44,
  },
  {
    "id": "3",
    "type": "CreditCard",
    "name": "Visa Avion Card",
    "amount": 412.83,
  },
  {
    "id": "4",
    "type": "CreditCard",
    "name": "Student Mastercard",
    "amount": 50.83,
  },
  {
    "id": "5",
    "type": "Investment",
    "name": "Tax-Free Saver",
    "amount": 2000.00,
  },
  {
    "id": "6",
    "type": "Investment",
    "name": "Growth Fund",
    "amount": 15000.00,
  },
 ]
```


