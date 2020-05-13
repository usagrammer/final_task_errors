class BirthdayMonth < ActiveHash::Base
  self.data = [
      {id: 1, month: '--'}, {id: 2, month: '1'}, {id: 3, month: '2'},
      {id: 4, month: '3'}, {id: 5, month: '4'}, {id: 6, month: '5'},
      {id: 7, month: '6'}, {id: 8, month: '7'}, {id: 9, month: '8'},
      {id: 10, month: '9'}, {id: 11, month: '10'}, {id: 12, month: '11'},
      {id: 13, month: '12'}
  ]
end